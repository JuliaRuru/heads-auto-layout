//
//  ResidentsCollectionViewCell.swift
//  hnh1
//
//  Created by Юлия Руднева on 02.06.2022.
//

import UIKit

class ResidentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var residentView: UIView!
    @IBOutlet weak var imageResidentImageView: UIImageView!
    @IBOutlet weak var nameResidentLabel: UILabel!
    @IBOutlet weak var genderResidentLabel: UILabel!
    @IBOutlet weak var speciesResidentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        residentView.layer.cornerRadius = 11
        residentView.layer.masksToBounds = true
        residentView.layer.borderWidth = 1
        residentView.layer.borderColor = UIColor.darkGray.cgColor
        imageResidentImageView.layer.cornerRadius = 11
        imageResidentImageView.layer.masksToBounds = true
        imageResidentImageView.alpha = 0.9
    }
}
