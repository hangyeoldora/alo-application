//
//  SignInView.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI

struct SignInView: View {
    // 07.01 add
    @EnvironmentObject var session: SessionStore
    @State var shouldShowToast : Bool = false
    
    func listen(){
        session.listen()
    }
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh no 😭"
    
    //유저 field 입력 체크
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty
        {
            
            return "모든 칸을 채워주세요."
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.password = ""
    }
    
    func signIn() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signIn(email: email, password: password, onSuccess: {
            (user) in
            self.clear()
        }) {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    var body: some View {
        ZStack{
            NavigationView {
                VStack(spacing: 20){
                    Image("alo_main_logo").font(.system(size: 60, weight: .black, design: .monospaced)).padding(.bottom, 15)
                    
                    VStack(alignment: .center){
                        Text("Welcome! We are ALO.").font(.system(size:25, weight: .medium)).foregroundColor(.pink)
    //                    Text("SignIn To Continue").font(.system(size:16, weight: .medium))
                    }.padding(.bottom, 30)

                    VStack(alignment: .center){
                        FormField(value: $email, icon: "envelope.fill", placeholder: "E-mail").foregroundColor(.pink)
                        FormField(value: $password, icon: "lock.fill", placeholder: "Password", isSecure: true).foregroundColor(.pink)
                    }

                    // 07.01 default setup
    //                    Button(action: signIn){
    //                        Text("Login").font(.title)
    //                            .modifier(TransParentButtonModifiers())
    //                    }.alert(isPresented: $showingAlert){
    //                        Alert(title: Text(alertTitle), message: Text(error), dismissButton:                               .default(Text("OK")))
    //                    }
                    VStack{
                        Button(action: {signIn()
                            listen()
                        }){
                            Text("Login").font(.title)
                                    .modifier(TransParentButtonModifiers())
                        }.alert(isPresented: $showingAlert){
                            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                        }
                        HStack{
                            Text("New?")
                            NavigationLink(destination: SignUpView()) {
                                Text("Create an account")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.pink).opacity(10)
                            }.navigationTitle("")
                        }.padding(.bottom, 20)
                        
                        

                        Button(action : {
                            self.shouldShowToast = true
                        }, label: {
                            Text("다른 방법으로 로그인")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.gray).opacity(10)
                        })
                    }
                }.padding()
            }.accentColor( .pink)
        }.popup(isPresented: $shouldShowToast, type: .toast, position: .bottom, animation: .default, closeOnTap: true, closeOnTapOutside: false, view:  {
            SNSSignUpView()
                .frame(width: UIScreen.main.bounds.width, height: 350)
                .background(Color(red: 0.85, green: 0.8, blue: 0.95))
        })
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

