//
//  checkPhone.swift
//  WashSquad
//
//  Created by Eslam Moemen on 9/30/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
import EzPopup

class checkPhone: UIViewController {
    
    @IBOutlet var BtnTimer: UIButton!
    @IBOutlet var check: UIButton!
    @IBOutlet var checkTF: UITextField!
    @IBOutlet var codeView: UIView!
    
    var id:String?
    
    var timer:Timer?
    var code:String?
    var number:String?
    var timeLeft = 60
    //
    var Phone:String?
    var Pcode:String?
    var codeD:String?
    
    var result:JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        check.layer.cornerRadius = 15.0
        check.clipsToBounds = true
        //
        BtnTimer.layer.cornerRadius = 15.0
        BtnTimer.clipsToBounds = true
        //
        codeView.layer.borderWidth = 0.5
        codeView.layer.cornerRadius = 10.0
        codeView.clipsToBounds = true
        codeView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        if def.dictionary(forKey: "PassRecCode") != nil {
            Phone = def.dictionary(forKey: "PassRecCode")!["phone"] as? String
            Pcode = def.dictionary(forKey: "PassRecCode")!["code"] as? String
            codeD = def.dictionary(forKey: "PassRecCode")!["Fcode"] as? String
        }else {
            if api.isConnectedToInternet(){
                showSvProgressHUDwithStatus(nil)
                api.validateCode(URL: sendCodeUrl) { (error, result, code) in
                    if code == 200{
                        dismissSvProgressHUD()
                     self.code = JSON(result!)["confirmation_code"].stringValue
                        print("localeCode:",self.code!)
                        guard !(self.code?.isEmpty ?? true) else { return }
                        //showSuccessWithStatus(self.code!.description)
                        showSuccessWithStatus(Localized("codeHasBeenSend"))
                        
                    }else {
                    dismissSvProgressHUD()
                        showErrorWithStatus(Localized("errll"))
                     
                    }
                }
                
            }else{
                dismissSvProgressHUD()
                showErrorWithStatus(Localized("connMSG"))
                }
        }
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func onTimerFires(){
        timeLeft -= 1
        BtnTimer.setTitle("0:\(timeLeft)", for: .normal)
        BtnTimer.isUserInteractionEnabled = false
        if timeLeft <= 0 {
            timer!.invalidate()
            timer = nil
            BtnTimer.isUserInteractionEnabled = true
            BtnTimer.setTitle(Localized("resend"), for: .normal)
        }
    }
    
    @IBAction func resendTapped(_ sender: Any) {
        if codeD != nil {
            showSvProgressHUDwithStatus(nil)
            api.forgetPassword(code:Pcode!, phone: Phone!) { (error, result, code) in
                if code == 200{
                 dismissSvProgressHUD()
                 self.timeLeft = 60
                 self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimerFires), userInfo: nil, repeats: true)
                    self.codeD = JSON(result!)["password_token"].stringValue
                    print(self.codeD as Any)
                }else {
                 dismissSvProgressHUD()
                 showErrorWithStatus(Localized("errll"))
                }
            }
            
        }else {
            if api.isConnectedToInternet(){
                showSvProgressHUDwithStatus(nil)
                api.validateCode(URL: sendCodeUrl) { (error, result, code) in
                    if code == 200{
                     dismissSvProgressHUD()
                     self.timeLeft = 60
                     self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimerFires), userInfo: nil, repeats: true)
                     self.code = JSON(result!)["confirmation_code"].stringValue
                                           }else {
                     dismissSvProgressHUD()
                     showErrorWithStatus(Localized("errll"))
                    }
                }
                
            }else{
             dismissSvProgressHUD()
                showErrorWithStatus(Localized("connMSG"))
                }
        }
        
    }
    
    @IBAction func canceltapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func checktapped(_ sender: Any) {
        if codeD != nil {
            if codeD == checkTF.text?.replacedArabicDigitsWithEnglish {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "passFORG") as! passRest
            let popupVC = PopupViewController(contentController: popOverVC, popupWidth: UIScreen.main.bounds.width-20, popupHeight: 250)
            popupVC.backgroundAlpha = 0.3
            popupVC.backgroundColor = .black
            popupVC.canTapOutsideToDismiss = true
            popupVC.cornerRadius = 10
            popupVC.shadowEnabled = true
            present(popupVC, animated: true)

        }else{
            dismissSvProgressHUD()
            showErrorWithStatus(Localized("errcode"))
            }
        }else {
            if code! == checkTF.text?.replacedArabicDigitsWithEnglish {
               showSvProgressHUDwithStatus(nil)
               api.confirmCode(URL:confirmcode ,code:code!) { (error, result, code) in
                   if code == 200{
                       dismissSvProgressHUD()
                       def.set(["name":JSON(result!)["full_name"].stringValue,"phone": JSON(result!)["phone"].stringValue,"logo":UIImage(named: "user-1")!.jpegData(compressionQuality: 1.0)!], forKey:"userData")
                      // def.set(JSON(result!)["phone_code"].stringValue, forKey: "phone_code")
                       def.set(self.Pcode ?? "00966", forKey: "phone_code")

                       def.set(JSON(result!)["id"].stringValue, forKey: "tempID")
                       self.id = def.string(forKey: "tempID")!
                       def.set(JSON(result!)["id"].stringValue, forKey: "user_id")
                       support.saveUserId(token:self.id!)
                       support.restartApp()

                   support.showSuccess(title:Localized("su"))
                   
                   }else {
                       dismissSvProgressHUD()
                       showErrorWithStatus(Localized("errll"))

                   }
               }
           }else{
               dismissSvProgressHUD()
               showErrorWithStatus(Localized("errcode"))
               }
    

           }
        }
        
}
