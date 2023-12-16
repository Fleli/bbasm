
class Translator {
    
    
    /// Provides a mapping between labels (as defined by the programmer) and their resulting index in the final list of instructions.
    private var labelIndices: [String : Int] = [:]
    
    /// A list of requests for label indices. Every time a `j` instruction, `call`, etc. refers to a label, it is added to this list.
    /// The `key: Int` represents the index of that `j` or `call` instruction, and the `value: String` is the requested label.
    private var labelIndexRequests: [Int : String] = [:]
    
    /// The `finalBuild` represents the final list of instructions.
    private var finalBuild: [Int] = []
    
    
    /// Convert a list of `Label` objects to a well-defined executable array of `Int`s.
    func translate(_ labels: Labels) -> [Int] {
        
        // --- FIRST PASS ---
        // Translate textual statements (assembly code) to corresponding machine code.
        
        for label in labels {
            
            register(label)
            
            for instruction in label.instructions {
                finalBuild += translate(instruction, finalBuild)
            }
            
        }
        
        // --- SECOND PASS ---
        // Resolve label references: Insert correct jump addresses etc.
        
        
        
        // --- RETURN ---
        
        return finalBuild
        
    }
    
    
    private func register(_ label: Label) {
        
        /// The name of the label
        let name = label.name
        
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
    
    
}
