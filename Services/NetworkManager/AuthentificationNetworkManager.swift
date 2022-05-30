//
//  AuthentificationNetworkManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation
import Alamofire

protocol AuthentificationNetworkManager {
    func аuthentification(username: String, password: String, completion: ((TokenResponse?, Error?) -> ())?)
}

extension NetworkManager: AuthentificationNetworkManager {
    func аuthentification(username: String, password: String, completion: ((TokenResponse?, Error?) -> ())?) {
        performRequest(
            url: "https://nanopost.evolitist.com/api/auth/login?username=\(username)&password=\(password)",
            method: .get,
            onRequestCompleted: completion
        )
    }
}
