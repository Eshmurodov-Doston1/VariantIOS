
import Foundation

class UserToken:Decodable{
    var token:String?
    
    init(token:String){
        self.token = token
    }
}
