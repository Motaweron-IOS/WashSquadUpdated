//
//  passRest.swift
//  WashSquad
//
//  Created by Eslam Moemen on 11/26/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class passRest: UIViewController{

    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var send: UIButton!
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if def.dictionary(forKey: "PassRecCode") != nil {
            id = def.dictionary(forKey: "PassRecCode")!["tempId"] as! String
        }else{
            id = support.getuserId
        }
    }
    
    
    @IBAction func sendTapped(_ sender: Any) {
        guard let pass = phoneTF.text ,!pass.isEmpty else {
            showErrorWithStatus(Localized("errll"))
            return
        }
        showSvProgressHUDwithStatus(nil)
        api.changePasswordApi(id:id , newPass: pass) { (error, result, code) in
            if code == 200 {
                dismissSvProgressHUD()
                showSuccessWithStatus(Localized("psSUC"))
                if def.dictionary(forKey: "PassRecCode") != nil{
                    support.deleteAllData
                    def.removeObject(forKey:"PassRecCode")
                    self.present(self.storyboard!.instantiateViewController(withIdentifier: "loginVC"), animated: true, completion: nil)
                }else{
                    self.dismiss(animated: true, completion: nil)
                }
                
                
            }else {
               dismissSvProgressHUD()
                showSuccessWithStatus(Localized("errll"))
            }
        }
    }
    
    
    
    
}
