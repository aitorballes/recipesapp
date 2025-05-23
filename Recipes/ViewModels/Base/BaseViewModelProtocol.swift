import Foundation

protocol BaseViewModelProtocol {
    associatedtype State
    var state: State { get set }
}

extension BaseViewModelProtocol where State == ViewState {
    var currentError: Error? {
        guard case .error(let error) = state else { return nil }
        return error
    }
    
    var showError: Bool {
        guard case .error = state else { return false }
        return true
    }
    
    var errorMessage: String {
        (currentError as? LocalizedError)?.errorDescription ?? "Unknown error"
    }
    
}
