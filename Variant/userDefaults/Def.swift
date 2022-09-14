import Foundation

class Def:ObservableObject {
    @Published var resAuth:ResAuth? {
        didSet {
            saveAccount(authData: AuthData(token_type: resAuth?.token_type ?? "", expires_in: resAuth?.expires_in ?? 0, access_token: resAuth?.access_token ?? "", refresh_token: resAuth?.refresh_token ?? ""))
        }
    }
    
    init(){
        self.resAuth = ResAuth(token_type: getAuccount()!.token_type ?? "", expires_in: getAuccount()!.expires_in ?? 0, access_token: getAuccount()!.access_token ?? "", refresh_token: getAuccount()!.refresh_token ?? "")
    }
    
    // UserDefaults save account
    func saveAccount(authData:AuthData){
          let encoder = JSONEncoder()
          if let encodeAccount = try? encoder.encode(authData){
              UserDefaults.standard.set(encodeAccount, forKey: "account")
          }
      }
      
      // UserDefaults getAccount
      func getAuccount() ->AuthData! {
          if let saveAccount = UserDefaults.standard.object(forKey: "account") as? Data {
              let decoder = JSONDecoder()
              if let accountDecode = try? decoder.decode(AuthData.self, from: saveAccount) {
                  return accountDecode
              }
          }
          return nil
      }
}
