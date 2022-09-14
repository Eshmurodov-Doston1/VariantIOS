import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
}

struct ItemApplication: View {
    @State var data:Data
    @EnvironmentObject var defaults:Defaults
    @EnvironmentObject var statusApp:StatusApp
    var body: some View {
        ZStack {
                VStack(alignment:.leading,spacing: 10) {
                    Text(data.full_name ?? "")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .foregroundColor(defaults.theme ?? false ? .white : .black)
                        .frame(width: .infinity, alignment: .leading)
                        .frame(maxWidth:.infinity,alignment: .leading)
                       
                    Text(data.contract_number ?? "")
                        .font(.system(size: 12))
                        .fontWeight(.light)
                        .lineLimit(1)
                        .foregroundColor(defaults.theme ?? false ? .white : .black.opacity(0.8))
                        .frame(width: .infinity, alignment: .leading)
                        .frame(maxWidth:.infinity,alignment: .leading)
                        
                    if data.status_title != "" ||  data.status_title != nil {
                        Text(data.status_title ?? "")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .lineLimit(1)
                            .frame(width: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(data.photo_status == 0 ? .pink.opacity(0.7) : data.photo_status == 1  ? .green.opacity(0.7) : .red.opacity(0.7) )
                            .cornerRadius(5)
                    }
                        
                }
            .frame(maxWidth: .infinity,alignment: .topLeading)
            .frame(width:.infinity,alignment: .leading)
            .padding(.bottom,10)
            .padding(.top,10)
            .padding(.horizontal)
            .frame(maxWidth:.infinity)
            .background(defaults.theme ?? false ? Color("darck_color").onAppear{}.preferredColorScheme(.dark) : Color.white.onAppear{}.preferredColorScheme(.light))
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
        }
        
      
    }
}

struct ItemApplication_Previews: PreviewProvider {
    static var previews: some View {
        ItemApplication(data: Data(status: "", level: 0, client_id: 0, contract_number: "N-O78787878", photo_status: 0, token: "", status_title: "Pasport Rasim", full_name: "Dostonbek Eshmurodov"))
            .environmentObject(Defaults())
            .environmentObject(StatusApp())
    }
}
