//
//  TransParentButtonModifiers.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import SwiftUI

struct TransParentButtonModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 20)
            .padding()
            .foregroundColor(.pink)
            .font(.system(size:14, weight: .bold))
            .background(Color.white)
            .cornerRadius(5.0)
    }
}
