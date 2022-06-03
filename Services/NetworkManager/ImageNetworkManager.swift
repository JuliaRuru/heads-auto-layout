//
//  ImageNetworkManager.swift
//  hnh1
//
//  Created by Юлия Руднева on 01.06.2022.
//

import Foundation
import Alamofire

protocol ImageNetworkManager {
    func getImage(urlString: String, completion: ((Data?, Error?) -> ())?)
}
    
extension NetworkManager: ImageNetworkManager {
    func getImage(urlString: String, completion: ((Data?, Error?) -> ())?) {
        dataRequest(
        url: urlString,
        method: .get,
        onRequestCompleted: completion
        )
    }
}
