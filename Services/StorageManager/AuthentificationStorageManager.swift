//
//  AuthentificationStorageManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation
import KeychainAccess

private struct Constants {
    static let serviceId = "StorageManagerKeychain.Service.Id"
}

protocol AuthentificationStorageManager {
    func save(token: TokenResponse)
//    func saveUserIdToKeychain(_ string: String, key: StorageManager.StorageManagerKey)
}

extension StorageManager: AuthentificationStorageManager {
    func save(token: TokenResponse) {
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.set(token.token, key: StorageManagerKey.token.rawValue)
            try keychain.set(token.userId, key: StorageManagerKey.userId.rawValue)
        } catch {
             print(error as Any)
        }
    }
}
