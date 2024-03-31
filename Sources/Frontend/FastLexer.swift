
extension String {
    
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    subscript(inclusiveStart: Int, exclusiveEnd: Int) -> String {
        return String(self[index(startIndex, offsetBy: inclusiveStart) ..< index(startIndex, offsetBy: exclusiveEnd)])
    }
    
    static let dataSegmentInitializer = ".DATA"
    
}

extension Character {
    var isOperator: Bool {
        return "+-:,[]@{}".contains(self)
    }
}

// Regions aren't really used in the compiler even though the Token type supports them.
// Thus, the FastLexer ignores them for now.
extension Region {
    static let null = Region(0, 0, 0, 0)
}

class FastLexer {
    
    var index: Int = 0
    var input: String = ""
    
    var tokens: [Token] = []
    
    func lex(_ input: String) throws -> [Token] {
        
        self.prepare(input)
        
        while (index < input.count) {
            try findNextToken()
        }
        
        return self.tokens
        
    }
    
    private func prepare(_ input: String) {
        
        self.index = 0
        self.input = input
        self.tokens = []
        
    }
    
    private func findNextToken() throws {
        
        let char = input[index]
        
        if char.isNumber || char == "-" {
            
            tokens.append( lexNumber() )
            
        } else if char == "@" {
            
            tokens.append( lexLabel() )
            
        } else if char.isLetter || char == "_" {
            
            tokens.append( lexIdentifier() )
            
        } else if char == ";" {
            
            tokens.append( lexComment() )
            
        } else if char.isOperator {
            
            tokens.append( lexOperator() )
            
        } else if index <= input.count - String.dataSegmentInitializer.count  &&  input[index, index + String.dataSegmentInitializer.count] == String.dataSegmentInitializer {
            
            tokens.append( Token("datasegment", String.dataSegmentInitializer, .null) )
            index += String.dataSegmentInitializer.count
            
        } else {
            
            switch char {
            case " ", " ", "\t", "\n":
                index += 1
            default:
                throw LexError.invalidCharacter(char, tokens)
            }
            
        }
        
    }
    
    private func matchWhileSatisfied( _ function: (Character) -> (Bool) ) -> String {
        
        let start = index
        
        while (index < input.count)  &&  function(input[index]) {
            index += 1
        }
        
        return input[start, index]
        
    }
    
    private func lexNumber() -> Token {
        
        let isNegative = (input[index] == "-")
        index = (isNegative) ? (index + 1) : (index)
        
        let content = (isNegative ? "-" : "") + matchWhileSatisfied {
            $0.isNumber
        }
        
        return Token("literal", content, .null)
        
    }
    
    private func lexLabel() -> Token {
        
        let content = matchWhileSatisfied {
            $0.isLetter || $0.isNumber || "@_".contains($0)
        }
        
        return Token("label", content, .null)
        
    }
    
    private func lexIdentifier() -> Token {
        
        let content = matchWhileSatisfied {
            $0.isLetter || $0.isNumber || $0 == "_"
        }
        
        let type: String
        
        if content.count == 2  &&  content[0] == "r", let int = Int(content[1, 2]), 0 <= int && int <= 7 {
            type = "register"
        } else {
            type = "identifier"
        }
        
        return Token(type, content, .null)
        
    }
    
    private func lexComment() -> Token {
        
        let content = matchWhileSatisfied {
            $0 != "\n"
        }
        
        return Token("comment", content, .null)
        
    }
    
    private func lexOperator() -> Token {
        
        let content = input[index]
        index += 1
        
        return Token("\(content)", "\(content)", .null)
        
    }
    
}
