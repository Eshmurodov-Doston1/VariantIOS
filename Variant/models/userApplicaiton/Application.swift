import Foundation

class Application:Decodable {
    var id:Int?
    var client_id:Int?
    var contract_number:String?
    var photo_status:Int?
    var token:String?
    var full_name:String?
    var max_level:Int?
    var cards:String?
    var phones:String?
    var client_status_name:String?
    var status_name:String?
    var log_user_id:Int?
    
    init(id:Int,
         client_id:Int,
         contract_number:String,
         photo_status:Int,
         token:String,
         full_name:String,
         max_level:Int,
         cards:String,
         phones:String,
         client_status_name:String,
         status_name:String,
         log_user_id:Int){
        self.id = id
        self.client_id = client_id
        self.contract_number = contract_number
        self.photo_status = photo_status
        self.token = token
        self.full_name = full_name
        self.max_level = max_level
        self.cards = cards
        self.phones = phones
        self.client_status_name = client_status_name
        self.status_name = status_name
        self.log_user_id = log_user_id
    }
}
