
extension Translator {
    
    func RRR(_ mnemonic: String, _ ra: String, _ rb: String, _ rc: String) -> BuildArgs {
        
        switch mnemonic {
            
        case "add", "sub", "xor", "nand", "and", "or":
            return (ra, rb, rc, nil)
        default:
            fatalError("No such 'RRR' instruction: '\(mnemonic)' (args \(ra), \(rb), \(rc)).")
            
        }
        
    }
    
    func RR(_ mnemonic: String, _ ra: String, _ rb: String) -> BuildArgs {
        
        switch mnemonic {
            
        case "mv", "not", "neg", "ldind":
            return (ra, rb, nil, nil)
        default:
            fatalError("No such 'RR' instruction: '\(mnemonic)' (args \(ra), \(rb).")
            
        }
        
    }
    
    func RI(_ mnemonic: String, _ ra: String, _ imm: String) -> BuildArgs {
        
        switch mnemonic {
            
        case "li", "ldraw":
            return (ra, nil, nil, imm)
        default:
            fatalError("No such 'RI' instruction: '\(mnemonic)' (args \(ra), \(imm)).")
            
        }
        
    }
    
    func RIR(_ mnemonic: String, _ ra: String, _ imm: String, _ rb: String) -> BuildArgs {
        
        switch mnemonic {
            
        case "ldio":
            return (rb, ra, nil, imm)
        case "stio":
            return (nil, ra, rb, imm)
        default:
            fatalError("No such 'RIR' instruction: '\(mnemonic)' (args \(ra), \(imm), \(rb)).")
            
        }
        
    }
    
    
    
}
