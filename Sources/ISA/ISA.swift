
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
