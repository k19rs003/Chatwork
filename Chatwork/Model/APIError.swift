import Foundation

enum APIError: LocalizedError {
    case invalidRequest
    case invalidAPIToken
    case permissionError
    case RateLimitExceeded
    case unknownError

    var description: String {
        switch self {
        case .invalidRequest:
             "パラメータが不足しています"
        case .invalidAPIToken:
             "認証に失敗しました"
        case .permissionError:
             "メンバー一覧を取得する権限がありません"
        case .RateLimitExceeded:
             "APIの利用回数制限を超過しました"
        case .unknownError:
             "不明なエラーです"
        }
    }
}
