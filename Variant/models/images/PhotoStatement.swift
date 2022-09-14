import Foundation

class PhotoStatement:Decodable {
    var id:Int?
    var client_application_id:Int?
    var file_link:String?
    var file_extension:String?
    var file_name:String?
    var type:Int?
    var created_at:String?
    var updated_at:String?
    
    
    
    init(){ }
    
    
    init(id:Int,client_application_id:Int,file_link:String,file_extension:String,file_name:String,type:Int,created_at:String,updated_at:String){
        self.id = id
        self.client_application_id = client_application_id
        self.file_link = file_link
        self.file_extension = file_extension
        self.file_name = file_name
        self.type = type
        self.created_at = created_at
        self.updated_at = updated_at
    }
    
}
