//
//  StartScreen.swift
//  Variant
//
//  Created by macbro on 24/05/22.
//

import SwiftUI

struct StartScreen: View {
    @EnvironmentObject var statusApp:StatusApp
    var body: some View {
        if statusApp.userId != nil {
            HomeScreen()
        } else {
            AuthScreen()
                .onAppear{
                    statusApp.listener()
                }
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
            .environmentObject(StatusApp())
            .environmentObject(Defaults())
    }
}
