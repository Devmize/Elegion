//
//  LocationService.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 12.02.2025.
//

import CoreLocation

final class LocationService: NSObject {

    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?

    private var pinnedUserLocation: CLLocation?

    var authStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }

    override init() {
        super.init()
        self.setupLocationManager()
    }

    deinit {
        stopUpdatingLocation()
    }

    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    private func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    private func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func calculateDistance(from: CLLocation, to: CLLocation) -> CLLocationDistance? {

        let distance = from.distance(from: to)
        return distance
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            manager.allowsBackgroundLocationUpdates = true
            startUpdatingLocation()
        case .authorizedWhenInUse:
            startUpdatingLocation()
        case .denied, .restricted:
            stopUpdatingLocation()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}

// Имитация работы с сервером
extension LocationService {

    func sendLocationToServer() async throws -> Bool {

        // guard let location = currentLocation else { throw AppError.authentication(.userNotFound) }

        try await Task.sleep(nanoseconds: 1_000_000_000)

        // TODO: Обработка и отправка на сервев, в случае ошибки вернуть необходимый error
        // throw AppError.database(.writeFailed)

        return true
    }

    func fetchUsersLocations() async throws -> [User] {
        try await Task.sleep(nanoseconds: 1_500_000_000)

        // TODO: Отправка запроса на сервер, в случае ошибки вернуть необходимый error
        // AppError.database(.readFailed)

        // TODO: Вынести пользователей в отдельный сервис
        return [
            User(id: 0, image: "leps", name: "Eugene", coordinates: randomizeLocation(from: CLLocation(latitude: 55.751244, longitude: 37.618423), withRadius: 1)),
            User(id: 1, name: "Vita", coordinates: randomizeLocation(from: CLLocation(latitude: 55.752369, longitude: 37.619752), withRadius: 1)),
            User(id: 2, image: "cat", name: "Lina", coordinates: randomizeLocation(from: CLLocation(latitude: 55.749831, longitude: 37.616445), withRadius: 1)),
            User(id: 3, image: "leps", name: "Eugene", coordinates: randomizeLocation(from: CLLocation(latitude: 55.751244, longitude: 37.618423), withRadius: 2)),
            User(id: 4, name: "Vita", coordinates: randomizeLocation(from: CLLocation(latitude: 55.752369, longitude: 37.619752), withRadius: 2)),
            User(id: 5, image: "cat", name: "Lina", coordinates: randomizeLocation(from: CLLocation(latitude: 55.749831, longitude: 37.616445), withRadius: 2)),
            User(id: 6, image: "leps", name: "Eugene", coordinates: randomizeLocation(from: CLLocation(latitude: 55.751244, longitude: 37.618423), withRadius: 3)),
            User(id: 7, name: "Vita", coordinates: randomizeLocation(from: CLLocation(latitude: 55.752369, longitude: 37.619752), withRadius: 3)),
            User(id: 8, image: "cat", name: "Lina", coordinates: randomizeLocation(from: CLLocation(latitude: 55.749831, longitude: 37.616445), withRadius: 3)),
            User(id: 9, image: "leps", name: "Eugene", coordinates: randomizeLocation(from: CLLocation(latitude: 55.751244, longitude: 37.618423), withRadius: 4)),
            User(id: 10, name: "Vita", coordinates: randomizeLocation(from: CLLocation(latitude: 55.752369, longitude: 37.619752), withRadius: 4)),
            User(id: 11, image: "cat", name: "Lina", coordinates: randomizeLocation(from: CLLocation(latitude: 55.749831, longitude: 37.616445), withRadius: 4))
        ]
    }

    private func randomizeLocation(from location: CLLocation, withRadius radius: Double) -> CLLocation {
        // 1 градус широты приблизительно равен 111 километрам
        let metersPerDegreeLatitude = 111_000.0

        // Смещение в градусах
        let deltaLatitude = (Double.random(in: -1...1) * radius) / metersPerDegreeLatitude
        let deltaLongitude = (Double.random(in: -1...1) * radius) / (metersPerDegreeLatitude * cos(location.coordinate.latitude * .pi / 180))

        let newLatitude = location.coordinate.latitude + deltaLatitude
        let newLongitude = location.coordinate.longitude + deltaLongitude

        return CLLocation(latitude: newLatitude, longitude: newLongitude)
    }
}
