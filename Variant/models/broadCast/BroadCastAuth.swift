import Foundation
class BroadCastAuth:Decodable {
    var socket_id:String?
    var channel_name:String?
    
    init(socket_id:String,channel_name:String){
        self.socket_id = socket_id
        self.channel_name = channel_name
    }
}
