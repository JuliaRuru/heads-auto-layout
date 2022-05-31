//
//  LocationTableViewCell.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var populationPlanetLabel: UILabel!
    @IBOutlet weak var typePlanetLabel: UILabel!
    @IBOutlet weak var namePlanetLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
