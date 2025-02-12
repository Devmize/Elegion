//
//  AppNavigationView.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 10.02.2025.
//

import SwiftUI

struct AppNavigationView: View {

    @EnvironmentObject private var router: AppRouter

    var body: some View {
        NavigationStack {
            MainScreen()
        }
    }
}

#Preview {
    AppNavigationView()
}
