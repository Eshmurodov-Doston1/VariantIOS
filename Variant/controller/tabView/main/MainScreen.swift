import SwiftUI
import Alamofire
import SocketIO


struct MainScreen: View {
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    @EnvironmentObject var defaults:Defaults
    @EnvironmentObject var statusApp:StatusApp
    @ObservedObject var mainViewModel:MainViewModel = MainViewModel()
    @State var isLoading:Bool = false
    @State var authMessage = ""
    @State var listData = [Data]()
    var body: some View {
        NavigationView {
            ZStack {
                
                if defaults.theme ?? false {
                    Color.black.onAppear{}.preferredColorScheme(.dark)
                }else{
                    Color.white.onAppear{}.preferredColorScheme(.light)
                }
                
            
                if isLoading == false {
                    if listData.isEmpty == false {
                        List(listData,id:\.client_id){ item in
                            NavigationLink(destination: StatmentScreen(data: item,listUploadImage: [PhotoStatement]()), label: {
                                ItemApplication(data: item)
                            })
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .frame(maxWidth:.infinity)
                            
                        }
                        .listStyle(InsetListStyle())
                    }else{
                        LottieView(lottieFile: "empty")
                            .frame(width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/8)
                    }
                }
               
                
                
                
                if isLoading {
                    Color.black.opacity(0.7)
                        .edgesIgnoringSafeArea(.all)

                    GeometryReader{ geometry in
                        VStack(alignment:.center) {
                            Spacer()
                            HStack {
                                Spacer()
                                ZStack {
                                    ProgressView("Loading...")
                                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                        .foregroundColor(.blue)
                                }
                                .frame(width: geometry.size.width / 3,
                                       height: geometry.size.height / 6)
                                .background(defaults.theme ?? false ? Color("darck_color") : Color.white)
                                .foregroundColor(Color.primary)
                                .cornerRadius(15)
                                Spacer()
                            }

                            Spacer()
                        }
                    }
                }
                
                
                
               
            }
            .onAppear {
                getAllApplications()
                socetData()
            }
            .navigationBarTitle("main".localized())
       
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    

    
    
    func getAllApplications() {
        isLoading = true
        AFHttp.optimalFunc(method: .post, params: UserParams.paramsEmpty(), url: UserParams.ALL_APPLICATIONS, holder: { response in
            isLoading = false
            switch response.result {
            case .success:
                let applications = try! JSONDecoder().decode(UserApplication.self, from: response.data!)
                listData = applications.data ?? []
            case .failure(let error):
                print(error)
            }
        })
    }
    
    
    
    func socetData(){
        let task = URLSession.shared.webSocketTask(with: URL(string: "ws://web.variantgroup.uz:6001/app/mykey?protocol=7&client=js&version=7.0.6&flash=false")!)
        
        
        task.resume()
        
        task.receive { result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let text):
                   print("DataSocet:\(text)")
                    
                    
                case .string(let text):
                    let data = text.data(using: .utf8)!
                    do {
                        let json = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String, Any>
                        let socketData = (json!["data"] as? String)?.data(using: .utf8)
                        let jsonSocketData = try? JSONSerialization.jsonObject(with: socketData!) as? Dictionary<String, Any>
                        let socketId = jsonSocketData!["socket_id"] as! String
                        
                        let authBroadCast = BroadCastAuth(socket_id: socketId, channel_name: "private-getChatNewApp.\(defaults.id!)")

                        AFHttp.optimalFunc(method: .post, params: UserParams.paramsBroadCast(broadCastAuth: authBroadCast), url: UserParams.BROAD_CAST_AUTH, holder: { response in
                            switch response.result {
                            case.success:
                                let responseBroadcast = try? JSONDecoder().decode(ResponseBroadCast.self, from: response.data!)
                                authMessage = responseBroadcast!.auth!
                                let messageAuth = URLSessionWebSocketTask.Message.string("{\"event\":\"pusher:subscribe\",\"data\":{\"auth\":\"\(authMessage)\",\"channel\":\"private-getChatNewApp.\(String(describing: defaults.id!))\"}}")

                                task.send(messageAuth){ responseAuth in
                                    print("ResAuth:\(responseAuth)")
                                }
                                
                                task.receive { result in
                                    switch result{
                                    case.success(let success):
                                     //   getAllApplications()
                                       getMessage(task: task)
                                     case.failure(let error):
                                        print("Connect_Error:\(error)")
                                    }
                                }
                                
                            case.failure(let error):
                                print("ErrorBroadcast:\(error)")
                            }
                        })
                        
                        

                        // TODO: MAKE- Status Update

                        let authBroadCastStatus = BroadCastAuth(socket_id: socketId, channel_name: "private-ChatAppStatus")
                        AFHttp.optimalFunc(method: .post, params: UserParams.paramsBroadCast(broadCastAuth: authBroadCastStatus), url: UserParams.BROAD_CAST_AUTH, holder: { response in
                            switch response.result {
                            case.success:
                                let responseBroadcast = try? JSONDecoder().decode(ResponseBroadCast.self, from: response.data!)
                                authMessage = responseBroadcast!.auth!
                             
                                let messageAuth = URLSessionWebSocketTask.Message.string("{\"event\":\"pusher:subscribe\",\"data\":{\"auth\":\"\(authMessage)\",\"channel\":\"private-ChatAppStatus\"}}")

                                task.send(messageAuth){ responseAuth in
                                    print("ResAuthStatus:\(responseAuth)")
                                }

                                task.receive { result in
                                    switch result{
                                    case.success(let success):
                                        print("Succes_Connect:\(success)")
                                     //   getAllApplications()
                                       getMessage(task: task)
                                    case.failure(let error):
                                        print("Connect_Error:\(error)")
                                    }
                                }




                            case.failure(let error):
                                print("ErrorBroadcast:\(error)")
                            }
                        })
                        
                        
//                         
                    }
                  
             @unknown default:
                    fatalError()
                }
                
                
              //  print("Response_Message:\(message)")
            case .failure(let error):
                print("Response_Error:\(error)")
            }
       }
        
        
        
        
            
        
    }
    
    
    
    func getMessage(task:URLSessionWebSocketTask){
        task.receive { result in
            switch result{
            case.success(let success):
                getMessage(task: task)
              //
             case.failure(let error):
                print("Connect_Error_MEssage:\(error)")
            }
       }
    }
    
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .environmentObject(Defaults())
            .environmentObject(StatusApp())
    }
}
