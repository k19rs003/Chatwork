import Foundation

class ChatworkAPIProvider: NSObject {
    static let shared = ChatworkAPIProvider()

    private let roomId: String = "357128147"
    private let apiToken: String = "6222c8e21f1c4f6905a0da78e5804ceb"
    private let baseUrl: String = "https://api.chatwork.com/v2"
    private let messageFormat: String = "/rooms/%@/messages"
    
    func sendMessage(message: String)
    {
        let urlString = "\(baseUrl)/rooms/\(roomId)/messages"
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue(apiToken, forHTTPHeaderField: "X-ChatWorkToken")

        let params = "body=\(message)"

        do {
            request.httpBody = params.data(using: .utf8)
        } catch {
            print(error.localizedDescription)
        }

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            if (error == nil) {
                let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                print("大成功")
                print(result)
            } else {
                print("oh my god")
                print(error as Any)
            }
        })
        task.resume()
    }
}
