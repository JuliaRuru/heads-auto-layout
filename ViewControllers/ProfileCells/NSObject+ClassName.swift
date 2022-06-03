//
//  NSObject+ClassName.swift
//  hnh1
//
//  Created by Юлия Руднева on 01.05.2022.
//

import Foundation

public extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
