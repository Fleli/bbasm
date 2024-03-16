
class Translator {
    
    static let trapRequestAddress = 2000
    
    static let stackStartAddress = 2048
    static let programStartAddress = 4096
    
    static let dataSegmentStartAddress = 7000
    static var dataSegmentCurrentAddress = dataSegmentStartAddress
    
    
    /// Provides a mapping between labels (as defined by the programmer) and their resulting index in the final list of instructions.
    private var labelIndices: [String : Int] = [:]
    
    /// A list of requests for label indices. Every time a `j` instruction, `call`, etc. refers to a label, it is added to this list.
    /// The `key: Int` represents the index of that `j` or `call` instruction, and the `value: String` is the requested label.
    private var labelIndexRequests: [Int : String] = [:]
    
    /// The `finalBuild` represents the final list of instructions.
    /// The first 2048 addresses are reserved for heap, "magic" variables, etc.
    private lazy var finalBuild = [Int](repeating: 0, count: Self.programStartAddress)
    
    
    /// Convert a list of `Label` objects to a well-defined executable array of `Int`s.
    func translate(_ statements: Statements, _ emitIndices: Bool) -> [Int] {
        
        // --- FIRST PASS ---
        // Translate textual statements (assembly code) to corresponding machine code.
        
        let data = statements.compactMap {
            if case .data(let segment) = $0 {
                return segment
            } else {
                return nil
            }
        }
        
        let labels = statements.compactMap {
            if case .label(let label) = $0 {
                return label
            } else {
                return nil
            }
        }
        
        for label in labels {
            
            register(label)
            
            for instruction in label.instructions {
                translate(instruction, &finalBuild)
            }
            
        }
        
        // --- SECOND PASS ---
        // Resolve label references: Insert correct jump addresses etc.
        
        for (index, label) in labelIndexRequests {
            
            guard let labelIndex = labelIndices[label] else {
                // TODO: Don't use a fatalError here.
                fatalError("Label '\(label)' was referred to, but does not exist.")
            }
            
            finalBuild[index] = labelIndex
            
        }
        
        // --- PADDING ---
        
        let missing = (1 << 15) - finalBuild.count
        finalBuild += [Int](repeating: 0, count: missing)
        
        // --- SET UP CALLER OF MAIN ---
        
        let setInitialFP = build("li", ("r7", nil, nil, "\(Self.stackStartAddress)"))     // TODO: Set up proper caller of the main function.
        let setTerminator = build("li", ("r0", nil, nil, "30")) + build("li", ("r1", nil, nil, "0")) + build("st", (nil, "r0", "r1", nil))
        let setRetAddr = build("li", ("r1", nil, nil, "2047")) + build("st", (nil, "r1", "r0", nil))
        let jumpToStart = build("jimm", (nil, nil, nil, "\(Self.programStartAddress)"))
        let initProgram = setInitialFP + setTerminator + setRetAddr + jumpToStart
        
        for i in 0 ..< initProgram.count {
            finalBuild[i] = initProgram[i]
        }
        
        // --- FILL IN DATA SECTION ---
        
        for dataGroup in data {
            
            for word in dataGroup.words {
                
                guard let int = Int(word) else {
                    fatalError("Invalid data segment content '\(word)'.")
                }
                
                includeData(int, in: &finalBuild)
                
            }
            
        }
        
        // --- EMIT INDICES IF REQUESTED ---
        
        if emitIndices {
            
            print("\nStarting index for each label")
            
            for (label, index) in labelIndices.sorted(by: {$0.value < $1.value}) {
                let indexString = "\(index)" + String(repeating: " ", count: max(1, 30 - "\(index)".count))
                print(indexString + label)
            }
            
            print("\n")
            
        }
        
        // --- RETURN ---
        
        return finalBuild
        
    }
    
    
    private func register(_ label: Label) {
        
        /// The name of the label
        let name = label.label
        
        /// The index corresponding to the start of the label.
        /// If `n` instructions are already built, this label's instructions will begin at index `n`.
        let index = finalBuild.count
        
        /// If a label with the same name is already defined, we capture this label's index as `existing`. In this case, multiple labels with the same name are defined. Therefore, an error is submitted.
        if let existing = labelIndices[name] {
            // TODO: Submit an error instead of `fatalError()`-ing.
            fatalError("The label '\(name)' is declared multiple times\n\t1st encounter: Index \(existing)\n\t2nd encounter: Index \(index)")
        }
        
        /// We store the starting index of the current label, so it's ready for the second pass.
        labelIndices[name] = index
        
    }
    
    
    func requestIndex(for label: String, at location: Int) {
        labelIndexRequests[location] = label
    }
    
    
    func includeData(_ data: Int, in finalBuild: inout [Int]) {
        
        finalBuild[Self.dataSegmentCurrentAddress] = data
        
        Self.dataSegmentCurrentAddress += 1
        
    }
    
    
}
