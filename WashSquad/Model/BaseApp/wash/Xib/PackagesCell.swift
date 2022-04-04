//
//  PackagesCell.swift
//  WashSquad
//
//  Created by Motaweron on 04/04/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit

class PackagesCell: UICollectionViewCell {
    
    @IBOutlet private weak var priceVaalue: UILabel!
    @IBOutlet private weak var currencyLaab: UILabel!{
        didSet{
            self.currencyLaab.text = Localized("SAR")
    }}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
