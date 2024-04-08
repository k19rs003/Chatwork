import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatTextView: UITextView!
    
    func create(name: String, body: String) {
        nameLabel.text = name
        chatTextView.text = body
    }
}
