import SwiftUI
import Alamofire
import SwiftUI
struct AuthScreen: View {
    
    @EnvironmentObject var statusApp:StatusApp
    @EnvironmentObject var defaults:Defaults
    @State var phone: String = "+998"
    @State var isEditing: Bool = false
    @State var password: String = ""
    @State var isError = false
    @State var modelAuth = ModelAuth()
    @State var btnClicked:ClickButton = .None
    @State var isLoading = false
    @State var shown = false
    @State var isClicked = false
    @State var resAuth:ResAuth? = nil

    @State var errorMessage = ""
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                if defaults.theme ?? false {
                    Color.black.onAppear{}.preferredColorScheme(.dark)
                }else{
                    Color.white.onAppear{}.preferredColorScheme(.light)
                }
                
                VStack(spacing:70) {
                    Spacer()
                    HStack {
                        Image("logo1")
                        Image("logo2")
                            .renderingMode(.template)
                            .foregroundColor(defaults.theme ?? false ? .white : .black)
                    }

                    VStack(spacing:20) {
                        TextField("phone_number".localized(), text: self.$phone)
                            .onReceive(phone.publisher.collect()) {
                                self.phone = String($0.prefix(13))
                            }
                            .textContentType(.oneTimeCode)
                            .keyboardType(.numberPad)
                            .frame(width: .infinity, height: 45)
                            .padding(.horizontal,10)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(8)


                        TextField("password".localized(),text:self.$password)
                            .frame(width: .infinity, height: 45)
                            .padding(.horizontal,10)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(8)

                        Button(action: {
                            if self.phone.substring(from: String.Index(encodedOffset: 1)).count == 12  && password.count >= 6 {
                                let authVariant = AuthVariant(phone:   self.phone.substring(from: String.Index(encodedOffset: 1)), password: self.password)
                            auth(authVariant: authVariant)

                            }else {
                                btnClicked = .None
                                isClicked = true
                            }
                           }, label: {
                            Spacer()
                            Text("auth_text".localized())
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                            Spacer()

                        })

                        .frame(height: 45)
                        .background(Color("button_color"))
                        .cornerRadius(8)

                    }

                    Spacer()
                }
                .padding()
            }
            .blur(radius: (isError && btnClicked != .ok  && btnClicked != .cancel) || isClicked && btnClicked != .ok  && btnClicked != .cancel ? 30 : 0)

            if isError && btnClicked != .ok  && btnClicked != .cancel {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                      if btnClicked != .ok && btnClicked != .cancel {
                            CustomAlert(shown: self.isError, btnClicked: $btnClicked, message: modelAuth.errors?[0].message ?? "")
                      }
                       Spacer()
                    }
                    Spacer()
                }
             }



            if isClicked {
                if self.phone.substring(from: String.Index(encodedOffset: 1)).count < 12{
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                          if btnClicked != .ok && btnClicked != .cancel {
                              CustomAlert(shown: isClicked, btnClicked: $btnClicked, message: "phone_error".localized())
                          }
                           Spacer()
                        }
                        Spacer()
                    }
                } else if password.count < 6 {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                          if btnClicked != .ok && btnClicked != .cancel {
                              CustomAlert(shown: isClicked, btnClicked: $btnClicked, message: "password_error".localized())
                          }
                           Spacer()
                        }
                        Spacer()
                    }
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
        
        
    }
    

    func auth(authVariant:AuthVariant) -> ResAuth? {
        self.isLoading = true
        AFHttp.post(url: AuthParams.AUTH_VARIANT, params: AuthParams.paramsAuthVariant(authVariant:authVariant), holder: { response in
            self.isLoading = false
            switch response.result {
            case .success:
                switch response.response!.statusCode {
                case 200..<300:
                    let authResponse = try! JSONDecoder().decode(ResAuth.self, from: response.data!)
                    self.resAuth = authResponse
                    modelAuth.resAuth = authResponse
                    self.defaults.access_token = authResponse.access_token
                    self.defaults.refresh_token = authResponse.refresh_token
                    self.defaults.token_type = authResponse.token_type
                    self.defaults.appCreated = authVariant.phone
                    statusApp.listener()

                    self.isError = false
                case 400..<500:
                    let authError = try! JSONDecoder().decode(AuthError.self, from: response.data!)
                    modelAuth.errors  = authError.errors
                    self.isError = true

                case 500..<500:
                    modelAuth.errors = [Errors(field_name: "\(response.response!.statusCode)", message: "Server Ne rabotaem")]
                    self.isError = true

                default:
                    print(response.result)
                    self.isError = true
                }

            case .failure(let error):
                modelAuth.errors = [Errors(field_name: error.localizedDescription, message: error.localizedDescription)]
                self.isError = true
            }
        })
        return self.resAuth ?? nil
    }
    
        
}

struct AuthScreen_Previews: PreviewProvider {
    static var previews: some View {
        AuthScreen()
            .environmentObject(StatusApp())
            .environmentObject(Defaults())
    }
}


