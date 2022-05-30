//
//  KeychainStorageManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation
import KeychainAccess

private struct Constants {
    static let serviceId = "StorageManagerKeychain.Service.Id"
}

protocol KeychainStorageManager {
    func cleanKeychain()
}

extension StorageManager: KeychainStorageManager {
    func cleanKeychain() {
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.removeAll()
        } catch {
            print(error as Any)
        }
    }
}
