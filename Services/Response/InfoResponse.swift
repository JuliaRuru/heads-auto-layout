//
//  InfoResponse.swift
//  hnh1
//
//  Created by Юлия Руднева on 30.05.2022.
//

import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
