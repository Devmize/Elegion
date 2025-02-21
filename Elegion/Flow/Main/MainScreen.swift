//
//  MainScreen.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 10.02.2025.
//

import SwiftUI

struct MainScreen: View {

    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        VStack {
            switch viewModel.authStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                authorizationView()
            case .denied, .restricted:
                settingsView()
            case .notDetermined:
                Text("Запросить доступ")
                    .onAppear {
                        viewModel.fetchAccessToGeo()
                    }
                    .onTapGesture {
                        viewModel.fetchAccessToGeo()
                    }
                    .navigationTitle("")
            @unknown default:
                Text("Что-то пошло не так")
                    .navigationTitle("")
            }
        }
        .animation(.default, value: viewModel.authStatus)
    }

    @ViewBuilder
    func authorizationView() -> some View {
        VStack {
            ScrollView {
                if let pinnedUser = viewModel.pinnedUser {
                    UserCell(user: pinnedUser, distance: 0)
                        .frame(height: 128)
                        .onTapGesture {
                            viewModel.togglePin(for: pinnedUser)
                        }
                }
                LazyVStack {
                    ForEach(viewModel.sortedUsers) { user in
                        UserCell(user: user, distance: viewModel.calculateDistance(to: user))
                            .frame(height: 64)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .onTapGesture {
                                viewModel.togglePin(for: user)
                            }
                    }
                }
                .padding(.top, 32)
            }
        }
        .navigationTitle(LocalizedStringKey("page_users"))
    }

    @ViewBuilder
    func settingsView() -> some View {
        VStack(spacing: 32) {
            Text("""
                 Вы не предоставили доступ к геопозиции.
                 Для возможности пользоваться экраном - предоставьте доступ.
                 """
            )
            .multilineTextAlignment(.center)

            Button {
                viewModel.openAppSettings()
            } label: {
                Text("Открыть настройки")
            }
                .defaultButtonModifier()
        }
        .padding(.horizontal, 20)
        .navigationTitle("")
    }
}

#Preview {
    MainScreen()
}
