import Foundation

class DataSocket:Decodable {
    var socket_id:String?
    var activity_timeout:String?
    
    init(socket_id:String,activity_timeout:String){
        self.socket_id = socket_id
        self.activity_timeout = activity_timeout
    }
}
