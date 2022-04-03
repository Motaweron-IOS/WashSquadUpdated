//
//  LogoutVC.swift
//  WashSquad
//
//  Created by Motaweron on 31/03/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit

class LogoutVC: UIViewController {

    @IBOutlet private weak var headTitle: UILabel!{
        didSet{
            self.headTitle.text = Localized("Logout")
    }}
    @IBOutlet private weak var yesBtn: UIButton!{
        didSet{
            self.yesBtn.setTitle(Localized("Yes"), for: .normal)
    }}
    @IBOutlet private weak var noBtn: UIButton!{
        didSet{
            self.noBtn.setTitle(Localized("No"), for: .normal)
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction private func btnsAction(_ sender: UIButton) {
        if sender.tag == 1 {
            self.logout()
        }else if sender.tag == 2 {
            self.dismiss(animated: true, completion: nil)
    }}
    
      
}
//MARK: - Networking
extension LogoutVC {
    private func logout() {
        if !api.isConnectedToInternet() {
            alert.alertPopUp(title:Localized("err"), msg: Localized("connMSG"), vc: self)
            return
            }
        if !support.checkUserId{
            alert.registerAlert(v: self)
            return
        }
        showSvProgressHUDwithStatus(nil)
        api.Logout(URL: logOutUrl, userId:support.getuserId){ (error, result, code) in
            switch code {
            case 200:
                dismissSvProgressHUD()
                support.deleteAllData
                deleteAllData(entity:"CartModel")
                support.deletUserDefaults()
            //self.present(self.storyboard!.instantiateViewController(withIdentifier: "loginVC"), animated: true, completion: nil)
             
            default:
                dismissSvProgressHUD()
                alert.alertPopUp(title: Localized("err"), msg: Localized("errll"), vc: self)
                
            }
        }
    }
}
