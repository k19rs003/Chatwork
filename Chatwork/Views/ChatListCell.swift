import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var unReadLabel: UILabel!
    
    func create(name: String, unread: Int) {
        nameLabel.text = name
        unReadLabel.text = "未読：\(String(unread))件"
    }

}
