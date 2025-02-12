//
//  ElegionApp.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 10.02.2025.
//

import SwiftUI

@main
struct ElegionApp: App {

    @StateObject private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            AppNavigationView()
                .environmentObject(router)
        }
    }
}
