
struct ISA {
    
    
    static let mapping: [String] = ["nop", "mv", "li", "ldraw", "ldind", "ldio", "stio", "add", "sub", "neg", "xor", "nand", "and", "or", "not"]
    
    
    static func opcode(_ mnemonic: String) -> Int? {
        
        for i in 0 ..< mapping.count {
            
            if mapping[i] == mnemonic {
                return i
            }
            
        }
        
        return nil
        
    }
    
    
}


extension String {
    
    /// Represents an unresolved address. Used as a placeholder for a label whose address will be resolved later.
    /// `5678` is chosen because it should be overwritten later, but it stands out if that does _not_ happen (in which case the Assembler contains a bug).
    static let unresolved = "5678"
    
}
