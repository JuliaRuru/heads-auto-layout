//
//  NetworkManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 21.05.2022.
//

import Foundation
import Alamofire

class NetworkManager {
 func performRequest<ResponseType: Decodable>(
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        onRequestCompleted: ((ResponseType?, Error?) -> ())?
    ) {
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate()
            .responseData { (afDataResponse) in
                
                guard let data = afDataResponse.data,
                      afDataResponse.error == nil
                else {
                    onRequestCompleted?(nil, afDataResponse.error)
                    return
                }
                
                do {
                    let decodedValue: ResponseType = try JSONDecoder().decode(ResponseType.self, from: data)
                    onRequestCompleted?(decodedValue, nil)
                }
                catch (let error) {
                    print("Response parsing error: \(error.localizedDescription)")
                    onRequestCompleted?(nil, error)
                }
            }
    }
}

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

protocol ProfileNetworkManager {
    func getProfile(profileId: String, completion: ((Profile?, Error?) -> ())?)
}

extension NetworkManager: ProfileNetworkManager {
    func getProfile(profileId: String, completion: ((Profile?, Error?) -> ())?) {
        performRequest(
            url: "https://nanopost.evolitist.com/api/v1/profile/\(profileId)",
            method: .get,
            parameters: nil,
            headers: nil,
            onRequestCompleted: completion
        )
    }
}
