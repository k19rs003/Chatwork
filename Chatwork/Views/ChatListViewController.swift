import UIKit

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatListTableView: UITableView!

    // ルームの配列を保持するプロパティ
    private var rooms: [RoomsModel] = []

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
                // ルームの配列を保持
                self.rooms = data
                // テーブルビューを更新
                DispatchQueue.main.async {
                    self.chatListTableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListCell
        cell.create(name: rooms[indexPath.row].name, unread: rooms[indexPath.row].unreadNumber )
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let nextViewController =  storyboard.instantiateViewController(withIdentifier: "Chat") as! ChatViewController
        nextViewController.name = rooms[indexPath.row].name
        nextViewController.roomId = rooms[indexPath.row].roomId
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

