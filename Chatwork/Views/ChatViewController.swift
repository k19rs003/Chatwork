import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatTableView: UITableView!
    private var messages: [MessagesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessages()
    }
    
    private func getMessages() {
        guard let apiToken = UserDefaults.standard.string(forKey: "apiToken") else { return }
        ChatworkAPIProvider.shared.api(.messages(roomId: 357128147, apiToken: apiToken), modelType: [MessagesModel].self) { result in
            switch result {
            case .success(let data):
                print("Messages: \(data)")
                // ルームの配列を保持
                self.messages = data
                // テーブルビューを更新
                DispatchQueue.main.async {
                    self.chatTableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        return cell
    }
    
    
    
}
