
// Converters.swift
// Auto-generated by SwiftParse
// See https://github.com/Fleli/SwiftParse

public extension SLRNode {
    
    func convertToStatements() -> Statements {
        
        if children.count == 0 {
            return []
        }
        
        if children.count == 1 {
            return [children[0].convertToStatement()]
        }
        
        if children.count == 2 {
            return children[0].convertToStatements() + [children[1].convertToStatement()]
        }
        
        if children.count == 3 {
            return children[0].convertToStatements() + [children[2].convertToStatement()]
        }
        
        fatalError()
        
    }
    
}
public extension SLRNode {
    
    func convertToWords() -> Words {
        
        if children.count == 0 {
            return []
        }
        
        if children.count == 1 {
            return [children[0].convertToTerminal()]
        }
        
        if children.count == 2 {
            return children[0].convertToWords() + [children[1].convertToTerminal()]
        }
        
        if children.count == 3 {
            return children[0].convertToWords() + [children[2].convertToTerminal()]
        }
        
        fatalError()
        
    }
    
}
public extension SLRNode {
    
    func convertToInstructions() -> Instructions {
        
        if children.count == 0 {
            return []
        }
        
        if children.count == 1 {
            return [children[0].convertToInstruction()]
        }
        
        if children.count == 2 {
            return children[0].convertToInstructions() + [children[1].convertToInstruction()]
        }
        
        if children.count == 3 {
            return children[0].convertToInstructions() + [children[2].convertToInstruction()]
        }
        
        fatalError()
        
    }
    
}
public extension SLRNode {

	func convertToStatement() -> Statement {
		
        if type == "Statement" && children[0].type == "Label" {
            let nonTerminalNode = children[0].convertToLabel()
            return Statement.label(nonTerminalNode)
        }
	
        if type == "Statement" && children[0].type == "Data" {
            let nonTerminalNode = children[0].convertToData()
            return Statement.data(nonTerminalNode)
        }
	
        fatalError()
        
    }

}

public extension SLRNode {

	func convertToData() -> Data {
		
		if type == "Data" && children.count == 4 && children[0].type == "datasegment" && children[1].type == "{" && children[2].type == "Words" && children[3].type == "}" {
			let arg2 = children[2].convertToWords()
			return .init(arg2)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToLabel() -> Label {
		
		if type == "Label" && children.count == 3 && children[0].type == "label" && children[1].type == ":" && children[2].type == "Instructions" {
			let arg0 = children[0].convertToTerminal()
			let arg2 = children[2].convertToInstructions()
			return .init(arg0, arg2)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToInstruction() -> Instruction {
		
		if type == "Instruction" && children.count == 2 && children[0].type == "identifier" && children[1].type == "Args" {
			let arg0 = children[0].convertToTerminal()
			let arg1 = children[1].convertToArgs()
			return .init(arg0, arg1)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToArgs() -> Args {
		
        if type == "Args" && children[0].type == "ArgRegRegReg" {
            let nonTerminalNode = children[0].convertToArgRegRegReg()
            return Args.argRegRegReg(nonTerminalNode)
        }
	
        if type == "Args" && children[0].type == "ArgRegRegImm" {
            let nonTerminalNode = children[0].convertToArgRegRegImm()
            return Args.argRegRegImm(nonTerminalNode)
        }
	
        if type == "Args" && children[0].type == "ArgRegImmReg" {
            let nonTerminalNode = children[0].convertToArgRegImmReg()
            return Args.argRegImmReg(nonTerminalNode)
        }
	
        if type == "Args" && children[0].type == "ArgRegImm" {
            let nonTerminalNode = children[0].convertToArgRegImm()
            return Args.argRegImm(nonTerminalNode)
        }
	
        if type == "Args" && children[0].type == "ArgRegReg" {
            let nonTerminalNode = children[0].convertToArgRegReg()
            return Args.argRegReg(nonTerminalNode)
        }
	
        if type == "Args" && children[0].type == "ArgLabel" {
            let nonTerminalNode = children[0].convertToArgLabel()
            return Args.argLabel(nonTerminalNode)
        }
	
        if type == "Args" && children[0].type == "ArgRegLabel" {
            let nonTerminalNode = children[0].convertToArgRegLabel()
            return Args.argRegLabel(nonTerminalNode)
        }
	
        if type == "Args" && children[0].type == "ArgReg" {
            let nonTerminalNode = children[0].convertToArgReg()
            return Args.argReg(nonTerminalNode)
        }
	
        if type == "Args" && children[0].type == "ArgLabelLabel" {
            let nonTerminalNode = children[0].convertToArgLabelLabel()
            return Args.argLabelLabel(nonTerminalNode)
        }
	
        fatalError()
        
    }

}

public extension SLRNode {

	func convertToArgRegRegReg() -> ArgRegRegReg {
		
		if type == "ArgRegRegReg" && children.count == 5 && children[0].type == "register" && children[1].type == "," && children[2].type == "register" && children[3].type == "," && children[4].type == "register" {
			let arg0 = children[0].convertToTerminal()
			let arg2 = children[2].convertToTerminal()
			let arg4 = children[4].convertToTerminal()
			return .init(arg0, arg2, arg4)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToArgRegRegImm() -> ArgRegRegImm {
		
		if type == "ArgRegRegImm" && children.count == 5 && children[0].type == "register" && children[1].type == "," && children[2].type == "register" && children[3].type == "," && children[4].type == "literal" {
			let arg0 = children[0].convertToTerminal()
			let arg2 = children[2].convertToTerminal()
			let arg4 = children[4].convertToTerminal()
			return .init(arg0, arg2, arg4)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToArgRegImmReg() -> ArgRegImmReg {
		
		if type == "ArgRegImmReg" && children.count == 5 && children[0].type == "register" && children[1].type == "," && children[2].type == "literal" && children[3].type == "," && children[4].type == "register" {
			let arg0 = children[0].convertToTerminal()
			let arg2 = children[2].convertToTerminal()
			let arg4 = children[4].convertToTerminal()
			return .init(arg0, arg2, arg4)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToArgRegImm() -> ArgRegImm {
		
		if type == "ArgRegImm" && children.count == 3 && children[0].type == "register" && children[1].type == "," && children[2].type == "literal" {
			let arg0 = children[0].convertToTerminal()
			let arg2 = children[2].convertToTerminal()
			return .init(arg0, arg2)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToArgRegReg() -> ArgRegReg {
		
		if type == "ArgRegReg" && children.count == 3 && children[0].type == "register" && children[1].type == "," && children[2].type == "register" {
			let arg0 = children[0].convertToTerminal()
			let arg2 = children[2].convertToTerminal()
			return .init(arg0, arg2)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToArgReg() -> ArgReg {
		
		if type == "ArgReg" && children.count == 1 && children[0].type == "register" {
			let arg0 = children[0].convertToTerminal()
			return .init(arg0)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToArgLabel() -> ArgLabel {
		
		if type == "ArgLabel" && children.count == 1 && children[0].type == "label" {
			let arg0 = children[0].convertToTerminal()
			return .init(arg0)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToArgRegLabel() -> ArgRegLabel {
		
		if type == "ArgRegLabel" && children.count == 3 && children[0].type == "register" && children[1].type == "," && children[2].type == "label" {
			let arg0 = children[0].convertToTerminal()
			let arg2 = children[2].convertToTerminal()
			return .init(arg0, arg2)
		}
		
		fatalError()
		
	}

}

public extension SLRNode {

	func convertToArgLabelLabel() -> ArgLabelLabel {
		
		if type == "ArgLabelLabel" && children.count == 3 && children[0].type == "label" && children[1].type == "," && children[2].type == "label" {
			let arg0 = children[0].convertToTerminal()
			let arg2 = children[2].convertToTerminal()
			return .init(arg0, arg2)
		}
		
		fatalError()
		
	}

}


public extension SLRNode {

    func convertToTerminal() -> String {
    
        if let token = self.token {
            return token.content
        }
        
        fatalError()
    
    }
    
}
