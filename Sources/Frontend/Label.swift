        
// Label.swift
// Auto-generated by SwiftParse
// See https://github.com/Fleli/SwiftParse

public class Label: CustomStringConvertible {
	
	let label: String
	let instructions: Instructions
	
	init(_ label: String, _ instructions: Instructions) {
		self.label = label
		self.instructions = instructions
	}

	public var description: String {
		label.description + " " + ": " + instructions.description + " "
	}
	
}
