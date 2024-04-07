import Foundation
import Moya

enum GithubError: Error {
    case error
}

enum ChatworkAPIService {
    case me(apiToken: String)
    case my(apiToken: String)
    case contacts(apiToken: String)
    case rooms(apiToken: String)
    case messages(roomId: Int, apiToken: String)
}

extension ChatworkAPIService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.chatwork.com/v2") else { fatalError() }
        return url
    }

    var path: String {
        switch self {
        case .me:
            return "/me"
        case .my:
            return "/my"
        case .contacts:
            return "/contacts"
        case .rooms:
            return "/rooms"
        case .messages(let roomId, _):
            return "/rooms/\(roomId)/messages?force=1"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        switch self {
        case .me(let apiToken), .my(let apiToken), .contacts(let apiToken), .rooms(let apiToken), .messages(_, let apiToken):
            return ["accept": "application/json",
                    "x-chatworktoken": apiToken]
        }
    }
}
