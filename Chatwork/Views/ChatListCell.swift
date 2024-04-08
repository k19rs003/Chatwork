import Nuke
import NukeExtensions
import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var iconLabel: UIImageView! {
        didSet {
            iconLabel.layer.cornerRadius = iconLabel.frame.height / 2
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var unReadLabel: UILabel!
    
    func create(image: String, name: String, unread: Int) {
        NukeExtensions.loadImage(with: URL(string: image), into: self.iconLabel)
        iconLabel.image = UIImage(named: image)
        nameLabel.text = name
        unReadLabel.text = "未読：\(String(unread))件"
    }

}
