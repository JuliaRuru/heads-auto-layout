//
//  UserDefaultsStorageManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation

protocol UserDefaultsStorageManager {
    func saveToUserDefaults(bool: Bool, key: StorageManager.StorageManagerKey)
    func userDefaultsBool(key: StorageManager.StorageManagerKey) -> Bool
}

extension StorageManager: UserDefaultsStorageManager {
    func saveToUserDefaults(bool: Bool, key: StorageManagerKey) {
        UserDefaults.standard.set(bool, forKey: key.rawValue)
    }

    func userDefaultsBool(key: StorageManagerKey) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
