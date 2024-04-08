import Foundation
import Moya

enum GithubError: Error {
    case error
}

enum ChatworkAPIService {
    // 既存のAPIエンドポイント
    case me(apiToken: String)
    case my(apiToken: String)
    case contacts(apiToken: String)
    case rooms(apiToken: String)
    case messages(roomId: Int, apiToken: String, force: Int)
    
    // 新しいAPIエンドポイント
    case postMessages(roomId: Int, apiToken: String, postData: Data)
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
        case .messages(let roomId, _, _):
            return "/rooms/\(roomId)/messages"
        case .postMessages(let roomId, _, _):
            return "/rooms/\(roomId)/messages"
        }
    }
    

    var method: Moya.Method {
        switch self {
        case .me, .my, .contacts, .rooms, .messages:
            return .get
        case .postMessages:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .me, .my, .contacts, .rooms:
            return .requestPlain
        case .messages(_, _, let force):
            return .requestParameters(parameters: ["force": force], encoding: URLEncoding.default)
        case .postMessages(_, _, let postData):
            return .requestData(postData)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .me(let apiToken), .my(let apiToken), .contacts(let apiToken), .rooms(let apiToken), .messages(_, let apiToken, _):
            return ["accept": "application/json",
                    "x-chatworktoken": apiToken]
        case .postMessages(_, let apiToken, _):
            return ["accept": "application/json",
                    "content-type": "application/x-www-form-urlencoded",
                    "x-chatworktoken": apiToken]
        }
    }
}
