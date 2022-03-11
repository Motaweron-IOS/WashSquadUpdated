//
//  ProfileVC.swift
//  WashSquad
//
//  Created by Motaweron on 10/03/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet private var labelsCollection: [UILabel]!
    @IBOutlet private weak var userPhoto: UIImageView!
    @IBOutlet private var buttonsCollection: [UIButton]!
    @IBOutlet private var viewsCollection: [UIView]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setActions()
        
    }
    
    @IBAction func btnsAction(_ sender: UIButton) {
        switch sender.tag {
           case 1 : print("insta")
           case 2 : print("twitter")
           case 3 : print("snap")
        default : break
        }
    }
    
    
   

}
//MARK: - UI
extension ProfileVC {
    
    private func setActions() {
        for i in viewsCollection {
            switch i.tag {
              case 1 : print("wallet")
              case 2 : print("subscripe")
              case 3 : print("the app")
              case 4 : print("help")
            default : break
    }}}
    
    
    
}
