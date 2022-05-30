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
    func saveToKeychain(_ string: String, key: StorageManager.StorageManagerKey)
}

extension StorageManager: AuthentificationStorageManager {
    func saveToKeychain(_ string: String, key: StorageManager.StorageManagerKey) {
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.set(string, key: key.rawValue)
        } catch {
             print(error as Any)
        }
    }
}
