//
//  ChnageLanguageVC.swift
//  WashSquad
//
//  Created by Motaweron on 31/03/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit
import MOLH


class ChnageLanguageVC: UIViewController {
    
    
    @IBOutlet private weak var headTitle: UILabel!{
        didSet{
            self.headTitle.text = Localized("Language")
    }}
    @IBOutlet private weak var arView: UIView!{
        didSet{
            self.arView.addActionn(vc: self, action:  #selector(self.changeLaanguaage(_:)))
    }}
    @IBOutlet private weak var enView: UIView!{
        didSet{
            self.enView.addActionn(vc: self, action: #selector(self.changeLaanguaage(_:)))
    }}
    
    
    @IBOutlet weak var arImg: UIImageView!
    @IBOutlet weak var enImg: UIImageView!

    
    
    var lng:String?
    var langscode = ["en","ar"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.swipDownActionn(vc: self, action: #selector(self.dismisAction))
        
        if UserDefaults.standard.string(forKey: "AppleLanguages") == "ar" {
            self.arImg.isHidden = false
            self.enImg.isHidden = true
        }else{
            self.arImg.isHidden = true
            self.enImg.isHidden = false
        }
    }
    

   
}
//MARK: - Selectors
extension ChnageLanguageVC {
    
    @objc private func changeLaanguaage(_ sender: AnyObject) {
        if sender.view?.tag == 1 {
            self.lng = "ar"
            MOLH.setLanguageTo("ar")
        }else if sender.view?.tag == 2 {
            self.lng = "en"
            MOLH.setLanguageTo("en")
        }
        if Locale.preferredLanguages[0] != self.lng! {
            def.set(self.lng!, forKey: "#CL")
            if self.lng == "en" {UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()}else{UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()}
          // exit(0)
           // support.restartApp()
        }
        MOLH.reset(transition: .transitionCrossDissolve, duration: 0.6)

    }
    
    @objc private func dismisAction() {
        if let _ = navigationController {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
