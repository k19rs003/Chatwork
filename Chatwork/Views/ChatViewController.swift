import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        return cell
    }
    
    
    
}
