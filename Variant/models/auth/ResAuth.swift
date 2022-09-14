import Foundation

class ResAuth:Decodable {
    
    var token_type:String?
    var expires_in:Int?
    var access_token:String?
    var refresh_token:String?
    
    init() {
        
    }
    
    init(token_type:String,expires_in:Int,access_token:String,refresh_token:String){
        self.token_type = token_type
        self.expires_in = expires_in
        self.access_token = access_token
        self.refresh_token = refresh_token
    }
}
