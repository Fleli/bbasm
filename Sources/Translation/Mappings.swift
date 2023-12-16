
extension Translator {
    
    func RRR(_ mnemonic: String, _ ra: String, _ rb: String, _ rc: String) -> BuildArgs {
        
        switch mnemonic {
            
        case "add", "sub", "xor", "nand", "and", "or":
            return (ra, rb, rc, nil)
        default:
            fatalError("No such 'RRR' instruction: '\(mnemonic)' (args \(ra), \(rb), \(rc)).")
            
        }
        
    }
    
    func RRI(_ mnemonic: String, _ ra: String, _ rb: String, _ imm: String) -> BuildArgs {
        
        switch mnemonic {
            
        case "ldio", "addi":
            return (ra, rb, nil, imm)
        default:
            fatalError("No such 'RRI' instruction: '\(mnemonic)' (args \(ra), \(rb), \(imm)).")
            
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
            
        case "stio":
            return (nil, ra, rb, imm)
        default:
            fatalError("No such 'RIR' instruction: '\(mnemonic)' (args \(ra), \(imm), \(rb)).")
            
        }
        
    }
    
    func L(_ mnemonic: String, _ label: String, _ request: Int) -> BuildArgs {
        
        switch mnemonic {
            
        case "jimm":
            requestIndex(for: label, at: request)
            return (nil, nil, nil, .unresolved)
        default:
            fatalError("No such 'L' instruction: '\(mnemonic)' (args: \(label)).")
            
        }
        
    }
    
    func RL(_ mnemonic: String, _ reg: String, _ label: String, _ request: Int) -> BuildArgs {
        
        switch mnemonic {
            
        case "jnz":
            requestIndex(for: label, at: request)
            return (nil, reg, nil, .unresolved)
        default:
            fatalError("No such 'RL' instruction: '\(mnemonic)' (args: \(reg) \(label)).")
            
        }
        
    }
    
    func R(_ mnemonic: String, _ reg: String) -> BuildArgs {
        
        switch mnemonic {
            
        case "j":
            return (nil, reg, nil, nil)
        default:
            fatalError("No such 'R' instruction: '\(mnemonic)' (args: \(reg)).")
            
        }
        
    }
    
}
