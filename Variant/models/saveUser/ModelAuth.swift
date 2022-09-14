import Foundation

class ModelAuth {
    var resAuth:ResAuth?=nil
    var errors:[Errors]?=nil
    
    init(){
        
    }
    
    init(resAuth:ResAuth?){
        self.resAuth = resAuth
    }
    
    init(resAuth:ResAuth?,errors:[Errors]?){
        self.resAuth = resAuth
        self.errors = errors
    }
    
}
