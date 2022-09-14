import Foundation

class AuthVariant:Decodable {
    var phone:String?
    var password:String?
    
    init(phone:String,password:String){
        self.phone = phone
        self.password = password
    }
}
