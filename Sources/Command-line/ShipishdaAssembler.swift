
import ArgumentParser

@main
struct bbasm: ParsableCommand {
    
    static let configuration = CommandConfiguration(
        abstract: "Shipishda Assembler",
        subcommands: [Assemble.self, Version.self]
    )
    
}
