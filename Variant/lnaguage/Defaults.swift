import Foundation
import Combine 
class Defaults:ObservableObject{
    
    @Published  var language:String? {
        didSet {
            UserDefaults.standard.setValue(language, forKey: "app_lan")
        }
    }
    
    @Published  var access_token:String? {
        didSet {
            UserDefaults.standard.setValue(access_token, forKey: "access_token")
        }
    }
    
    @Published  var refresh_token:String? {
        didSet {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
    }
    
    
    @Published  var token_type:String? {
        didSet {
            UserDefaults.standard.setValue(token_type, forKey: "token_type")
        }
    }
    
    @Published  var appCreated:String? {
        didSet {
            UserDefaults.standard.setValue(appCreated, forKey: "appCreated")
        }
    }
    
    
    @Published  var id:Int? {
        didSet {
            UserDefaults.standard.setValue(id, forKey: "id")
        }
    }
    
    @Published  var surname:String? {
        didSet {
            UserDefaults.standard.setValue(surname, forKey: "surname")
        }
    }
    
    @Published  var name:String? {
        didSet {
            UserDefaults.standard.setValue(name, forKey: "name")
        }
    }
    
    @Published  var email:String? {
        didSet {
            UserDefaults.standard.setValue(email, forKey: "email")
        }
    }
    
    
    @Published  var theme:Bool? {
        didSet {
            if theme == nil {
                theme = false
            }
            UserDefaults.standard.setValue(theme, forKey: "theme")
        }
    }
    
    
//    userEntity.id = Int32(userInfo.id!)
//    userEntity.partner_id = Int32(userInfo.partner_id!)
//    userEntity.partner_percent = Int32(userInfo.partner_percent!)
//    userEntity.role_id = Int32(userInfo.role_id!)
//    userEntity.monthly_percent = userInfo.monthly_percent
//    userEntity.birth_date = userInfo.birth_date
//    userEntity.branch_id = Int32(userInfo.branch_id!)
//    userEntity.document_id = userInfo.document_id
//    userEntity.email = userInfo.email
//    userEntity.name = userInfo.name
//    userEntity.partner_type = userInfo.partner_type
//    userEntity.passport_serial = userInfo.passport_serial
//    userEntity.patronym = userInfo.patronym
//    userEntity.phone = userInfo.phone
//    userEntity.photo = userInfo.photo
//    userEntity.pinfl = userInfo.pinfl
//    userEntity.remember_token = userInfo.remember_token
//    userEntity.role_title = userInfo.role_title
//    userEntity.status = userInfo.status
//    userEntity.surname = userInfo.surname
//    userEntity.two_factor_enabled = userInfo.two_factor_en
    
    
    
    
    init() {
        self.language = UserDefaults.standard.string(forKey: "app_lan")
        self.access_token = UserDefaults.standard.string(forKey: "access_token")
        self.refresh_token = UserDefaults.standard.string(forKey: "refresh_token")
        self.token_type = UserDefaults.standard.string(forKey: "token_type")
        self.appCreated = UserDefaults.standard.string(forKey: "appCreated")
        
        self.id = UserDefaults.standard.integer(forKey: "id")
        self.surname = UserDefaults.standard.string(forKey: "surname")
        self.name = UserDefaults.standard.string(forKey: "name")
        self.email = UserDefaults.standard.string(forKey: "email")
        
        self.theme = UserDefaults.standard.bool(forKey: "theme")
        
    }
    

    
    
    
    func clearDefaults(){
        UserDefaults.standard.removeObject(forKey: "app_lan")
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")
        UserDefaults.standard.removeObject(forKey: "token_type")
        UserDefaults.standard.removeObject(forKey: "appCreated")
    }
}

