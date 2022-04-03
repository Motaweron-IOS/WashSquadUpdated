//
//  SettingVC.swift
//  WashSquad
//
//  Created by mahmoud hajar on 11/03/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    @IBOutlet private var viewsCollection: [UIView]!
    @IBOutlet private weak var notificationSwitcher: UISwitch!
    @IBOutlet private var labelsCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewsAction()
        self.localizeUI()
    }
    
    @IBAction private func switcherAction(_ sender: UISwitch) {
        if sender.isOn == true {
            
        }else if sender.isOn == false {
            
    }}

    

}
//MARK: - UI
extension SettingVC {
    
    private func setViewsAction() {
        for view in viewsCollection {
            view.addActionn(vc: self, action: #selector(self.viewsAction(_:)))
    }}
    
    private func localizeUI() {
        for i in labelsCollection {
            switch i.tag{
               case 1: i.text = Localized("Language")
               case 2: i.text = Localized("Terms and conditions")
               case 3: i.text = Localized("Logout")
            default: break
    }}}
    
    
}
//MARK: - Selectors
extension SettingVC {
    @objc private func viewsAction(_ sender: AnyObject) {
        switch sender.view?.tag {
           case 1 : performSegue(withIdentifier: "toLanguage", sender: self)
           case 2 : performSegue(withIdentifier: "toTerms", sender: self)
           case 3 : performSegue(withIdentifier: "toLogout", sender: self)
        default : break
    }}
    
    
    
}
