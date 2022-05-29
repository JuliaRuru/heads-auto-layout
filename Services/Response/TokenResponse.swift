//
//  TokenResponse.swift
//  hnh1
//
//  Created by Юлия Руднева on 22.05.2022.
//

import Foundation

struct TokenResponse: Decodable {
    let token: String
    let userId: String
}
