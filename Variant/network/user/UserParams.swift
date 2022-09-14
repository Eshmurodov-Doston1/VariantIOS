import Foundation
import Combine
import Alamofire

class UserParams {
static let USER_VARIANT = "api/user/detail"
static let ALL_APPLICATIONS = "api/chat/get/applications"
static let BROAD_CAST_AUTH = "api/broadcasting/auth"
static let GET_UPLOAD_IMAGES = "api/chat/get/photos"
static let GET_APPLICATION = "api/chat/application"
static let LOGOUT_API = "api/logout"
    // MARK: - AFHttp params
    class func paramsEmpty() -> Parameters {
        let params:Parameters = [:]
        return params
    }
    
   // BroadCastAuth
    
    // MARK: - AFHttp BroadcastAuth params
    class func paramsBroadCast(broadCastAuth:BroadCastAuth) -> Parameters {
        let params:Parameters = [
            "socket_id":broadCastAuth.socket_id!,
            "channel_name":broadCastAuth.channel_name!
        ]
        return params
    }
    
    // MARK: - AFHttp Get Photo Upload
    
    class func paramsImages(userToken:UserToken) -> Parameters {
        let params:Parameters = [
            "token":userToken.token!
        ]
        return params
    }
    
    
    // MARK: - AFHttp  Photo Upload

    class func paramsUploadImage(uploadImage:UploadImage) -> Parameters {
        let params:Parameters = [
            "token":uploadImage.token!,
            "type":uploadImage.type!,
        ] 
        return params
    }
    
    // MARK: - AFHttp  Photo Upload Update
    
    class func paramsUploadImageUpdate(uploadImage:UploadImage) -> Parameters {
        let params:Parameters = [
            "token":uploadImage.token!,
            "type":uploadImage.type!,
            "is_update":1
        ]
        return params
    }
    
    
}
