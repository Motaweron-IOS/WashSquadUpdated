//
//  MyWalletVC.swift
//  WashSquad
//
//  Created by mahmoud hajar on 11/03/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON


class MyWalletVC: UIViewController {

    @IBOutlet private weak var cashValueLab: UILabel!
    @IBOutlet private weak var cashBackLab: UILabel!{
        didSet{
            self.cashBackLab.text = Localized("Cash back")
        }
    }
    @IBOutlet private weak var currency: UILabel!{
        didSet{
            self.currency.text = Localized("SAR")
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           self.profileAPI()

    }
    
    
    @IBAction private func btnsAction(_ sender: UIButton) {
        
    }

    

}
//MARK: - Networking
extension MyWalletVC {
    
    private func profileAPI() {
        showSvProgressHUDwithStatus(nil)
    api.getProfile() { (error, result, code) in
        dismissSvProgressHUD()
           if code == 200 {
               self.cashValueLab.text = JSON(result!)["wallet"].doubleValue.description
   }}}
    
    
    
    
}
