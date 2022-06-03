//
//  UserPhotoTableViewCell.swift
//  hnh1
//
//  Created by Юлия Руднева on 01.05.2022.
//

import UIKit

class UserPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circlePhotoImageView: UIImageView!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        circlePhotoImageView.layer.cornerRadius = circlePhotoImageView.frame.height / 2
        circlePhotoImageView.layer.borderWidth = 5
        circlePhotoImageView.layer.borderColor = UIColor.white.cgColor
    }
}
