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
    
    @IBOutlet weak var noSubscripeMessaageLab: UILabel!
    
    @IBOutlet private weak var subscripeBtn: UIButton!{
        didSet{
            self.subscripeBtn.setTitle(Localized("subscripe"), for: .normal)
    }}
    @IBOutlet private weak var requestPostonementBtn: UIButton!{
        didSet{
            self.requestPostonementBtn.setTitle(Localized("requestPostonement"), for: .normal)
    }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewActions()
        self.getUserSubscription()
        self.changeSubscripeApperance()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
           // navigationController?.navigationBar.prefersLargeTitles = true

            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(named: "Main")
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
    private func setViewActions() {
        for i in viewsCollection {
            i.addActionn(vc: self, action: #selector(self.performViewsActions(_:)))
        }
    }
    @objc private func performViewsActions(_ sender:AnyObject) {
        for i in viewsCollection {
            switch i.tag {
              case 1 : performSegue(withIdentifier: "toWallet", sender: self)
              case 2 : print("subscripe")
              case 3 : print("the app")
              case 4 : print("help")
            default : break
    }}}
    
    
    private func changeSubscripeApperance() {
      for label in labelsCollection {
        if support.checkUserId == false {
            label.isHidden = true
            self.noSubscripeMessaageLab.isHidden = false
            self.requestPostonementBtn.isHidden = true
        }else {
            label.isHidden = false
            self.noSubscripeMessaageLab.isHidden = true
            self.requestPostonementBtn.isHidden = false
    }}}
    
    
    
}
//MARK: - Networking
extension ProfileVC {
    
    private func getUserSubscription() {
        if support.checkUserId == true {
            print("🚀 userSubscriptionURL = \(userSubscriptionURL)")
            api.userSubscription(URL: userSubscriptionURL) { error, result, code in
                if code == 200 {
                    
                }
            }
        }else{
        }
    }
    
    
}
