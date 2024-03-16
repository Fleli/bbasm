
import Foundation
import ArgumentParser

struct Assemble: ParsableCommand {
    
    
    @ArgumentParser.Argument(help: "The .bba file's path.")
    var srcPath: String
    
    @ArgumentParser.Argument(help: "The machine code path.")
    var destPath: String
    
    @ArgumentParser.Flag(help: "Get a list of start indices for each label.")
    var emitIndices: Bool = false
    
    @ArgumentParser.Flag(help: "Print assemble time and input length.")
    var printStats: Bool = false
    
    
    func run() throws {
        
        Swift.print("Start run")
        
        let assembly = try String(contentsOfFile: srcPath)
        let assembler = Assembler(emitIndices, printStats)
        try assembler.assemble(assembly, destPath)
        
    }
    
}
