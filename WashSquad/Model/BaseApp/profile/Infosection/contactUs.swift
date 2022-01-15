//
//  contactUs.swift
//  WashSquad
//
//  Created by Eslam Moemen on 11/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class contactUs: UIViewController {

    @IBOutlet var MessageTF: UITextView!
    @IBOutlet var subjectTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var acc: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func sendTapped(_ sender: Any) {
        guard let name = nameTF.text ,!name.isEmpty,let sub = subjectTF.text ,!sub.isEmpty,let email = emailTF.text ,!email.isEmpty,let message = MessageTF.text ,!message.isEmpty else {
            showErrorWithStatus(Localized("allof"))
            return
        }
        if !api.isConnectedToInternet() {
           showErrorWithStatus(Localized("connMSG"))
           return
        }else{
            acc.startAnimating()
            api.contactUs(name: name, email: email, subject: sub, message: message) { (error, result, code) in
                if code == 200{
                    self.acc.stopAnimating()
                    showSuccessWithStatus(Localized("su"))
                    self.navigationController?.popToRootViewController(animated: true)
                }else {
                    self.acc.stopAnimating()
                    showErrorWithStatus(Localized("errll"))
                }
            }
        }
    }
    

}
