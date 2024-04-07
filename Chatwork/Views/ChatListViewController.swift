import UIKit

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var chatListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        getRooms()
    }

    private func getRooms() {
        guard let apiToken = UserDefaults.standard.string(forKey: "apiToken") else { return }
        ChatworkAPIProvider.shared.api(.rooms(apiToken: apiToken), modelType: [RoomsModel].self) { result in
            switch result {
            case .success(let data):
                print("ROOMS: \(data)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
