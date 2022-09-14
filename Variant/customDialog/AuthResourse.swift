import Foundation

enum AuthResourse {
    case Loading
    case Success(resAuth:ResAuth)
    case Error(authError:AuthError)
}
