//
//  ButtonModifiers.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI

struct ButtonModifiers: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 20)
            .padding()
            .foregroundColor(.white)
            .font(.system(size:14, weight: .bold))
            .background(Color.black)
            .cornerRadius(5.0)
    }
}
