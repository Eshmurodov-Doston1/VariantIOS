import Foundation

class Data:Decodable {
    var status:String?
    var level:Int?
    var client_id:Int?
    var contract_number:String?
    var photo_status:Int?
    var token:String?
    var status_title:String?
    var full_name:String?
    
    init(status:String,level:Int,client_id:Int,contract_number:String,photo_status:Int,token:String,status_title:String,full_name:String){
        self.status = status
        self.level = level
        self.client_id = client_id
        self.contract_number = contract_number
        self.photo_status = photo_status
        self.token = token
        self.status_title = status_title
        self.full_name = full_name
    }
}
