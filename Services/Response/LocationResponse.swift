//
//  LocationResponse.swift
//  hnh1
//
//  Created by Юлия Руднева on 30.05.2022.
//

import Foundation
struct LocationResponse: Decodable {
    let info: Info
    let results: [Results]
}
