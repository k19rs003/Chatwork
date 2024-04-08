import Foundation
import Combine

class ChatListViewModel {
    private let chatworkAPIProvider = ChatworkAPIProvider.shared
    private var cancellables: Set<AnyCancellable> = []

    // Output
    @Published var rooms: [RoomsModel] = []

    // Input
    func getRooms() {
        guard let apiToken = UserDefaults.standard.string(forKey: "apiToken") else { return }
        chatworkAPIProvider.api(.rooms(apiToken: apiToken), modelType: [RoomsModel].self) { [weak self] result in
            switch result {
            case .success(let rooms):
                self?.rooms = rooms
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
