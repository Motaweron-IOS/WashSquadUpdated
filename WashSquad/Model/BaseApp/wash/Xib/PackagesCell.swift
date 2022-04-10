//
//  PackagesCell.swift
//  WashSquad
//
//  Created by Motaweron on 04/04/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
import MOLH
import Kingfisher

class PackagesCell: UICollectionViewCell {
    
    @IBOutlet private weak var packageImage: UIImageView!
    @IBOutlet private weak var priceVaalue: UILabel!
    @IBOutlet private weak var currencyLaab: UILabel!{
        didSet{
            self.currencyLaab.text = Localized("SAR")
    }}
    @IBOutlet private weak var packageName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model:JSON?{
        didSet{
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                self.packageName.text = model?["ar_title"].stringValue
            }else {
                self.packageName.text = model?["en_title"].stringValue
            }
            self.priceVaalue.text = model?["price"].doubleValue.description
            let packImaage = model?["image"].stringValue ?? "."
            print("✅ packimage == \(imageURL + packImaage)")
            self.packageImage.kf.setImage(with: ImageResource(downloadURL: URL(string:imageURL + packImaage)!))

        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .systemGray3 : .white
        }
    }

    
    
    

}
