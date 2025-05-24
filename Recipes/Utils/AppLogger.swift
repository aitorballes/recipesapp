import Foundation

struct AppLogger {
    static let shared = AppLogger()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    }
    
    private func log(_ level: LogLevel, _ message: String) {
        let dateString = dateFormatter.string(from: Date())
        print("\(dateString) \(level.rawValue) \(message)")
    }
    
    func debug(_ message: String) {
        log(.debug, message)
    }
    
    func info(_ message: String) {
        log(.info, message)
    }
    
    func warning(_ message: String) {
        log(.warning, message)
    }
    
    func error(_ message: String) {
        log(.error, message)
    }
}
