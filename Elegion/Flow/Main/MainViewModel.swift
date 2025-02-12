//
//  MainViewModel.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 10.02.2025.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {

    private let locationService = LocationService()

    @Published var users: [User] = []
    @Published var pinnedUser: User?

    var sortedUsers: [User] {
        guard let pinned = pinnedUser else { return users }

        var result = users
        if let pinnedIndex = result.firstIndex(where: { $0.id == pinned.id }) {
            result.remove(at: pinnedIndex)
        }
        return result
    }

    private var subscriptions = Set<AnyCancellable>()

    @MainActor
    init() {
        updateUsersLocations()

        let timerPublisher = Timer.publish(every: 3, on: .main, in: .default).autoconnect()

        timerPublisher.sink { [weak self] _ in
            self?.updateUsersLocations()
        }
        .store(in: &subscriptions)

        timerPublisher.sink { [weak self] _ in
            self?.updateCurrentLocation()
        }
        .store(in: &subscriptions)
    }

    deinit {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }

    @MainActor
    func updateUsersLocations() {
        Task {
            do {
                self.users = try await locationService.fetchUsersLocations()
            }
        }
    }

    @MainActor
    func updateCurrentLocation() {
        Task {
            do {
                _ = try await locationService.sendLocationToServer()
            }
        }
    }

    func calculateDistance(to: User) -> Double {
        if let pinned = pinnedUser {
            return locationService.calculateDistance(from: pinned.coordinates, to: to.coordinates) ?? 0
        }

        return locationService.calculateDistance(from: to.coordinates, to: to.coordinates) ?? 0
    }

    func togglePin(for user: User) {
        withAnimation {
            if pinnedUser?.id == user.id {
                pinnedUser = nil
            } else {
                pinnedUser = user
            }
        }
    }
}
