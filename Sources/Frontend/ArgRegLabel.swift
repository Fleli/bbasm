        
// ArgRegLabel.swift
// Auto-generated by SwiftParse
// See https://github.com/Fleli/SwiftParse

public class ArgRegLabel: CustomStringConvertible {
	
	let reg: String
	let label: String
	
	init(_ reg: String, _ label: String) {
		self.reg = reg
		self.label = label
	}

	public var description: String {
		reg.description + " " + ", " + label.description + " "
	}
	
}
