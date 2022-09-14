import Foundation
import Alamofire

class AuthParams {
    static let AUTH_VARIANT = "api/login"
    
    // MARK: -  AFHttp params
    
    class func paramsAuthVariant(authVariant:AuthVariant) -> Parameters {
        let params:Parameters = [
            "phone":authVariant.phone!,
            "password":authVariant.password!
        ]
        return params
    }
    
    // MARK: - AFHttp params
    class func paramsEmpty() -> Parameters {
        let params:Parameters = [:]
        return params
    }
}
