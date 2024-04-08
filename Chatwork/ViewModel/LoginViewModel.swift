import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    private let provider = ChatworkAPIProvider.shared
    
    func login(apiToken: String) {
        provider.api(.me(apiToken: apiToken), modelType: MeModel.self) { [weak self] result in
            switch result {
            case .success:
                UserDefaults.standard.set(apiToken, forKey: "apiToken")
                self?.isLoggedIn = true
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

