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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewsAction()
        
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
    
    
}
//MARK: - Selectors
extension SettingVC {
    @objc private func viewsAction(_ sender: AnyObject) {
        switch sender.view.tag {
           case 1 : print("language")
           case 2 : print("terms")
           case 3 : print("logout")
        default : break
    }}
    
    
}
