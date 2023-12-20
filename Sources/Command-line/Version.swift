
import ArgumentParser

struct Version: ParsableCommand {
    
    func run() throws {
        
        let date = "2023-12-20"
        let version = "0.0.2"
        
        print("Version \(version)\n\(date)")
        
    }
    
}
