import Foundation

class AuthError:Decodable {
    var errors:[Errors]
    
    init(errors:[Errors]){
        self.errors = errors
    }
}
