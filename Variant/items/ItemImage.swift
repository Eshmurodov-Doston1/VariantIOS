import SwiftUI
import SDWebImageSwiftUI
struct ItemImage: View {
    @State var photoStatement:PhotoStatement
    var body: some View {
        
        VStack{
            if photoStatement.file_link != nil {
                WebImage(url: URL(string: "http://web.variantgroup.uz/\(photoStatement.file_link!)"))
                    .placeholder {
                        Rectangle().foregroundColor(.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width/2.1, height: UIScreen.main.bounds.size.height/4.4)
                    .cornerRadius(10)
                
               
                    
            }
           
                
        }
    }
}

struct ItemImage_Previews: PreviewProvider {
    static var previews: some View {
        ItemImage(photoStatement: PhotoStatement())
    }
}
