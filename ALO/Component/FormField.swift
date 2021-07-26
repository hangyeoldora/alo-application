//
//  FormField.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI

struct FormField: View {
    @Binding var value: String
    var icon:String
    var placeholder: String
    var isSecure = false
    
    var body: some View {
        Group{
            HStack{
                Image(systemName: icon).padding()
                Group{
                    if isSecure {
                        SecureField(placeholder, text: $value)
                    } else {
                        TextField(placeholder, text: $value)
                    }
                }.font(Font.system(size:20, design: .monospaced))
                .foregroundColor(.black)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            }.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.pink, lineWidth: 2)).padding()
        }
    }
}
