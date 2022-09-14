import Foundation

class AppResourse{
    var Loading:Bool?=nil
    var Success:ResAuth?=nil
    var Error:AuthError?=nil
    
    init(){
        
    }
    
    init(Loading:Bool?,Success:ResAuth?,Error:AuthError?){
        self.Loading = Loading
        self.Success = Success
        self.Error = Error
    }
}
