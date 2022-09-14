import Foundation
import Alamofire
import SwiftUI

class AuthAppViewModel : ObservableObject {
  
    @Published var isLoading = false
    @Published var modelAuth = ModelAuth()
    @Published var defaults = Defaults()
    @Published var isError:Bool = false
    @Published var resAuth:ResAuth? = nil
    

    
    
    
//    func apiContactList(){
//            self.isLoading = true
//            AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty()) { response in
//                self.isLoading = false
//                switch response.result {
//                case .success:
//                    let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
//                    self.contacts = contacts
//                case let .failure(error):
//                    print(error)
//                    self.contacts = [Contact]()
//                }
//            }
//        }

    
    

}
