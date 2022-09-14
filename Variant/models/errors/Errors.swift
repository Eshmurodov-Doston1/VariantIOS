import Foundation

class Errors:Decodable {
    var field_name:String?
    var message:String?
    init(field_name:String,message:String){
        self.field_name = field_name
        self.message = message
    }
}
