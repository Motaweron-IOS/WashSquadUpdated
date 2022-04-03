//
//  ViewController.swift
//  WashSquad
//
//  Created by Eslam Moemen on 9/30/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import SwiftyJSON
import Kingfisher
import EzPopup

class login: UIViewController,FPNTextFieldDelegate {

    @IBOutlet var acc: UIActivityIndicatorView!
    @IBOutlet var userView: UIView!
    @IBOutlet var phoneView: UIView!
    @IBOutlet var codeView: UIView!
    @IBOutlet var phoneTF: FPNTextField!{
        didSet{
            self.phoneTF.delegate = self
        }
    }
    @IBOutlet var codeTF: UITextField!
    @IBOutlet var register: UIButton!
   // @IBOutlet var regbutton: UIButton!
    @IBOutlet var forgetPass: UIButton!
    @IBOutlet var userName: UITextField!
    
    var Phone:String?
    var Pcode:String?
    var error:Bool?
    lazy var isRegister:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acc.hidesWhenStopped = true
        
        setupPhoneTF()
        phoneView.layer.borderWidth = 0.5
        phoneView.layer.cornerRadius = 10.0
        phoneView.clipsToBounds = true
        phoneView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        codeView.layer.borderWidth = 0.5
        codeView.layer.cornerRadius = 10.0
        codeView.clipsToBounds = true
        codeView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        userView.layer.borderWidth = 0.5
        userView.layer.cornerRadius = 10.0
        userView.clipsToBounds = true
        userView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        register.layer.cornerRadius = 10.0
        register.clipsToBounds = true
        
        self.checkIsRegister()
        
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        present(storyboard!.instantiateViewController(withIdentifier: "main"), animated: true, completion: nil)
    }
    
    @IBAction func forgetPassTapped(_ sender: Any) {

        if codeView.isHidden == true {
            register.setTitle(Localized("login"), for: .normal)
            codeView.isHidden = false
           // regbutton.isHidden = false
            forgetPass.setTitle(Localized("FRGPASS"), for: .normal)
         //   regbutton.setTitle(Localized("cret"), for: .normal)
        }else {
            userView.isHidden = true
            register.setTitle(Localized("VSND"), for: .normal)
            codeView.isHidden = true
        //    regbutton.isHidden = true
            forgetPass.setTitle(Localized("ret"), for: .normal)
        }
        
        
    }
    @IBAction func registerBTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        if regbutton.titleLabel?.text == NSLocalizedString("cret", comment: ""){
//            userView.isHidden = false
//            regbutton.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
//            register.setTitle(NSLocalizedString("cret", comment: ""), for: .normal)
//            self.isRegister = true
//        }else{
//            self.isRegister = false
//            userView.isHidden = true
//            regbutton.setTitle(NSLocalizedString("cret", comment: ""), for: .normal)
//            register.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
//        }
    }
    
    
    @IBAction func registerTapped(_ sender: Any) {
        acc.startAnimating()
        if codeView.isHidden == true {
            if error == true {
             acc.stopAnimating()
             showErrorWithStatus(Localized("mobErr"))
                return
            }
            guard let pho = Phone, !pho.isEmpty else {
                acc.stopAnimating()
                showErrorWithStatus(Localized("allof"))
                return
            }
            api.forgetPassword(code: Pcode ?? "00966", phone: pho) { (error, result, code) in
                if code == 200 {
                    self.acc.stopAnimating()
                    def.set(["code":self.Pcode ?? "00966","phone":pho,"Fcode":JSON(result!)["password_token"].stringValue,"tempId":JSON(result!)["id"].stringValue], forKey: "PassRecCode")
                    
                    print(JSON(result!)["password_token"].stringValue)
                    self.present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "check"), animated: true, completion: nil)
                }else if code == 422 {
                    self.acc.stopAnimating()
                    showErrorWithStatus(Localized("err404"))
                }else {
                    self.acc.stopAnimating()
                    showErrorWithStatus(Localized("errll"))

                    
                }
            }
        }else{
            if !api.isConnectedToInternet() {
                acc.stopAnimating()
                       showErrorWithStatus(Localized("connMSG"))
                       return
                   }
                   if error == true {
                    acc.stopAnimating()
                    showErrorWithStatus(Localized("mobErr"))
                       return
                   }
            guard let pho = Phone, !pho.isEmpty ,
                let pass = codeTF.text , !pass.isEmpty else {
                    acc.stopAnimating()
                           showErrorWithStatus(Localized("allof"))
                           return
                   }
            if userView.isHidden == false {
            guard let user = userName.text , !user.isEmpty else {
                acc.stopAnimating()
                showErrorWithStatus(Localized("allof"))
                return
                  }
                acc.startAnimating()
                print("🚀 im here")
                api.register(URL: registerUrl, username: user, phone: pho.trimmingCharacters(in: .whitespacesAndNewlines), PhoneCode: Pcode ?? "00966", Pass: pass.replacedArabicDigitsWithEnglish) { (error, result, code) in
                    print("🚀 im here register")
                    switch code {
                    case 200:
                        self.acc.stopAnimating()
                        deleteAllData(entity: "CartModel")
                        showSuccessWithStatus(Localized("su"))
                        //support.saveUserId(token: JSON(result!)["id"].stringValue)
                        def.set(["name":JSON(result!)["full_name"].stringValue,"phone": JSON(result!)["phone"].stringValue,"logo":UIImage(named: "user-1")!.jpegData(compressionQuality: 1.0)!], forKey:"userData")
                      //  def.set(JSON(result!)["phone_code"].stringValue, forKey: "phone_code")
                        def.set(self.Pcode ?? "00966", forKey: "phone_code")

                        def.set(JSON(result!)["id"].stringValue, forKey: "tempID")
                        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "check") as! checkPhone
                        sb.result = JSON(result!)
                        self.present(sb, animated: true, completion: nil)
                    case 406:
                        self.acc.stopAnimating()
                        showErrorWithStatus(Localized("fbe"))
                    default:
                        self.acc.stopAnimating()
                        showErrorWithStatus(Localized("errll"))
                        
                    }
                }
            }else {
                acc.startAnimating()
                print("🚀 im here")
                api.login(URL: loginUrl, phone: pho.trimmingCharacters(in: .whitespacesAndNewlines), PhoneCode:  Pcode ?? "00966", Pass: pass.replacedArabicDigitsWithEnglish) { (error, result, code) in
                    print("🚀🚀 im here two")
                    switch code {
                    case 200:
                        print("🚀🚀🚀 im here three")
                        support.saveUserId(token:JSON(result!)["id"].stringValue)
                        deleteAllData(entity: "CartModel")
                        def.set(["name":JSON(result!)["full_name"].stringValue,"phone":JSON(result!)["phone"].stringValue], forKey:"userData")
                        def.set(self.Pcode ?? "00966", forKey: "phone_code")
                        
                        support.restartApp()

                        //support.saveUserType(type:JSON(result!)["user_type"].stringValue )
                        KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: URL(string: imageURL + JSON(result!)["logo"].stringValue)!), options: nil, progressBlock: nil, downloadTaskUpdated: nil) { (resultf) in
                            print("🚀🚀🚀🚀 im here two")
                            switch resultf {
                            case .success(let value):
                                print("Got Here!")
                              //  deleteAllData(entity: "CartModel")
//                                def.set(["name":JSON(result!)["full_name"].stringValue,"phone":"0" + JSON(result!)["phone"].stringValue,"logo":value.image.jpegData(compressionQuality: 1.0)!], forKey:"userData")
                                    //self.acc.stopAnimating()
                              //  support.restartApp()
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        
                        
                    case 404:
                        self.acc.stopAnimating()
                        showErrorWithStatus(Localized("inv"))
                    case 405:
                        self.acc.stopAnimating()
                        def.set(JSON(result!)["id"].stringValue, forKey: "tempID")
                        let sb = self.storyboard!.instantiateViewController(withIdentifier:"check")
                        self.present(sb, animated: true, completion: nil)
                    case 406:
                        self.acc.stopAnimating()
                        showErrorWithStatus(Localized("sus"))
                    default:
                        self.acc.stopAnimating()
                        showErrorWithStatus(Localized("errll"))

                    }
                }
        }}}
    
    
    func setupPhoneTF(){
        
        phoneTF.delegate = self
        phoneTF.placeholder = ""
        phoneTF.leftView?.translatesAutoresizingMaskIntoConstraints = false
        phoneTF.leftView?.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        phoneTF.leftView?.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        phoneTF.setFlag(for: FPNCountryCode.SA)
        phoneTF.flagButton.isUserInteractionEnabled = true
        //phoneTF.flagButtonSize = CGSize(width: 35, height: 35)
        phoneTF.parentViewController = self
        
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        Pcode =  dialCode.replacingOccurrences(of: "+", with: "00")
        def.set(Pcode, forKey: "Unum")

        
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            Phone = textField.getRawPhoneNumber()
            error = false
        } else {
            error = true
            
        }
    }
    
    private func checkIsRegister() {
        if self.isRegister == true {
            userView.isHidden = false
           // regbutton.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
            register.setTitle(NSLocalizedString("cret", comment: ""), for: .normal)
        }else {
            userView.isHidden = true
         //   regbutton.setTitle(NSLocalizedString("cret", comment: ""), for: .normal)
            register.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
        }
    }
    
}

//extension login : UITextFieldDelegate {
//     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//         if textField == self.phoneTF {
//             return range.location == 10
//         }
//         return true
//    }
//}
