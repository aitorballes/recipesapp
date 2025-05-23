import Foundation

enum PersistanceError: Error, LocalizedError {
    case fetchFailed
    case deleteFailed
    case updateFailed
    case insertFailed
    
    var errorDescription: String? {
        switch self {
        case .fetchFailed: "We couldn't load your data right now. Please try again later."
        case .deleteFailed: "We couldn't remove the item. Please try again."
        case .updateFailed: "We couldn't update the information. Please try again."
        case .insertFailed: "We couldn't add the item. Please check and try again."
        }
    }
}
