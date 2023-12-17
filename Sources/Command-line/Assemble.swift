
import Foundation
import ArgumentParser

struct Assemble: ParsableCommand {
    
    
    @ArgumentParser.Argument(help: "The .bba file's path.")
    var srcPath: String
    
    @ArgumentParser.Argument(help: "The machine code path.")
    var destPath: String
    
    
    func run() throws {
        
        let assembly = try String(contentsOfFile: srcPath)
        let assembler = Assembler()
        try assembler.assemble(assembly, destPath)
        
    }
    
}
