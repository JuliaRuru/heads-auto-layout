//
//  ProfileStorageManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation
import KeychainAccess

private struct Constants {
    static let serviceId = "StorageManagerKeychain.Service.Id"
}

protocol ProfileStorageManager {
    func loadUserId() -> String?
}

extension StorageManager: ProfileStorageManager {
     func loadUserId() -> String? {
         let keychain = Keychain(service: Constants.serviceId)
         do {
             let result = try keychain.get(StorageManagerKey.userId.rawValue)
             return result
         } catch {
             print(error as Any)
         }
         return nil
     }
}
