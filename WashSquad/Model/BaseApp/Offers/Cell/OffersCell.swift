//
//  OffersCell.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/15/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class OffersCell: UITableViewCell {

    @IBOutlet var offerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        offerImage.layer.borderWidth = 0.5
        offerImage.layer.cornerRadius = 10.0
        offerImage.clipsToBounds = true
        offerImage.layer.borderColor = UIColor(rgb: 0x450638).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
