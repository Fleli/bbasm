
extension Translator {
    
    
    func translate(_ instruction: Instruction, _ finalBuild: inout [Int]) {
        
        let mnemonic = instruction.opcode
        
        /// An instruction `k` may take two words in memory: The opcode for `k` (including relevant registers), and an immediate value at the next memory address.
        /// The address of the opcode is `finalBuild.count`, so the address of the immediate value is `finalBuild.count + 1`.
        /// This last address is changed in the second pass, when label resolution is performed.
        let labelAddressRequestLocation = finalBuild.count + 1
        
        var buildArgs: BuildArgs = (nil, nil, nil, nil)
        
        var realInstruction = true
        
        switch instruction.args {
        case .argRegRegReg(let a):
            buildArgs = RRR(mnemonic, a.ra, a.rb, a.rc)
        case .argRegRegImm(let a):
            buildArgs = RRI(mnemonic, a.ra, a.rb, a.imm)
        case .argRegImmReg(let a):
            buildArgs = RIR(mnemonic, a.ra, a.imm, a.rb)
        case .argRegImm(let a):
            
            realInstruction = (mnemonic != "lidata")
            
            if realInstruction {
                buildArgs = RI(mnemonic, a.reg, a.imm)
            } else {
                resolveDataSegmentReference(a.reg, a.imm, &finalBuild)
            }
            
            
        case .argRegReg(let a):
            buildArgs = RR(mnemonic, a.ra, a.rb)
        case .argLabel(let a):
            buildArgs = L(mnemonic, a.label, labelAddressRequestLocation)
        case .argRegLabel(let a):
            buildArgs = RL(mnemonic, a.reg, a.label, labelAddressRequestLocation)
        case .argReg(let a):
            buildArgs = R(mnemonic, a.reg)
        case .argLabelLabel(let a):
            realInstruction = false
            resolveCall(mnemonic, a, &finalBuild)
        }
        
        if realInstruction {
            finalBuild += build(mnemonic, buildArgs)
        }
        
    }
    
    
    private func resolveCall(_ mnemonic: String, _ a: ArgLabelLabel, _ finalBuild: inout [Int]) {
        
        // No other such instructions than `call` exist.
        guard mnemonic == "call" else {
            fatalError("Unrecognized instruction \(mnemonic).")
        }
        
        requestAndInsertReturnAddress(a.ret, &finalBuild)
        requestAndInsertJumpToEntry(a.callee, &finalBuild)
        
    }
    
    
    private func resolveDataSegmentReference(_ register: String, _ imm: String, _ finalBuild: inout [Int]) {
        
        guard let imm = Int(imm) else {
            fatalError("'\(imm)' is not an integer.")
        }
        
        let dataSegmentAddress = String( (imm + Self.dataSegmentCurrentAddress) % (._16_bit_modulus) )
        
        translate(Instruction("li", Args.argRegImm(ArgRegImm(register, dataSegmentAddress))), &finalBuild)
        
    }
    
    
    private func requestAndInsertReturnAddress(_ returnLabel: String, _ finalBuild: inout [Int]) {
        
        // Create an `li` instruction. Request the address of the return label (in pass 2)
        let li = Instruction("li", .argRegImm(ArgRegImm("r0", .unresolved)))
        translate(li, &finalBuild)
        requestIndex(for: returnLabel, at: finalBuild.count - 1)
        
        // Then store this number at fp - 1
        let stio = Instruction("stio", .argRegImmReg(ArgRegImmReg("r7", "-1", "r0")))
        translate(stio, &finalBuild)
        
    }
    
    
    private func requestAndInsertJumpToEntry(_ entryLabel: String, _ finalBuild: inout [Int]) {
        
        // Load the address of the function's entry label. Request this address from the translator.
        let li = Instruction("li", .argRegImm(ArgRegImm("r0", .unresolved)))
        translate(li, &finalBuild)
        requestIndex(for: entryLabel, at: finalBuild.count - 1)
        
        // Then jump to this address
        let j = Instruction("j", .argReg(ArgReg("r0")))
        translate(j, &finalBuild)
        
    }
    
    
}
