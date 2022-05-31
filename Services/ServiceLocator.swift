//
//  ServiceLocator.swift
//  hnh1
//
//  Created by Юлия Руднева on 24.05.2022.
//

struct ServiceLocator {
    
    static func registrationNetworkManager() ->
    RegistrationNetworkManager {
        NetworkManager()
    }
    
    static func authentificationNetworkManager() ->
    AuthentificationNetworkManager {
        NetworkManager()
    }
    
    static func profileNetworkManager() ->
    ProfileNetworkManager {
        NetworkManager()
    }
    
    static func authentificationStorageManager() ->
    AuthentificationStorageManager {
        StorageManager()
    }
    
    static func profileStorageManager() ->
    ProfileStorageManager {
        StorageManager()
    }
    
//    static func keychainStorageManager() ->
//    KeychainStorageManager {
//        StorageManager()
//    }
    
    static func userDefaultsStorageManager() ->
    UserDefaultsStorageManager {
        StorageManager()
    }
    
    static func locationNetworkManager() ->
    LocationNetworkManager {
        NetworkManager()
    }
}
