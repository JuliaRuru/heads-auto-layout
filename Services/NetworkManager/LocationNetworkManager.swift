//
//  LocationNetworkManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation
import Alamofire

protocol LocationNetworkManager {
    func getLocations(url: String, completion: ((LocationResponse?, Error?) -> ())?)
//    func getCharacterList(url: String, completion: ((CharacterListResponse?, Error?) -> ())?)
}

extension NetworkManager: LocationNetworkManager {
    func getLocations(url: String, completion: ((LocationResponse?, Error?) -> ())?) {
        performRequest(
            url: url,
            method: .get,
            onRequestCompleted: completion
        )
    }
}
