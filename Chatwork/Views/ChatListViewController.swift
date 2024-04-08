import UIKit
import Combine

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatListTableView: UITableView!
 
    private var viewModel = ChatListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.getRooms()
    }
    
    private func bindViewModel() {
        viewModel.$rooms
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.chatListTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListCell
        cell.create(name: viewModel.rooms[indexPath.row].name, unread: viewModel.rooms[indexPath.row].unreadNumber )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let nextViewController =  storyboard.instantiateViewController(withIdentifier: "Chat") as! ChatViewController
        nextViewController.name = viewModel.rooms[indexPath.row].name
        nextViewController.roomId = viewModel.rooms[indexPath.row].roomId
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

