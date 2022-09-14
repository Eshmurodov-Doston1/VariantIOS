import SwiftUI
import SDWebImageSwiftUI
import ACarousel
import Network

struct CreateUpdateImage: View {
    @State var listPhotoStatement:[PhotoStatement]
    @Binding var clickIndex:Double 
    @State var isImagePicker = false
    @State var isShowing = false
    @State var isLoadingUpload = false
    @State var sourseType:UIImagePickerController.SourceType = .camera
    @State var image:UIImage? = nil
    @Binding var data:Data
    @Binding var isUpload:Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
           
            ACarousel(listPhotoStatement,id: \.type,spacing: -20,sidesScaling: 0.7) { photoStatement in
                ZStack {
                    WebImage(url: URL(string: "http://web.variantgroup.uz/\(photoStatement.file_link!)"))
                        .placeholder {
                            Rectangle().foregroundColor(.gray.opacity(0.2))
                                .cornerRadius(30)
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width - 20, height: UIScreen.main.bounds.size.height/2)
                        .cornerRadius(10)
                    
                    VStack {
                        Spacer()
                        Button(action: {
                            isShowing.toggle()
                        }, label: {
                            Image(systemName: "square.and.arrow.up.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("button_color"))
                        })
                        .frame(width: UIScreen.main.bounds.size.width/2.8, height: 50)
                        .background(.white)
                        .cornerRadius(25)
                        .padding(.bottom)
                        .actionSheet(isPresented: $isShowing, content: {
                            ActionSheet(title: Text("upload_image".localized()).foregroundColor(.black), message: Text("get_file".localized()), buttons: [
                                .default(Text("camera".localized())
                                    .foregroundColor(.black.opacity(0.7)),action: {
                                    self.isImagePicker = true
                                    self.sourseType = .camera
                                }),
                                .default(Text("gallery".localized()),action: {
                                    self.isImagePicker = true
                                    self.sourseType = .photoLibrary
                                }),
                                .cancel()
                            ])
                        })
                        .sheet(isPresented: self.$isImagePicker, content: {
                            ImagePicker(image: self.$image, isShown: self.$isImagePicker,sourceType:self.sourseType)
                                .onDisappear {
                                    if image != nil {
                                        print(data.token!)
                                        uploadImage(image: image!, phototStatement: photoStatement)
                                        isUpload = true
                                    }
                                }
                        })
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: UIScreen.main.bounds.size.height/2)
                }
               
            }
            
            if isLoadingUpload {
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
                            .background(Color.white)
                            .foregroundColor(Color.primary)
                            .cornerRadius(15)
                            Spacer()
                        }

                        Spacer()
                    }

                }
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
            }
         
        }
        .onAppear{
            let photoStatment = listPhotoStatement[0]
            listPhotoStatement[0] = listPhotoStatement[Int(clickIndex-1)]
            listPhotoStatement[Int(clickIndex-1)] = photoStatment
        }
      
  }
    
    func uploadImage(image:UIImage,phototStatement:PhotoStatement){
        isLoadingUpload = true
        AFHttp.uploadFile(image: image, params: UserParams.paramsUploadImageUpdate(uploadImage: UploadImage(token: data.token!, type: phototStatement.type!)), holder: { response in
                switch response.result {
                case.success:
                    print(data.photo_status)
                    getImageUpload()
                    print("ResponseUploadImage:\(response.result)")
                case.failure(let error):
                    print("Error:\(error)")
                }
            })
    }
    
    
    
    func getImageUpload(){
        AFHttp.optimalFunc(method: .post, params: UserParams.paramsImages(userToken: UserToken(token: data.token!)), url: UserParams.GET_UPLOAD_IMAGES, holder: { response in
            switch response.result {
            case.success:
                listPhotoStatement = try! JSONDecoder().decode([PhotoStatement].self, from: response.data!)
                isLoadingUpload = false
              case.failure(let error):
                print(error)
            }
        })
    }
    
}

struct CreateUpdateImage_Previews: PreviewProvider {
    static var previews: some View {
        CreateUpdateImage(listPhotoStatement: [PhotoStatement](), clickIndex: .constant(1),data: .constant(Data(status: "", level: 0, client_id: 0, contract_number: "", photo_status: 0, token: "", status_title: "", full_name: "")), isUpload: .constant(false))
    }
}







