import SwiftUI

struct StatmentScreen: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State var data:Data
    @State var listUploadImage = [PhotoStatement]()
    @State var isClikclImage = false
    @State var itemPhotoStatement:PhotoStatement = PhotoStatement()
    @State var clickIndex:Double = -1
    @State var isShowing = false
    @State var showImagePicker:Bool = false
    @State var sourseType:UIImagePickerController.SourceType = .camera
    @State var image:UIImage? = nil
    
    @State var isLoadingUpload = false
    @State var isLoadingList = false
    
    @EnvironmentObject var defaults:Defaults
    @EnvironmentObject var statusApp:StatusApp
    @State var isUpload = false
    var body: some View {
           ZStack {
               
               if defaults.theme ?? false {
                   Color.black.onAppear{}.preferredColorScheme(.dark)
               }else{
                   Color.white.onAppear{}.preferredColorScheme(.light)
               }
              
               
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing:20){
                        HStack {
                            Spacer()
                            LottieView(lottieFile: "upload_anim")
                                .frame(width: UIScreen.main.bounds.size.width/1.5, height: UIScreen.main.bounds.size.height/4)
                            Spacer()
                        }
                        Button(action: {
                            if data.photo_status ?? 0 < 6 {
                                isShowing.toggle()
                            }
                        }, label: {
                            Image(systemName: "square.and.arrow.up.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        })
                        .padding(.horizontal,30)
                        .padding(.top,10)
                        .padding(.bottom,13)
                        .background(Color("button_color"))
                        .cornerRadius(10)
                        .actionSheet(isPresented: $isShowing, content: {
                            ActionSheet(title: Text("upload_image".localized())
                                .foregroundColor(.black), message: Text("get_file".localized()), buttons: [
                            .default(Text("camera".localized())
                                .foregroundColor(.black.opacity(0.7)),action: {
                                self.showImagePicker = true
                                self.sourseType = .camera
                            }),
                            .default(Text("gallery".localized()),action: {
                                self.showImagePicker = true
                                self.sourseType = .photoLibrary
                            }),
                            .cancel()
                           ])
                        })
                        .sheet(isPresented: self.$showImagePicker, content: {
                            ImagePicker(image: $image, isShown: self.$showImagePicker,sourceType: self.sourseType)
                                .onDisappear{
                                    if image != nil {
                                        uploadImage(image: self.image!)
                                    }
                                   
                                }
                        })
                        
                        if isLoadingList {
                                ProgressView("Loading...")
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                    .foregroundColor(.blue)
                                    .padding(.top,30)
                        }else{
                            if listUploadImage.isEmpty == false {
                                LazyVGrid(columns: columns){
                                    ForEach(listUploadImage,id:\.type){ item in
                                        Button(action: {
                                            for i in 0...listUploadImage.count-1 {
                                                if listUploadImage[i].id == item.id {
                                                    clickIndex = Double(i+1)
                                                    break
                                                }
                                            }
                                            self.isClikclImage = true
                                        }, label: {
                                            ItemImage(photoStatement: item)
                                        })
                                    }
                                }
                                .padding(.horizontal,5)
                                .font(.largeTitle)
                            } else {
                                LottieView(lottieFile: "empty")
                                    .frame(width: UIScreen.main.bounds.size.width/3, height: UIScreen.main.bounds.size.height/6)
                            }
                        }
                    }
                }
               
               if isClikclImage {
                   CreateUpdateImage(listPhotoStatement: listUploadImage, clickIndex: $clickIndex,data: self.$data,isUpload: self.$isUpload)
                           .onTapGesture {
                               isClikclImage = false
                            }
                           .onDisappear{
                               if isUpload {
                                   getImageUpload()
                               }
                           }
               }
               // in z stack
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
                               .background(defaults.theme ?? false ? Color("darck_color") : Color.white)
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
                getImageUpload()
            }
        
      
        
        
        
        
      //  CreateUpdateImage(photoStatement: item)
        
       
    }
    
    func uploadImage(image:UIImage){
        isLoadingUpload = true
        if data.photo_status! < 6 {
            data.photo_status! += 1
            AFHttp.uploadFile(image: image, params: UserParams.paramsUploadImage(uploadImage: UploadImage(token: data.token!, type: data.photo_status!)), holder: { response in
                switch response.result {
                case.success:
                    getData()
                    getImageUpload()
                case.failure(let error):
                    print("Error:\(error)")
                }
            })
        }
    }
    
    
    func getImageUpload(){
        isLoadingList = true
        AFHttp.optimalFunc(method: .post, params: UserParams.paramsImages(userToken: UserToken(token: data.token!)), url: UserParams.GET_UPLOAD_IMAGES, holder: { response in
            switch response.result {
            case.success:
                listUploadImage = try! JSONDecoder().decode([PhotoStatement].self, from: response.data!)
                isLoadingList = false
              case.failure(let error):
                print(error)
            }
        })
    }
    
    func getData(){
        
        AFHttp.optimalFunc(method: .post, params: UserParams.paramsImages(userToken: UserToken(token: data.token!)), url: UserParams.GET_APPLICATION, holder: { response in
            switch response.result {
            case.success:
                let data = try! JSONDecoder().decode(Application.self, from: response.data!)
                self.data.photo_status = data.photo_status
                isLoadingUpload = false 
            case.failure(let error):
                print(error)
            }
        })
    }

}

struct StatmentScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatmentScreen(data: Data(status: "", level: 0, client_id: 0, contract_number: "", photo_status: 0, token: "", status_title: "", full_name: ""),listUploadImage: [PhotoStatement]())
            .environmentObject(Defaults())
            .environmentObject(StatusApp())
    }
}


