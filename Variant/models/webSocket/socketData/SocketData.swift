import Foundation

class SocketData:Decodable {
    var event:String?
    var data:DataSocket?
    
    init(event:String,data:DataSocket){
        self.event = event
        self.data = data
    }
}
