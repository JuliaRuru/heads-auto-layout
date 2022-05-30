//
//  ProfileNetworkManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation
import Alamofire

protocol ProfileNetworkManager {
    func getProfile(profileId: String, completion: ((Profile?, Error?) -> ())?)
}

extension NetworkManager: ProfileNetworkManager {
    func getProfile(profileId: String, completion: ((Profile?, Error?) -> ())?) {
        performRequest(
            url: "https://nanopost.evolitist.com/api/v1/profile/\(profileId)",
            method: .get,
            onRequestCompleted: completion
        )
    }
}
