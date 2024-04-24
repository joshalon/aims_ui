import Foundation

class NetworkManager {
    static func sendRequest(message: String, completion: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: "https://famous-crossing-420503.wl.r.appspot.com/generate_response") else {
            completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: nil))
            return
        }
        
        let requestData: [String: Any] = [
            "messages": [
                ["role": "user", "content": message]
            ]
        ]

        print(message)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
            completion(nil, NSError(domain: "EncodeError", code: -1, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // code is not entering any of the if statements here
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(response as Any)
            
            if let error = error {
                completion(nil, error)
                print("error")
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(responseString, nil)
                print(responseString as Any)
            } else {
                print("Did not receive response from server")
                completion(nil, NSError(domain: "InvalidResponse", code: -1, userInfo: nil))
            }
        }.resume()
    }
}
