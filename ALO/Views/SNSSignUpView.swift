//
//  SNSSignUpView.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import SwiftUI
import ExytePopupView

struct SNSSignUpView: View {
    
    @State var showingPopup = false
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            Text("다른 방법으로 로그인")
                .font(.system(size:22, weight: .medium))
                .foregroundColor(.black)
                .padding(.bottom, 20)
            Spacer()
            VStack{
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Sign In with Google")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 15)
                        .padding()
                        .background(Color.red)
                        .font(.system(size:17, weight: .bold))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                })

                Button(action: {}, label: {
                    Text("Sign In with Facebook")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 15)
                        .padding()
                        .background(Color.blue)
                        .font(.system(size:17, weight: .bold))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                })

                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Sign In with Apple")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 15)
                        .padding()
                        .background(Color.black)
                        .font(.system(size:17, weight: .bold))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Sign In with Wechat")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 15)
                        .padding()
                        .background(Color.green)
                        .font(.system(size:17, weight: .bold))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                })
            }
            Spacer()
        }.padding(30)
    }
}
