extension Assembler {
    
    
    func lex(_ assembly: String) throws -> [Token] {
        
        let lexer = Lexer()
        let tokens = try lexer.lex(assembly).filter { $0.type != "newline" && $0.type != "comment" }
        
        tokens.forEach { print($0) }
        
        return tokens
        
    }
    
    
    func parse(_ tokens: [Token]) throws -> Labels {
        
        let parser = SLRParser()
        let tree = try parser.parse(tokens)
        
        tree?.printFullDescription(0)
        
        guard let converted = tree?.convertToLabels() else {
            fatalError("Conversion from raw `SLRNode` tree to `Labels` should not fail.")
        }
        
        return converted
        
    }
    
    
}
