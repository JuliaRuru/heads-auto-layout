//
//  ResultsResponse.swift
//  hnh1
//
//  Created by Юлия Руднева on 30.05.2022.
//

import Foundation

struct Results: Decodable {
    let id: Int
    let name: String
    let type: String
    let residents: [String]
}
