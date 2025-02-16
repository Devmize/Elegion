//
//  DefaultButtonModifier.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 17.02.2025.
//

import SwiftUI

struct DefaultButtonModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(width: 256, height: 64)
            .background(.black)
            .foregroundStyle(.white)
            .cornerRadius(16)
    }
}

extension View {
    func defaultButtonModifier() -> some View {
        modifier(DefaultButtonModifier())
    }
}
