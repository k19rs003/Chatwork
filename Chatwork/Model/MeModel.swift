import Foundation

struct MeModel: Codable {
    var accountId: Int
    var roomId: Int
    var name: String
    var chatworkId: String
    var organizationId: Int
    var organizationName: String
    var department: String
    var title: String
    var url: String
    var introduction: String
    var mail: String
    var telOrganization: String
    var telExtension: String
    var telMobile: String
    var skype: String
    var facebook: String
    var twitter: String
    var avatarImageUrl: String
    var loginMail: String
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
