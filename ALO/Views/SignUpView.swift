//
//  SignUpView.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no 😭"
    
    // 07.01 add
    @State private var isLinkActive = false
    
    func loadImage() {
        guard let inputImage = pickedImage else {return }
        
        profileImage = inputImage
    }
    
    
    //유저 field 입력 체크
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty{
            
            return "Please fill in all fileds and provide an image"
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.username = ""
        self.password = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: {
            (user) in
            self.clear()
        }) {
            (errorMessage) in
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    
    
    var body: some View {

        ScrollView {
            VStack(spacing: 20){
                VStack(alignment: .center){
                    Text("SignUp To Start").font(.system(size:32, weight: .regular)).foregroundColor(.pink)
                }
                
                VStack{
                    Group{
                        if profileImage != nil {
                            profileImage!.resizable()
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .frame(width: 120, height: 120)
                                .padding(.top, 20)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .frame(width: 100, height: 100)
                                .padding(.top, 20)
                                .foregroundColor(.pink)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }
                    }
                }
                
                Group{
                    FormField(value: $username, icon: "person.fill", placeholder: "username")
                    FormField(value: $email, icon: "envelope.fill", placeholder: "E-mail")
                    FormField(value: $password, icon: "lock.fill", placeholder: "Password", isSecure: true)
                }
                    
                NavigationLink(destination: SignInView(), isActive: $isLinkActive){
                Button(action: {signUp()
                    self.isLinkActive = true
                }){
                        Text("Sign Up").font(.title)
                            .modifier(TransParentButtonModifiers())
                }
                    }.alert(isPresented: $showingAlert){
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                    }
//                HStack{
//                    Text("Got an Account?")
//                    NavigationView {
//                        Text("Sign In.").font(.system(size: 20, weight: .semibold))
//                    }
//                }
            }.padding()
        }.sheet(isPresented: $showingImagePicker,
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

