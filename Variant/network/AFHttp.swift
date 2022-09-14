import Foundation
import Alamofire
import SwiftUI

private let IS_TESTER = false
private let DEP_SER = "http://web.variantgroup.uz/"
private let DEV_SER = "http://web.variantgroup.uz/"
var defaults = Defaults()
var statusApp = StatusApp()

let headers:HTTPHeaders = [
    "Authorization":"\(String(describing: defaults.token_type)) \(String(describing: defaults.access_token))",
    "Accept":"application/json"
]


let headersUpload:HTTPHeaders = [
    "Authorization":"\(String(describing: defaults.token_type!)) \(String(describing: defaults.access_token!))",
    "Accept":"application/json",
    "Content-type": "multipart/form-data"
]

class AFHttp {

    class func optimalFunc(method: HTTPMethod,params : Parameters,url:String,holder:@escaping (AFDataResponse<Any>) -> Void) {
        AF.request(server(url: url),method: method,parameters: params,headers:headers,interceptor: ApiRequest())
            .validate()
            .responseJSON(completionHandler: holder)
    }
    
    
    class func uploadFile(image:UIImage,params : Parameters,holder:@escaping (AFDataResponse<Any>) -> Void){
        AF.upload(multipartFormData: { (multipartFormData) in
            for param in params {
                multipartFormData.append("\(param.value)".data(using: String.Encoding.utf8)!, withName: param.key)
            }
            multipartFormData.append(image.jpegData(compressionQuality: 0.4)!, withName: "photo", fileName: "\(Calendar.current).jpg", mimeType: "image/jpg")
        }, to: server(url: "api/chat/upload"),method: .post,headers: headersUpload,interceptor: ApiRequest())
        .responseJSON(completionHandler: holder)
    }
    
    
    class func post(url:String,params:Parameters,holder:@escaping (AFDataResponse<Any>) -> Void) {
        AF.request(server(url: url),method: .post,parameters: params,headers: headers,interceptor: ApiRequest())
            .responseJSON(completionHandler: holder)

    }

    
    
    // MARK: - AFHttp Server
    class func server(url:String) -> URL{
        if IS_TESTER {
            return URL(string: DEP_SER + url)!
        }
        return URL(string: DEV_SER + url)!
    }
}



class ApiRequest : RequestInterceptor{
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        
        
        var request = urlRequest
        guard let token = UserDefaults.standard.string(forKey: "access_token") else {
                completion(.success(urlRequest))
                return
        }
        
        let bearerToken = "Bearer \(token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        print("\nadapted; token added to the header field is: \(bearerToken)\n")
        completion(.success(request))
        
        
        
//        var adaptedUrlRequest = urlRequest
//
//        adaptedUrlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
//        adaptedUrlRequest.setValue("\(UserDefaults.standard.string(forKey: "token_type") ?? "") \(UserDefaults.standard.string(forKey: "access_token") ?? "")", forHTTPHeaderField: "Authorization")
//
//
//        print("urlRequest \(adaptedUrlRequest.description)")
//        completion(.success(adaptedUrlRequest))
        
    }
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
               completion(.doNotRetry)
        return
        }
        
        guard request.retryCount < 1800 else {
                completion(.doNotRetry)
                return
            }
            print("retry statusCode....\(statusCode)")
        
        switch statusCode {
           case 200...299:
               completion(.doNotRetry)
           case 401:
               refreshToken { isSuccess in isSuccess ? completion(.retry) : completion(.doNotRetry) }
               break
           default:
               completion(.retry)
           }
    }
    
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
                   let params = [
   "refresh_token": defaults.refresh_token
           ]
           AF.request("https://web.variantgroup.uz/api/refresh/token", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
               
               switch response.result {
               case.success:
                   
                   if response.response!.statusCode == 401 {
                       defaults.clearDefaults()
                       statusApp.listener()
                       completion(true)
                   }else {
                       if let data = response.data, let token = (try? JSONSerialization.jsonObject(with: data, options: [])
                                      as? [String: Any])?["access_token"] as? String {
                          
                           
                           let refresh_token = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])?["refresh_token"] as? String
                           let token_type = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])?["token_type"] as? String
                           
                           defaults.access_token = token
                           defaults.refresh_token = refresh_token
                           defaults.token_type = token_type
                           print("refresh_token \(String(describing: refresh_token)) \n token_type:\(token)")
                           print("\n access_token completed successfully. New token is: \(String(describing: token_type))\n")
                           completion(true)
                       } else {
                           completion(false)
                       }
                       
//                       if let data = response.data, let refresh_token = (try? JSONSerialization.jsonObject(with: data, options: [])
//                                      as? [String: Any])?["refresh_token"] as? String {
//                           defaults.refresh_token = refresh_token
//                           print("\n refresh_token completed successfully. New token is: \(refresh_token)\n")
//                           completion(true)
//                       } else {
//                           completion(false)
//                       }
//
//                       if let data = response.data, let token_type = (try? JSONSerialization.jsonObject(with: data, options: [])
//                                      as? [String: Any])?["token_type"] as? String {
//                           defaults.refresh_token = token_type
//                           print("\n token_type completed successfully. New token is: \(token_type)\n")
//                           completion(true)
//                       } else {
//                           completion(false)
//                       }
                   }
               case.failure(let error):
                   print(error)
               }
               
               
               
           }
       }
    
    
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//
//        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
//            print("response StatusCode \(response.statusCode)")
////            guard let url = URL(string: "https://web.variantgroup.uz/api/refresh/token") else { return }
////            var urlRequest = URLRequest(url: url)
////            urlRequest.httpMethod = "POST"
////            urlRequest.setValue("applicaiton/json", forHTTPHeaderField: "Accept")
//
//            let headersRefresh:HTTPHeaders = [
//                "Accept":"applicaiton/json"
//            ]
//
//            let parameters: [String: String] = [
//                "refresh_token": defaults.refresh_token!,
//                    ]
//            //guard let encodedURLRequest = try? URLEncodedFormParameterEncoder.default.encode(parameters, into: urlRequest) else { return }
//
//            AF.request("https://web.variantgroup.uz/api/refresh/token",method: .post,parameters: parameters,headers: headersRefresh).validate()
//                .validate()
//                .responseJSON { response in
//                    switch response.result {
//                    case .success:
//                        print(response.result)
//                        if let data = response.data {
//                            if response.response!.statusCode == 401 {
//                                print("Error Unauth:\(response.result)")
////                                defaults.clearDefaults()
////                                statusApp.listener()
//                             } else {
//                                let decoder = JSONDecoder()
//                                if let loginResponse = try? decoder.decode(ResAuth.self, from: data) {
//                                    defaults.access_token = loginResponse.access_token
//                                    defaults.refresh_token = loginResponse.refresh_token
//                                    defaults.token_type = loginResponse.token_type
//                                    completion(.retry)
//                                    request.resume()
//                                }
//                            }
//                        }
//                    case .failure(let error):
//                        if error.responseCode == 401 {
//                            defaults.clearDefaults()
//                            statusApp.listener()
//                            completion(.doNotRetryWithError(error))
//
//                        }
//                        print(error)
//                    }
//                }
//
//
//        }
//    }
//
  
    
 
}
