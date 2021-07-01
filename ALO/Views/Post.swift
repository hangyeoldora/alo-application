//
//  Add.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI

struct Post: View {
    
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = ""
    
    
    // Upload Post Text Editor reference signupView all func
    @State private var text = ""
    
    // 07.01 Add Success Alert func
    @State private var postTitle: String = "Upload Success"
    
    func loadImage() {
        guard let inputImage = pickedImage else {return }
        
        postImage = inputImage
    }
    
    // firebase 업로드 기능, signUpView에서 func signUp 복사한 후, authservice 및 error부분 제거
    // func 한 후, 아래쪽 버튼 action에 함수명 기입
    // button에 업로드했다고 alert 추가
    func uploadPost() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            self.clear()
            return
        }
        //firebase
        
        PostService.uploadPost(caption: text, imageData: imageData, onSuccess: {
            // 07.01 Add postAlert
            self.showingAlert = true
            self.error = postTitle
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
        self.text = ""
        self.imageData = Data()
        self.postImage = Image(systemName: "photo.fill")
    }
    
    func errorCheck() -> String? {
        if text.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty{
            
            return "Please add a caption and provide an image"
        }
        return nil
    }
    
    var body: some View {
        
        VStack{
            Text("Upload A Post")
                .font(.largeTitle)
            
            VStack{
                if postImage != nil {
                    postImage!.resizable()
                        .frame(width: 300, height: 200)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .frame(width: 300, height: 200)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                }
            }
            
            TextEditor(text: $text)
                .frame(height: 200)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                .padding(.horizontal)
            
            Button(action: uploadPost) {
                Text("Upload Post").font(.title).modifier(ButtonModifiers())
            }.alert(isPresented: $showingAlert){
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
            }
        }.padding()
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
