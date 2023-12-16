
extension Translator {
    
    func translate(_ instruction: Instruction, _ labelIndexRequests: inout [Int : String]) -> [Int] {
        
        let mnemonic = instruction.opcode
        
        var buildArgs: BuildArgs = (nil, nil, nil, nil)
        
        switch instruction.args {
        case .argRegRegReg(let a):
            buildArgs = RRR(mnemonic, a.ra, a.rb, a.rc)
        case .argRegRegImm(let argRegRegImm):
            <#code#>
        case .argRegImmReg(let argRegImmReg):
            <#code#>
        case .argRegImm(let a):
            buildArgs = RI(mnemonic, a.reg, a.imm)
        case .argRegReg(let a):
            buildArgs = RR(mnemonic, a.ra, a.rb)
        case .argLabel(let argLabel):
            <#code#>
        case .argRegLabel(let argRegLabel):
            <#code#>
        case .argReg(let argReg):
            <#code#>
        }
        
        return build(mnemonic, buildArgs)
        
    }
    
    
}
