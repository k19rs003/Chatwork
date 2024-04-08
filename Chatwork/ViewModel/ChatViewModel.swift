import UIKit
import Combine

class ChatViewModel {
    @Published var messages: [ReadMessagesModel] = []
    private var cancellables: Set<AnyCancellable> = []

    func getMessages(roomId: Int) {
        guard let apiToken = UserDefaults.standard.string(forKey: "apiToken") else { return }
        
        ChatworkAPIProvider.shared.api(.messages(roomId: roomId, apiToken: apiToken, force: 1), modelType: [ReadMessagesModel].self) { result in
            switch result {
            case .success(let data):
                print("ReadMessages: \(data)")
                // ルームの配列を保持
                self.messages = data
            case .failure(let error):
                print("GetMessageError: \(error)")
            }
        }
    }

    func sendMessages(roomId: Int, message: String) {
        guard let apiToken = UserDefaults.standard.string(forKey: "apiToken") else { return }
        
        ChatworkAPIProvider.shared.api(.postMessages(roomId: roomId, apiToken: apiToken, postData: "self_unread=0&body=\(message)".data(using: .utf8)!), modelType: PostMessageModel.self ) { result in
            switch result {
            case .success(let data):
                print("PostMessages: \(data)")
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
