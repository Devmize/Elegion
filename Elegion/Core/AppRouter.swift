//
//  AppRouter.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 10.02.2025.
//

import SwiftUI

enum Route: Hashable {
    case main
    case profile
}

@MainActor
final class AppRouter: ObservableObject {

    @Published var startPath = NavigationPath()

    @Published var launchRootPath = true

    init() {
        // Инициализация всех путей в таббаре
    }

    func rootView() -> some View {
        MainScreen()
            .environmentObject(self)
    }

    func navigate(to route: Route) {
        if launchRootPath {
            startPath.append(route)
        } else {
            // Для путей в таббаре
        }
    }

    func popToRoot() {
        if launchRootPath {
            startPath.removeLast(startPath.count)
        } else {
            // Для путей в таббаре
        }
    }

    func pop() {
        guard canPop else { return }
        if launchRootPath {
            startPath.removeLast()
        } else {
            // Для путей в таббаре
        }
    }
}

extension AppRouter {
    var canPop: Bool {
        if launchRootPath {
            return !startPath.isEmpty
        }
        // Для путей в таббаре
        return false
    }
}
