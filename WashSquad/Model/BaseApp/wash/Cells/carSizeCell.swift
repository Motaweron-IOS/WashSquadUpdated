//
//  carSizeCell.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class carSizeCell: UICollectionViewCell {
    @IBOutlet var biggerView: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var size: UILabel!
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        biggerView.layer.borderWidth = 0.5
        biggerView.layer.cornerRadius = 10.0
        biggerView.clipsToBounds = true
        biggerView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        
        
        
    }
    
}
