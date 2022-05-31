//
//  UserDefaultsStorageManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation
import KeychainAccess

private struct Constants {
    static let serviceId = "StorageManagerKeychain.Service.Id"
}

protocol UserDefaultsStorageManager {
    func saveToUserDefaults(bool: Bool, key: StorageManager.StorageManagerKey)
    func userDefaultsBool(key: StorageManager.StorageManagerKey) -> Bool
    func cleanKeychain()
}

extension StorageManager: UserDefaultsStorageManager {
    func saveToUserDefaults(bool: Bool, key: StorageManagerKey) {
        UserDefaults.standard.set(bool, forKey: key.rawValue)
    }

    func userDefaultsBool(key: StorageManagerKey) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    func cleanKeychain() {
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.removeAll()
        } catch {
            print(error as Any)
        }
    }
}
