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
        }.navigationTitle(LocalizedStringKey("page_users"))
    }
}

#Preview {
    MainScreen()
}
