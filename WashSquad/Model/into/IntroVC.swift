//
//  IntroVC.swift
//  WashSquad
//
//  Created by Motaweron on 09/03/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit

class IntroVC: UIViewController {
    
    @IBOutlet private var btnsAction: [UIButton]!{
        didSet{
            for i in btnsAction {
                i.layer.cornerRadius = 10
                i.clipsToBounds = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        if support.checkUserId == true {
//            print("🚀 ✅ user id === \(support.getuserId)")
//        } else{
//            print("🚀 ❌ user id === not here")
//        }
    }
    

    @IBAction private func btnsAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! login
        if sender.tag == 1 {
            sb.isRegister = false
        }else if sender.tag == 2 {
            sb.isRegister = true
        }
        self.present(sb, animated: true, completion: nil)
    }
    
    
    
}
