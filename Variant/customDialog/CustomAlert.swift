import SwiftUI


enum ClickButton{
    case ok
    case cancel
    case None
}

struct CustomAlert: View {
    @State var shown:Bool
    @Binding var btnClicked:ClickButton
    @State var message:String
    var body: some View {
        VStack {
            Image("error_image").resizable().frame(width: 50, height: 50).padding(.top, 10)
                Spacer()
            Text(message).foregroundColor(Color.white)
                Spacer()
            
        Divider()
        HStack {
            Button("cancel".localized()) {
            shown.toggle()
            btnClicked = .cancel
        }.foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width/2-30,height: 40)
                
        Button("Ok") {
            shown.toggle()
            btnClicked = .ok
        }.foregroundColor(.white)
        .frame(width:UIScreen.main.bounds.width/2-30, height: 40)
                         }
        
        }.frame(width: UIScreen.main.bounds.width-50, height: 200)
         .background(Color.black.opacity(0.7))
        .cornerRadius(12)
        .clipped()
        .animation(.spring())
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(shown: false, btnClicked:.constant(.None), message: "No Data")
    }
}
