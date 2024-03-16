
import Foundation

class Assembler {
    
    
    let printStats: Bool
    let emitIndices: Bool
    
    
    init(_ emitIndices: Bool, _ printStats: Bool) {
        self.emitIndices = emitIndices
        self.printStats = printStats
    }
    
    
    func assemble(_ assembly: String, _ destPath: String) throws {
        
        if printStats {
            print("\tTime estimate: \(assembly.count / 300) s.")
        }
        
        let start = Foundation.DispatchTime.now().uptimeNanoseconds
        
        Swift.print("Start lex")
        
        let tokens = try lex(assembly)
        
        Swift.print("Start parse")
        
        let labels = try parse(tokens)
        let code = translate(labels)
        
        let end = Foundation.DispatchTime.now().uptimeNanoseconds
        
        let ms = (end - start) / 1_000_000
        
        if printStats {
            print("\nASSEMBLER STATISTICS:\n\tTime: \(ms) ms\n\tLength: \(assembly.count) characters\n")
        }
        
        writeResult(code, destPath)
        
    }
    
    
}
