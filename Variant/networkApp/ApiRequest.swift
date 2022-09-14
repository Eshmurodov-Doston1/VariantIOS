import Foundation
import Alamofire
import Combine

//class ApiRequest {
//    var method: HTTPMethod
//    var path: String
//    var params : Codable?
//    let retryLimit = 2
//    var defaults:Defaults
//    
//    init(method : HTTPMethod, path : String, params : Codable?,defaults:Defaults) {
//        self.method = method
//        self.path = path
//        self.params = params
//        self.defaults = defaults
//    }
//    
//    
//    let httpHeader:HTTPHeaders = [
//        "Authorization":"\(String(describing: UserDefaults.standard.string(forKey: "token_type"))) \(String(describing: UserDefaults.standard.string(forKey: "access_token")))",
//        "Content-Type":"application/json"
//    ]
//    
//    func requestWithAlamofire(with baseURL: URL) -> DataRequest {
//        var params:[String: Any]!
////        params = self.params!.dictionary ?? [:]
//        
//        print("request params: \(String(describing: params))")
//        let urlString = baseURL.appendingPathComponent(path).absoluteString.removingPercentEncoding ?? ""
//               debugPrint(urlString)
//               let url = URL(string: urlString) ?? baseURL.appendingPathComponent(path)
//               
//               if self.method == .post || self.method == .put || self.method == .delete {
//                   return AF.request(url, method: self.method, parameters: params, encoding: JSONEncoding.default, headers: httpHeader, interceptor: self).validate()
//               }
//               return AF.request(url, method: self.method, parameters: params, headers: httpHeader, interceptor: self).validate()
//           
//    }
//    
//    
//}
//
//
//extension ApiRequest : RequestInterceptor {
//    
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        var request = urlRequest
//        guard let token = UserDefaults.standard.string(forKey: "access_token") else {
//            completion(.success(urlRequest))
//            return
//        }
//        let bearerToken = "Bearer \(token)"
//        request.setValue(bearerToken, forHTTPHeaderField: "authorization")
//        print("\nadapted; token added to the header field is: \(bearerToken)\n")
//        completion(.success(request))
//    }
//    
//    func retry(_ request: Request, for session: Session, dueTo error: Error,
//               completion: @escaping (RetryResult) -> Void) {
//        guard let statusCode = request.response?.statusCode, statusCode == 401, request.retryCount < retryLimit else {
//            completion(.doNotRetryWithError(error))
//            return
//        }
//        print("\nretried; retry count: \(request.retryCount)\n")
////        AWSProvider.authProvider.fetchAuthSession { isSuccess in
////            isSuccess ? completion(.retry) : completion(.doNotRetry)
////        }
//    }
//    
//
//}
