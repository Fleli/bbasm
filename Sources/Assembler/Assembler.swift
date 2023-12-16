
class Assembler {
    
    
    func assemble(_ assembly: String, _ destPath: String) throws {
        
        let tokens = try lex(assembly)
        let labels = try parse(tokens)
        let code = translate(labels)
        
        writeResult(code, destPath)
        
    }
    
    
}
