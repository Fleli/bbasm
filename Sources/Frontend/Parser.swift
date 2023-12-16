
// Parser.swift
// Auto-generated by SwiftSLR
// See https://github.com/Fleli/SwiftSLR

class SLRParser {

    private var index: Int = 0
    private var input: [Token] = []
    private var stack: [SLRNode] = []
    private var states: [() throws -> ()] = []
    
    private var accepted = false
    
    private var notExhausted: Bool { index < input.count }
    
    func parse(_ tokens: [Token]) throws -> SLRNode? {
        
        self.index = 0
        self.input = tokens
        
        self.accepted = false
        
        self.stack = []
        self.states = [state_0]
        
        repeat {
            
            try states[states.count - 1]()
            
        } while !accepted
        
        if stack.count != 1 {
            print(stack)
            return nil
        }
        
        return stack[0].children[0]
        
    }
    
    private func shift() {
        
        let token = input[index]
        let slrNode = SLRNode(token)
        stack.append(slrNode)
        index += 1
        
    }
    
    private func reduce(_ numberOfStates: Int, to nonTerminal: String) {
        
        let children = [SLRNode](stack[stack.count - numberOfStates ..< stack.count])
        
        let newNode = SLRNode(nonTerminal, children)
        
        stack.removeLast(numberOfStates)
        states.removeLast(numberOfStates)
        
        stack.append(newNode)
        
    }
    
    private func topOfStackIsToken(_ type: String) -> Bool {
        return topOfStackIsAmong([type])
    }
    
    private func topOfStackIsAmong(_ terminals: Set<String?>) -> Bool {
        
        guard notExhausted else {
            return terminals.contains(nil)
        }
        
        return terminals.contains(input[index].type)
        
    }
    
    private func topOfStackIsNonTerminal(_ type: String) -> Bool {
        
        guard stack.count > 0 else {
            return false
        }
        
        let top = stack[stack.count - 1]
        
        if top.token != nil {
            return false
        }
        
        return type == top.type
        
    }
    
    private func pushState(_ newState: @escaping () throws -> ()) {
        states.append(newState)
    }

	private func state_0() throws {

        if topOfStackIsNonTerminal("Label") {
            pushState(state_29)
            return
        }
        
        if topOfStackIsNonTerminal("Labels") {
            pushState(state_1)
            return
        }
        
        if topOfStackIsToken("label") {
            shift()
            pushState(state_3)
            return
        }
        
        
        if topOfStackIsAmong([Optional("label"), nil]) {
            reduce(0, to: "Labels")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("SwiftSLRMain", input[index].content, "Labels")
        } else {
            throw ParseError.abruptEnd("SwiftSLRMain", "Labels")
        }
        
	}
	
	private func state_1() throws {

        if topOfStackIsNonTerminal("Label") {
            pushState(state_2)
            return
        }
        
        if topOfStackIsToken("label") {
            shift()
            pushState(state_3)
            return
        }
        
        
        if topOfStackIsAmong([nil]) {
            reduce(1, to: "SwiftSLRMain")
			accepted = true
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Labels", input[index].content, "Label")
        } else {
            throw ParseError.abruptEnd("Labels", "Label")
        }
        
	}
	
	private func state_2() throws {

        
        if topOfStackIsAmong([Optional("label"), nil]) {
            reduce(2, to: "Labels")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Labels", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Labels", "reduction")
        }
        
	}
	
	private func state_3() throws {

        if topOfStackIsToken(":") {
            shift()
            pushState(state_4)
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Label", input[index].content, ":")
        } else {
            throw ParseError.abruptEnd("Label", ":")
        }
        
	}
	
	private func state_4() throws {

        if topOfStackIsNonTerminal("Instruction") {
            pushState(state_5)
            return
        }
        
        if topOfStackIsNonTerminal("Instructions") {
            pushState(state_6)
            return
        }
        
        if topOfStackIsToken("identifier") {
            shift()
            pushState(state_8)
            return
        }
        
        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(0, to: "Instructions")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Instructions", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Instructions", "reduction")
        }
        
	}
	
	private func state_5() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "Instructions")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Instructions", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Instructions", "reduction")
        }
        
	}
	
	private func state_6() throws {

        if topOfStackIsNonTerminal("Instruction") {
            pushState(state_7)
            return
        }
        
        if topOfStackIsToken("identifier") {
            shift()
            pushState(state_8)
            return
        }
        
        
        if topOfStackIsAmong([Optional("label"), nil]) {
            reduce(3, to: "Label")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Instructions", input[index].content, "Instruction")
        } else {
            throw ParseError.abruptEnd("Instructions", "Instruction")
        }
        
	}
	
	private func state_7() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(2, to: "Instructions")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Instructions", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Instructions", "reduction")
        }
        
	}
	
	private func state_8() throws {

        if topOfStackIsNonTerminal("ArgRegImmReg") {
            pushState(state_15)
            return
        }
        
        if topOfStackIsNonTerminal("ArgRegRegReg") {
            pushState(state_17)
            return
        }
        
        if topOfStackIsNonTerminal("Args") {
            pushState(state_10)
            return
        }
        
        if topOfStackIsNonTerminal("ArgRegReg") {
            pushState(state_9)
            return
        }
        
        if topOfStackIsNonTerminal("ArgReg") {
            pushState(state_12)
            return
        }
        
        if topOfStackIsNonTerminal("ArgLabel") {
            pushState(state_14)
            return
        }
        
        if topOfStackIsNonTerminal("ArgRegRegImm") {
            pushState(state_13)
            return
        }
        
        if topOfStackIsNonTerminal("ArgRegImm") {
            pushState(state_11)
            return
        }
        
        if topOfStackIsNonTerminal("ArgRegLabel") {
            pushState(state_16)
            return
        }
        
        if topOfStackIsToken("register") {
            shift()
            pushState(state_19)
            return
        }
        
        if topOfStackIsToken("label") {
            shift()
            pushState(state_18)
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Args", input[index].content, "ArgRegImmReg")
        } else {
            throw ParseError.abruptEnd("Args", "ArgRegImmReg")
        }
        
	}
	
	private func state_9() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "Args")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Args", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Args", "reduction")
        }
        
	}
	
	private func state_10() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(2, to: "Instruction")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Instruction", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Instruction", "reduction")
        }
        
	}
	
	private func state_11() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "Args")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Args", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Args", "reduction")
        }
        
	}
	
	private func state_12() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "Args")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Args", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Args", "reduction")
        }
        
	}
	
	private func state_13() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "Args")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Args", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Args", "reduction")
        }
        
	}
	
	private func state_14() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "Args")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Args", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Args", "reduction")
        }
        
	}
	
	private func state_15() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "Args")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Args", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Args", "reduction")
        }
        
	}
	
	private func state_16() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "Args")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Args", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Args", "reduction")
        }
        
	}
	
	private func state_17() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "Args")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Args", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Args", "reduction")
        }
        
	}
	
	private func state_18() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(1, to: "ArgLabel")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgLabel", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("ArgLabel", "reduction")
        }
        
	}
	
	private func state_19() throws {

        if topOfStackIsToken(",") {
            shift()
            pushState(state_20)
            return
        }
        
        
        if topOfStackIsAmong([Optional("label"), Optional("identifier"), nil]) {
            reduce(1, to: "ArgReg")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegRegImm", input[index].content, ",")
        } else {
            throw ParseError.abruptEnd("ArgRegRegImm", ",")
        }
        
	}
	
	private func state_20() throws {

        if topOfStackIsToken("literal") {
            shift()
            pushState(state_21)
            return
        }
        
        if topOfStackIsToken("register") {
            shift()
            pushState(state_25)
            return
        }
        
        if topOfStackIsToken("label") {
            shift()
            pushState(state_24)
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegImm", input[index].content, "literal")
        } else {
            throw ParseError.abruptEnd("ArgRegImm", "literal")
        }
        
	}
	
	private func state_21() throws {

        if topOfStackIsToken(",") {
            shift()
            pushState(state_22)
            return
        }
        
        
        if topOfStackIsAmong([Optional("label"), Optional("identifier"), nil]) {
            reduce(3, to: "ArgRegImm")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegImm", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("ArgRegImm", "reduction")
        }
        
	}
	
	private func state_22() throws {

        if topOfStackIsToken("register") {
            shift()
            pushState(state_23)
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegImmReg", input[index].content, "register")
        } else {
            throw ParseError.abruptEnd("ArgRegImmReg", "register")
        }
        
	}
	
	private func state_23() throws {

        
        if topOfStackIsAmong([Optional("identifier"), Optional("label"), nil]) {
            reduce(5, to: "ArgRegImmReg")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegImmReg", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("ArgRegImmReg", "reduction")
        }
        
	}
	
	private func state_24() throws {

        
        if topOfStackIsAmong([nil, Optional("identifier"), Optional("label")]) {
            reduce(3, to: "ArgRegLabel")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegLabel", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("ArgRegLabel", "reduction")
        }
        
	}
	
	private func state_25() throws {

        if topOfStackIsToken(",") {
            shift()
            pushState(state_26)
            return
        }
        
        
        if topOfStackIsAmong([Optional("identifier"), nil, Optional("label")]) {
            reduce(3, to: "ArgRegReg")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegRegImm", input[index].content, ",")
        } else {
            throw ParseError.abruptEnd("ArgRegRegImm", ",")
        }
        
	}
	
	private func state_26() throws {

        if topOfStackIsToken("literal") {
            shift()
            pushState(state_27)
            return
        }
        
        if topOfStackIsToken("register") {
            shift()
            pushState(state_28)
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegRegImm", input[index].content, "literal")
        } else {
            throw ParseError.abruptEnd("ArgRegRegImm", "literal")
        }
        
	}
	
	private func state_27() throws {

        
        if topOfStackIsAmong([Optional("identifier"), Optional("label"), nil]) {
            reduce(5, to: "ArgRegRegImm")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegRegImm", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("ArgRegRegImm", "reduction")
        }
        
	}
	
	private func state_28() throws {

        
        if topOfStackIsAmong([Optional("label"), nil, Optional("identifier")]) {
            reduce(5, to: "ArgRegRegReg")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("ArgRegRegReg", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("ArgRegRegReg", "reduction")
        }
        
	}
	
	private func state_29() throws {

        
        if topOfStackIsAmong([Optional("label"), nil]) {
            reduce(1, to: "Labels")
            return
        }
        
        if index < input.count {
            throw ParseError.unexpected("Labels", input[index].content, "reduction")
        } else {
            throw ParseError.abruptEnd("Labels", "reduction")
        }
        
	}
	

}

public enum ParseError: Error {
    case unexpected(_ nonTerminal: String, _ content: String, _ expected: String)
    case abruptEnd(_ nonTerminal: String, _ expected: String)
}

public class SLRNode: CustomStringConvertible {
    
    public let type: String
    public let children: [SLRNode]
    
    public let token: Token?
    
    public var description: String { "\(type)" }
    
    public func printFullDescription(_ indent: Int) {
        print(String(repeating: "|   ", count: indent) + type)
        for child in children {
            child.printFullDescription(indent + 1)
        }
    }
    
    init(_ type: String, _ children: [SLRNode]) {
        self.type = type
        self.children = children
        self.token = nil
    }
    
    init(_ token: Token) {
        self.type = token.type
        self.children = []
        self.token = token
    }
    
}


