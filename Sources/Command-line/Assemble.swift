
import Foundation
import ArgumentParser

struct Assemble: ParsableCommand {
    
    
    @ArgumentParser.Argument(help: "The .bba file's path.")
    var path: String
    
    
    func run() throws {
        
        print("Assembling, path = {\(path)}")
        
        let assembly = try String(contentsOfFile: path)
        print("Assembly:")
        print(assembly)
        
        let assembler = Assembler()
        try assembler.assemble(assembly)
        
    }
    
}
