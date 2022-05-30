//
//  StorageManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 19.05.2022.
//

import KeychainAccess
import Foundation

class StorageManager {
    
    enum StorageManagerKey: String {
        case token
        case notFirstLaunch
        case userId
    }
}
