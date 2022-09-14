import Foundation
import Alamofire
import UIKit

class MyRequestAdapter:RequestInterceptor{
    var defaults = Defaults()
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var adaptedUrlRequest = urlRequest
        adaptedUrlRequest.setValue("\(String(describing: defaults.token_type)) \(String(describing: defaults.access_token))", forHTTPHeaderField: "Authorization")
        completion(.success(adaptedUrlRequest))
        
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("request \(request) failed")
        
        
        
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            guard let url = URL(string: "https://dev.variantgroup.uz/api/refresh/token") else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters: [String: String] = [
                "refresh_token": defaults.refresh_token ?? "",
                        ]
            guard let encodedURLRequest = try? URLEncodedFormParameterEncoder.default.encode(parameters,
                                                                                                        into: urlRequest) else { return }
 
            AF.request(encodedURLRequest).validate().responseData { response in
                if let data = response.data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let loginResponse = try? decoder.decode(ResAuth.self, from: data) {
                        self.defaults.access_token = loginResponse.access_token
                        self.defaults.refresh_token = loginResponse.refresh_token
                        self.defaults.token_type = loginResponse.token_type
                        completion(.retry)
                    }
                }
            }

        }
    }
    
  
 
}



