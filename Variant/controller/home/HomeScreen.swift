import SwiftUI
import Alamofire

struct HomeScreen: View {
    @EnvironmentObject var defaults:Defaults
    var body: some View {
       
            ZStack {
                VStack {
                    TabView{
                        ZStack {
                           MainScreen()
                        }
                        .tabItem({
                                Image(systemName: "house.fill")
                                Text("main".localized())
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                            })
                            .tag(0)
                            .edgesIgnoringSafeArea(.top)

                        ZStack {
                        ChatScreen()
                        }
                        .tabItem({
                                Image(systemName: "message.fill")
                                Text("chat".localized())
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                            })
                            .tag(1)
                        ZStack {
                            SettingsScreen()
                        }
                        .tabItem({
                                Image("settings")
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                Text("settings".localized())
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                            })
                            .tag(2)
                    }
                    .accentColor(Color("button_color"))
                }
            }
            .onAppear{
              getUserData()
            }
    }
    
    
    
    func getUserData() {
        AFHttp.optimalFunc(method: .get, params: UserParams.paramsEmpty(), url: UserParams.USER_VARIANT, holder: { response in
            switch response.result {
            case .success:
                
                let userInfo = try! JSONDecoder().decode(UserInfo.self, from: response.data!)
                defaults.id = userInfo.id
                defaults.name = userInfo.name
                defaults.email = userInfo.email
                defaults.surname = userInfo.surname
                
              
                
            case .failure(let error):
            print(error)
            }
            
           
        })
    }
    
    
    
    
    
   
    
    
    
    
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(Defaults())
    }
}
