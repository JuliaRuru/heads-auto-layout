//
//  ProfileColorTableViewCell.swift
//  hnh1
//
//  Created by Юлия Руднева on 01.05.2022.
//

import UIKit

class ProfileColorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var squareTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        squareTextLabel.layer.cornerRadius = 8
        squareTextLabel.layer.masksToBounds = true
    }
}
