
typealias BuildArgs = (dest: String?, srcA: String?, srcB: String?, imm: String?)

func build(_ mnemonic: String, _ buildArgs: BuildArgs) -> [Int] {
    
    let dest = buildArgs.dest
    let srcA = buildArgs.srcA
    let srcB = buildArgs.srcB
    let imm = buildArgs.imm
    
    /// The `opcodeIndex` is the number of the opcode, from `0` for the first and up to (potentially) `127` for the last.
    guard let opcodeIndex = ISA.opcode(mnemonic) else {
        // TODO: Submit error.
        return []
    }
    
    /// The `opcodeBitPattern` is `OR`ed with the register indices to form the actual, decodable, bit pattern of the instruction.
    let opcodeBitPattern = opcodeIndex << 9
    
    /// The first source register's index, prepared to be assembled into a complete instruction
    let srcABitPattern = regIndex(srcA) << 6
    
    /// The second source register's index, prepared to be assembled into a complete instruction
    let srcBBitPattern = regIndex(srcB) << 3
    
    /// The destination register's index, prepared to be assembled into a complete instruction
    let destBitPattern = regIndex(dest)
    
    /// The actual instruction, decodable by the CPU's control unit.
    let instruction = opcodeBitPattern | srcABitPattern | srcBBitPattern | destBitPattern
    
    
    if let imm, let immediate = Int(imm) {
        // TODO: Verify that the immediate is within the 16-bit bounds. 
        // Decide later how these work (e.g.: Are negative integers allowed? Are positive numbers larger than 2^15 allowed? ...)
        return [instruction, immediate]
    }
    
    
    return [instruction]
    
}

/// Convert an assembly register index on the form `rx` for `x` in `{0, 1, ..., 7}` to just `x` as an `Int`.
func regIndex(_ r: String?) -> Int {
    
    guard let last = r?.last, let index = Int("\(last)") else {
        // If `r` is nil, we just return 0 (as a convention).
        return 0
    }
    
    // TODO: Remove this assertion later.
    assert(0 <= index && index <= 7)
    
    return index
    
}
