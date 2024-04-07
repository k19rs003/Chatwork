import Foundation
import Moya

enum GithubError: Error {
    case error
}

enum ChatworkAPIService {
    case me
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
            
            let apiToken = "6222c8e21f1c4f6905a0da78e5804ceb"
            return .requestParameters(parameters: ["q": city, "apiToken": apiToken, "units": unit, "lang": lang], encoding: URLEncoding.queryString)
        case .my:
            break
        case .contacts:
            break
        case .rooms:
            break
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
//        return ["X-ChatWorkToken": token]
    }
}
