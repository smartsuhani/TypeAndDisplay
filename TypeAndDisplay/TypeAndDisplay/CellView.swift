//
//  CellView.swift
//  TypeAndDisplay
//
//  Created by Devloper30 on 30/01/17.
//  Copyright © 2017 lanetteamLanet. All rights reserved.
//

import UIKit

class CellView: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
