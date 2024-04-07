import Foundation
import Moya

//class ChatworkAPIProvider: NSObject {
//    static let shared = ChatworkAPIProvider()
//
//    private let roomId: String = "357128147"
//    private let apiToken: String = "6222c8e21f1c4f6905a0da78e5804ceb"
//    private let baseUrl: String = "https://api.chatwork.com/v2"
//    private let messageFormat: String = "/rooms/%@/messages"
//    
//    func sendMessage(message: String)
//    {
//        let urlString = "\(baseUrl)/rooms/\(roomId)/messages"
//        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
//        
//        request.httpMethod = "POST"
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.addValue(apiToken, forHTTPHeaderField: "X-ChatWorkToken")
//
//        let params = "body=\(message)"
//
//        do {
//            request.httpBody = params.data(using: .utf8)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
//            print("request: \(request)")
//            if (error == nil) {
//                let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
//                print("大成功")
//                print(result)
//            } else {
//                print("oh my god")
//                print(error as Any)
//            }
//        })
//        task.resume()
//    }
//}

final class ChatworkAPIProvider: MoyaProvider<ChatworkModel> {
    static let shared = ChatworkAPIProvider()

    // MARK: - API
//    func api(_ target: MeModel,
//             completion: @escaping (Result<Repositories, Error>) -> ()) {
//        self.request(target) { result in
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//            switch result {
//            case let .success(response):
//                do {
//                    let data = try decoder.decode(Repositories.self, from: response.data)
//                    completion(.success(data))
//                } catch(let error) {
//                    completion(.failure(error))
//                }
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }

    // MARK: - Promise
    func api(target: ChatworkModel) -> Promise<Repositories> {
        .init { fulfill, reject in
            self.request(target) { result in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                switch result {
                case let .success(response):
                    do {
                        let data = try decoder.decode(Repositories.self, from: response.data)
                        fulfill(data)
                    } catch(let error) {
                        reject(error)
                    }
                case let .failure(error):
                    switch error.errorCode {
                    case 403:
                        reject(APIError.accessDenied)
                        print("accessDenied: \(APIError.accessDenied.description)")
                    case 404:
                        reject(APIError.notFoundError)
                        print("accessDenied: \(APIError.notFoundError.description)")
                    case 422:
                        reject(APIError.validationError)
                        print("accessDenied: \(APIError.validationError.description)")
                    default:
                        reject(APIError.unknownError)
                        print("accessDenied: \(APIError.unknownError.description)")
                    }
                }
            }
        }
    }
}
