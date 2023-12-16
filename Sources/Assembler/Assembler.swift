
class Assembler {
    
    
    func assemble(_ assembly: String) throws {
        
        let tokens = try lex(assembly)
        let labels = try parse(tokens)
        
    }
    
    
}
