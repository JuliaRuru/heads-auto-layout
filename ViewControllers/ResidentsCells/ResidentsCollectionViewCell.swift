//
//  ResidentsCollectionViewCell.swift
//  hnh1
//
//  Created by Юлия Руднева on 02.06.2022.
//

import UIKit
import JGProgressHUD

class ResidentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var residentView: UIView!
    @IBOutlet weak var imageResidentImageView: UIImageView!
    @IBOutlet weak var nameResidentLabel: UILabel!
    @IBOutlet weak var genderResidentLabel: UILabel!
    @IBOutlet weak var speciesResidentLabel: UILabel!
    let progressHUD = JGProgressHUD()
    var characterId: String?
    var imageId: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        progressHUD.show(in: imageResidentImageView)
        residentView.layer.cornerRadius = 11
        residentView.layer.masksToBounds = true
        residentView.layer.borderWidth = 1
        residentView.layer.borderColor = UIColor.darkGray.cgColor
        imageResidentImageView.layer.cornerRadius = 11
        imageResidentImageView.layer.masksToBounds = true
    }
}
