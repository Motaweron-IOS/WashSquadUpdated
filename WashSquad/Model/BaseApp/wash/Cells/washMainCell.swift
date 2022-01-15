//
//  washMainCell.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class washMainCell: UICollectionViewCell {
    
    @IBOutlet var theview: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        theview.layer.borderWidth = 0.5
        theview.layer.cornerRadius = 10.0
        theview.clipsToBounds = true
        theview.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        image.layer.cornerRadius = 5.0
        image.clipsToBounds = true
    }
    
}
