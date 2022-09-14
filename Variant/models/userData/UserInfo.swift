import Foundation

class UserInfo:Decodable {
    var birth_date:String?=nil
    var branch_id:Int?
    var document_id:String?=nil
    var email:String?
    var id:Int?
    var monthly_percent:Double
    var name:String?
    var partner_id:Int?
    var partner_percent:Int?
    var partner_type:String?
    var passport_serial:String?
    var patronym:String?
    var period:[Int]?
    var permissions:[String]?
    var phone:String?
    var photo:String?=nil
    var pinfl:String?
    var remember_token:String?=nil
    var role_id:Int?
    var role_title:String?
    var serials:[String]?
    var status:String?
    var surname:String?
    var type:String?
    
    
    init(
        birth_date:String,
        branch_id:Int,
        document_id:String,
        email:String,
        id:Int,
        monthly_percent:Double,
        name:String,
        partner_id:Int,
        partner_percent:Int,
        partner_type:String,
        passport_serial:String,
        patronym:String,
        period:[Int],
        permissions:[String],
        phone:String,
        photo:String?,
        pinfl:String,
        remember_token:String,
        role_id:Int,
        role_title:String,
        serials:[String],
        status:String,
        surname:String,
        type:String){
            self.birth_date = birth_date
            self.branch_id = branch_id
            self.document_id = document_id
            self.email = email
            self.id = id
            self.monthly_percent = monthly_percent
            self.name = name
            self.partner_id = partner_id
            self.partner_percent = partner_percent
            self.partner_type = patronym
            self.passport_serial = passport_serial
            self.patronym = patronym
            self.period = period
            self.permissions = permissions
            self.phone = phone
            self.photo = phone
            self.pinfl = pinfl
            self.remember_token = remember_token
            self.role_id = role_id
            self.role_title = role_title
            self.serials = serials
            self.status = status
            self.surname = surname
            self.type = type
        }
}
