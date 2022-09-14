import Foundation

class ResponseBroadCast:Decodable {
    var auth:String?
    init(auth:String){
        self.auth = auth
    }
}
