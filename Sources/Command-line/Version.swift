
import ArgumentParser

struct Version: ParsableCommand {
    
    func run() throws {
        
        let date = "2023-12-15"
        let version = "0.0.1"
        
        print("Version \(version)\n\(date)")
        
    }
    
}
