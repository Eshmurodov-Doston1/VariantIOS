
import Foundation
import Combine
class StatusApp:ObservableObject {
    var didChange = PassthroughSubject<StatusApp,Never>()
    @Published var userId:String? {didSet {self.didChange.send(self)}}
    
    func listener(){
        if let userId = UserDefaults.standard.string(forKey: "appCreated") {
            self.userId = userId
        }else{
            self.userId = nil
        }
    }
}
