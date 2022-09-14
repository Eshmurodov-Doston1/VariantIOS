//
//  SettingsScreen.swift
//  Variant
//
//  Created by macbro on 26/05/22.
//

import SwiftUI

struct SettingsScreen: View {
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }

    @EnvironmentObject var defaults:Defaults
    @EnvironmentObject var statusApp:StatusApp
    @State private var showGreeting = false
    @State var isAlert = false
    @State var colorBack:Color = Color.white
    var body: some View {
        ZStack{
            if defaults.theme ?? false {
                Color.black
                    .onAppear{
                        showGreeting = defaults.theme ?? true
                    }
                    .preferredColorScheme(.dark)
            }else{
                Color.white
                    .onAppear{
                        showGreeting = defaults.theme ?? false
                    }
                    .preferredColorScheme(.light)
            }
           
          VStack {
                Form {
                    Section {
                        Toggle(showGreeting ? "night_mode".localized() : "light_mode".localized()
                               , isOn: $showGreeting)
                        .onTapGesture {
                            if showGreeting {
                                defaults.theme = false
                            }else {
                                defaults.theme = true
                            }
                        }
                        HStack {
                            Text("language".localized())
                            Spacer()
                            Text("ru_text".localized())
                        }
                        
                        Button(action: {
                            isAlert.toggle()
                        }, label: {
                            HStack {
                                Text("log_out".localized())
                                    .foregroundColor(Color("button_color"))
                                    .fontWeight(.semibold)
                            }
                        })
                        .alert("log_out".localized(),isPresented: $isAlert,actions: {
                            Button("no".localized(), role: .cancel, action: {})
                            Button("yes".localized(), role: .destructive, action: {
                                logOut()
                            })
                        },message: {
                            Text("logOut_message".localized())
                        })
                        .preferredColorScheme(defaults.theme ?? false ? .dark : .light)
                        
                    }
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 2, y: 2)
               
               
               
            }
           
        }
        
    }
    
    
    func logOut(){
        AFHttp.optimalFunc(method: .post, params: UserParams.paramsEmpty(), url: UserParams.LOGOUT_API, holder: {
            response in
            switch response.result {
            case.success:
                defaults.clearDefaults()
                statusApp.listener()
            case.failure(let error):
                print(error)
            }
        })
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
            .environmentObject(Defaults())
            .environmentObject(StatusApp())
    }
}
