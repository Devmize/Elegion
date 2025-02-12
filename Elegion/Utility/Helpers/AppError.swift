//
//  AppError.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 12.02.2025.
//

import Foundation

enum AppError: Error {
    case network(NetworkError)
    case database(DatabaseError)
    case authentication(AuthenticationError)
    case validation(ValidationError)

    enum NetworkError: Error {
        case badUrl
        case requestFailed
        case noInternterConnection
        case timeout
    }

    enum DatabaseError: Error {
        case writeFailed
        case readFailed
        case deleteFailed
    }

    enum AuthenticationError: Error {
        case invalidCredentials
        case userNotFound
        case sessionExpired
        case unauthorized
    }

    enum ValidationError: Error {
        case invalidInput(field: String)
        case missingRequiredField(field: String)
        case valueOutOfRange
    }
}
