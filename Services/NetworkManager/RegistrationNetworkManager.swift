//
//  RegistrationNetworkManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation
import Alamofire

protocol RegistrationNetworkManager {
    func checkUsername(username: String, completion: ((CheckUsername?, Error?) -> ())?)
    func registration(username: String, password: String, completion: ((TokenResponse?, Error?) -> ())?)
}

extension NetworkManager: RegistrationNetworkManager {
    
    func checkUsername(username: String, completion: ((CheckUsername?, Error?) -> ())?) {
        performRequest(
            url: "https://nanopost.evolitist.com/api/auth/checkUsername?username=\(username)",
            method: .get,
            onRequestCompleted: completion
        )
    }
    
    func registration(username: String, password: String, completion: ((TokenResponse?, Error?) -> ())?) {
        let parameters: [String: String] = ["username": username,
                                            "password": password]
        performRequest(
            url: "https://nanopost.evolitist.com/api/auth/register",
            method: .post,
            parameters: parameters,
            headers: nil,
            onRequestCompleted: completion
        )
    }
}

