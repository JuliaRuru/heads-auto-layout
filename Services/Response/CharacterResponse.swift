//
//  CharacterResponse.swift
//  hnh1
//
//  Created by Юлия Руднева on 01.06.2022.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let species: String
    let gender: Gender
    let image: String
}
