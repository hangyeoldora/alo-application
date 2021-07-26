//
//  MarketPost.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import SwiftUI

struct MarketPost: View {
    @State private var marketImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = ""
    
    // Upload Post Text Editor reference signupView all func
    @State private var text1 = ""
    @State private var text2 = ""
    @State private var text3 = ""
    @State private var num = 0
    // 07.01 Add Success Alert func
    @State private var marketTitle: String = "Upload Success"
    
    func loadImage() {
        guard let inputImage = pickedImage else {return }
        
        marketImage = inputImage
    }
    
    // firebase 업로드 기능, signUpView에서 func signUp 복사한 후, authservice 및 error부분 제거
    // func 한 후, 아래쪽 버튼 action에 함수명 기입
    // button에 업로드했다고 alert 추가
    func uploadMarket() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            self.clear()
            return
        }
        //firebase
        
        MarketService.uploadMarket(title: text1, price: num, imageData: imageData, status: text2, content: text3, onSuccess: {
            self.showingAlert = true
            self.error = marketTitle
            self.alertTitle = "Great"
            self.clear()
        }) {
            (errorMessage) in
            
            self.error = errorMessage
            self.alertTitle = "Upload Failure"
            self.showingAlert = true
            return
        }

    }
    
    func clear() {
        self.text1 = ""
        self.text2 = ""
        self.text3 = ""
        self.imageData = Data()
        self.marketImage = Image(systemName: "photo.fill")
    }
    
    func errorCheck() -> String? {
        if text1.trimmingCharacters(in: .whitespaces).isEmpty ||
            text2.trimmingCharacters(in: .whitespaces).isEmpty ||
            text3.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty{
            
            return "Please add a caption and provide an image"
        }
        return nil
    }
    
    var body: some View{
        VStack{
            Text("장터 글쓰기")
                .font(.title)
            Spacer()
            VStack(alignment: .center){
                if marketImage != nil {
                    marketImage!.resizable()
                        .frame(width: 300, height: 200)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                } else {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .foregroundColor(.pink)
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                }
            }
            Spacer()
            TextEditor(text: $text1)
                .frame(height: 50)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                .padding(.horizontal)
            
            TextEditor(text: $text2)
                .frame(height: 50)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                .padding(.horizontal)
            TextEditor(text: $text3)
                .frame(height: 50)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                .padding(.horizontal)
            Spacer()
            Button(action: uploadMarket) {
                Text("글 Upload").font(.title).modifier(TransParentButtonModifiers())
            }.alert(isPresented: $showingAlert){
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }.padding().ignoresSafeArea()
        .sheet(isPresented: $showingImagePicker,
                onDismiss: loadImage){
            ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }.actionSheet(isPresented: $showingActionSheet)
        {
            ActionSheet(title: Text(""), buttons: [
                            .default(Text("Choose A Photo")){
                                self.sourceType = .photoLibrary
                                self.showingImagePicker = true
                            },
                            .default(Text("Take A Photo")){
                                self.sourceType = .camera
                                self.showingImagePicker = true
                            }, .cancel()
            ])
        }
    }
}
