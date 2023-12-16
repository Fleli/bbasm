
extension Translator {
    
    func translate(_ instruction: Instruction, _ finalBuild: [Int]) -> [Int] {
        
        let mnemonic = instruction.opcode
        
        /// An instruction `k` may take two words in memory: The opcode for `k` (including relevant registers), and an immediate value at the next memory address.
        /// The address of the opcode is `finalBuild.count`, so the address of the immediate value is `finalBuild.count + 1`.
        /// This last address is changed in the second pass, when label resolution is performed.
        let labelAddressRequestLocation = finalBuild.count + 1
        
        var buildArgs: BuildArgs = (nil, nil, nil, nil)
        
        switch instruction.args {
        case .argRegRegReg(let a):
            buildArgs = RRR(mnemonic, a.ra, a.rb, a.rc)
        case .argRegRegImm(let a):
            buildArgs = RRI(mnemonic, a.ra, a.rb, a.imm)
        case .argRegImmReg(let a):
            buildArgs = RIR(mnemonic, a.ra, a.imm, a.rb)
        case .argRegImm(let a):
            buildArgs = RI(mnemonic, a.reg, a.imm)
        case .argRegReg(let a):
            buildArgs = RR(mnemonic, a.ra, a.rb)
        case .argLabel(let a):
            buildArgs = L(mnemonic, a.label, labelAddressRequestLocation)
        case .argRegLabel(let a):
            buildArgs = RL(mnemonic, a.reg, a.label, labelAddressRequestLocation)
        case .argReg(let a):
            buildArgs = R(mnemonic, a.reg)
        }
        
        return build(mnemonic, buildArgs)
        
    }
    
    
}
