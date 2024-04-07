import Foundation
import Moya

enum GithubError: Error {
    case error
}

enum ChatworkAPIService {
    case me(token: String)
    case my
    case contacts
    case rooms
}

extension ChatworkAPIService: TargetType {
    //    private let roomId: String = "357128147"
    //    private let messageFormat: String = "/rooms/%@/messages"
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
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        switch self {
        case .me:
            return .requestPlain
        case .my:
            return .requestPlain
        case .contacts:
            return .requestPlain
        case .rooms:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
//        let headers: [String : String]? = ["Content-type": "application/json", "X-ChatWorkToken": token]
//        return ["Content-type": "application/json", "X-ChatWorkToken": token]
//        return headers
//        return ["X-ChatWorkToken": token]
        switch self {
        case let .me(token):
            let headers: [String : String]? = ["Content-type": "application/json", "X-ChatWorkToken": token]
            return headers
        case .my:
            return .none
        case .contacts:
            return .none
        case .rooms:
            return .none
        }
    }
}
