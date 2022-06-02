//
//  Gender.swift
//  hnh1
//
//  Created by Юлия Руднева on 01.06.2022.
//

import Foundation

enum Gender: String, Decodable {
    case Female
    case Male
    case Genderless
    case unknown
    
    var representedValue: String {
        switch self {
        case .Female:
            return "Женщина"
        case .Male:
            return "Мужчина"
        case .Genderless:
            return "Бесполый"
        case .unknown:
            return "Неизвестно"
        }
    }
}
