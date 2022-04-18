//
//  flickeringButton.swift
//  hnh1
//
//  Created by Юлия Руднева on 18.04.2022.
//

import UIKit

class flickeringButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? .green : .orange
        }
    }
}
