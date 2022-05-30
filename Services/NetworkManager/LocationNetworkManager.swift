//
//  LocationNetworkManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import Foundation
import Alamofire

protocol LocationNetworkManager {
    func getLocations(completion: ((LocationResponse?, Error?) -> ())?)
}

extension NetworkManager: LocationNetworkManager {
    func getLocations(completion: ((LocationResponse?, Error?) -> ())?) {
        performRequest(
            url: "https://rickandmortyapi.com/api/location",
            method: .get,
            onRequestCompleted: completion
        )
    }
}
