//
//  User.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 10.02.2025.
//

import Foundation
import CoreLocation

struct User: Identifiable, Equatable {
    let id: Int
    var image: String = "default"
    var name: String
    var coordinates: CLLocation
}
