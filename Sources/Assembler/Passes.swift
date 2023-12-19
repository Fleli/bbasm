
import Foundation

extension Assembler {
    
    
    func lex(_ assembly: String) throws -> [Token] {
        
        let lexer = Lexer()
        let tokens = try lexer.lex(assembly).filter { $0.type != "newline" && $0.type != "comment" }
        
        return tokens
        
    }
    
    
    func parse(_ tokens: [Token]) throws -> Labels {
        
        let parser = SLRParser()
        let tree = try parser.parse(tokens)
        
        guard let converted = tree?.convertToLabels() else {
            fatalError("Conversion from raw `SLRNode` tree to `Labels` should not fail.")
        }
        
        return converted
        
    }
    
    
    func translate(_ labels: Labels) -> [Int] {
        
        let translator = Translator()
        let code = translator.translate(labels, emitIndices)
        
        return code
        
    }
    
    
    func writeResult(_ code: [Int], _ destPath: String) {
        
        let fileManager = Foundation.FileManager()
        
        let string = code.reduce("") { $0 + "\($1)\n" }
        let data = string.data(using: .utf8)
        
        fileManager.createFile(atPath: destPath, contents: data)
        
    }
    
    
}
