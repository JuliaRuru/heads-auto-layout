//
//  AppSnackBar.swift
//  hnh1
//
//  Created by Юлия Руднева on 24.05.2022.
//

import UIKit
import SnackBar

class AppSnackBar: SnackBar {
    
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .white
        style.textColor = .darkGray
        return style
    }
    
    static func showMessageSnackBar(in view: UIView?, message: String) {
        if let view = view {
            make(in: view, message: message, duration: .lengthLong).show()
        }
    }
}
