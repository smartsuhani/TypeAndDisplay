//
//  DTHCellTableViewCell.swift
//  TypeAndDisplay
//
//  Created by Devloper30 on 17/03/17.
//  Copyright © 2017 lanetteamLanet. All rights reserved.
//

import UIKit

class DTHCellTableViewCell: UITableViewCell {

    @IBOutlet var Lblslidernumber: UILabel!
    @IBOutlet var Lbltitle: UILabel!
    @IBOutlet var sliderRange: UISlider!
    
    var indexPath: IndexPath!
    var vc:DynamicTableHeaderVC!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sliderRange.minimumValue = 0
        sliderRange.maximumValue = 10
        sliderRange.value = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func changeInSlider(_ sender: Any) {
        Lblslidernumber.text = String(describing: sliderRange.value)
        vc.sections[indexPath.section][indexPath.row] = sliderRange.value
        vc.tblSliders.reloadData()
    }
    
}
