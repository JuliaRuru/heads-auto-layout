//
//  CharacterNetworkManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 01.06.2022.
//

import Foundation
import Alamofire

protocol CharacterNetworkManager {
    func getCharacter(url: String, completion: ((Character?, Error?) -> ())?)
}

extension NetworkManager: CharacterNetworkManager {
    func getCharacter(url: String, completion: ((Character?, Error?) -> ())?) {
        performRequest(
        url: url,
        method: .get,
        onRequestCompleted: completion
        )
    }
}
