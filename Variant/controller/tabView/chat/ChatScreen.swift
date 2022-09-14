//
//  ChatScreen.swift
//  Variant
//
//  Created by macbro on 26/05/22.
//

import SwiftUI

struct ChatScreen: View {
    var body: some View {
        LottieView(lottieFile: "not_found")
            .frame(width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/4)
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}
