import Foundation
import UIKit

class UploadImage:Decodable{
    var token:String?
    var type:Int?
    
    init(token:String,type:Int){
        self.token = token
        self.type = type
    }
}
