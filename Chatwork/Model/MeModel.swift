import Foundation

struct MeModel: Codable {
    let accountId: Int
    let roomId: Int
    let name: String
    let chatworkId: String
    let organizationId: Int
    let organizationName: String
    let department: String
    let title: String
    let url: String
    let introduction: String
    let mail: String
    let telOrganization: String
    let telExtension: String
    let telMobile: String
    let skype: String
    let facebook: String
    let twitter: String
    let avatarImageUrl: URL
    let loginMail: String

    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case roomId = "room_id"
        case name
        case chatworkId = "chatwork_id"
        case organizationId = "organization_id"
        case organizationName = "organization_name"
        case department
        case title
        case url
        case introduction
        case mail
        case telOrganization = "tel_organization"
        case telExtension = "tel_extension"
        case telMobile = "tel_mobile"
        case skype
        case facebook
        case twitter
        case avatarImageUrl = "avatar_image_url"
        case loginMail = "login_mail"
    }
}

struct RoomsModel: Codable {
    var roomId: Int
    var name: String
    var type: String
    var role: String
    var sticky: Bool
    var unreadNumber: Int
    var mentionNumber: Int
    var mytaskNumber: Int
    var messageNumber: Int
    var fileNumber: Int
    var taskNumber: Int
    var iconPath: String
    var lastUpdateTime: Int

    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case name
        case type
        case role
        case sticky
        case unreadNumber = "unread_num"
        case mentionNumber = "mention_num"
        case mytaskNumber = "mytask_num"
        case messageNumber = "message_num"
        case fileNumber = "file_num"
        case taskNumber = "task_num"
        case iconPath = "icon_path"
        case lastUpdateTime = "last_update_time"
    }
}

struct MessagesModel: Codable {
    let messageId: String
    let account: Account
    let body: String
    let sendTime: Int
    let updateTime: Int

    enum CodingKeys: String, CodingKey {
        case messageId = "message_id"
        case account
        case body
        case sendTime = "send_time"
        case updateTime = "update_time"
    }
}

struct Account: Codable {
    let accountId: Int
    let name: String
    let avatarImageUrl: String

    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case name
        case avatarImageUrl = "avatar_image_url"
    }
}
