//
//  LocationTableViewCell.swift
//  hnh1
//
//  Created by Юлия Руднева on 31.05.2022.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var populationLocationLabel: UILabel!
    @IBOutlet weak var typeLocationLabel: UILabel!
    @IBOutlet weak var nameLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
