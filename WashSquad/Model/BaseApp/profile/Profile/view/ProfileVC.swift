//
//  ProfileVC.swift
//  WashSquad
//
//  Created by Motaweron on 10/03/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
import StoreKit

class ProfileVC: UIViewController {
    @IBOutlet weak var headTitle: UIBarButtonItem!{
        didSet{
            self.headTitle.title = Localized("Profile")
        }
    }
    @IBOutlet private weak var userNameLab: UILabel!
    @IBOutlet private weak var phoneLab: UILabel!
    @IBOutlet private var labelsCollection: [UILabel]!
    @IBOutlet private weak var userPhoto: UIImageView!
    @IBOutlet private var buttonsCollection: [UIButton]!
    @IBOutlet private var viewsCollection: [UIView]!
    
    @IBOutlet weak var noSubscripeMessaageLab: UILabel!{
        didSet{
            self.noSubscripeMessaageLab.text = Localized("No subscriptions")
        }
    }
    
    @IBOutlet private weak var subscripeBtn: UIButton!{
        didSet{
            self.subscripeBtn.setTitle(Localized("details"), for: .normal)
    }}
    @IBOutlet private weak var requestPostonementBtn: UIButton!{
        didSet{
            self.requestPostonementBtn.setTitle(Localized("requestPostonement"), for: .normal)
    }}
    
    @IBOutlet weak var washLeftLab: UILabel!
    @IBOutlet weak var washDateLab: UILabel!
    @IBOutlet weak var daayLab: UILabel!
    
    
    var jsonData = [JSON]()
    var currentJson:JSON?
    var filterArrayWithoutDone = [JSON]()

    var whatsapp = ""
    var twitter = ""
    var instagram = ""
    var snapchat = ""
  
    var delay_order_sub_limit:Int = 0
    var time_dealy:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.subscripeBtn.isHidden = false
//        self.requestPostonementBtn.isHidden = true
        self.getSettingAPI()
        self.setViewActions()
        self.getUserSubscription()
        self.changeSubscripeApperance()
        self.localaizeUI()
        
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
        
        self.displaayUserData()
    }
    
    
    @IBAction func btnsAction(_ sender: UIButton) {
        switch sender.tag {
           case 1 : SocialHelper.shared.openInstagram(instgram: self.instagram)
           case 2 : SocialHelper.shared.openTwitter(twitter: self.twitter)
           case 3 : SocialHelper.shared.openTwitter(twitter: self.snapchat)
        default : break
        }
    }
    
    @IBAction func settingBtn(_ sender: Any) {
        performSegue(withIdentifier: "toSetting", sender: self)
    }
    
    @IBAction private func subscribeActions(_ sender: UIButton) {
        if sender.tag == 1 {
            performSegue(withIdentifier: "toSubscrptions", sender: self)
        }else if sender.tag == 2 {
            self.updateSubscriptionsAPI()
        }
    }
    
    
    
}
//MARK: - UI
extension ProfileVC {
    
    
    private func displaayUserData() {
        if let imgDataa = def.dictionary(forKey: "userData")!["logo"] as? Data {
            userPhoto.image = UIImage(data:(imgDataa))
        }
        userNameLab.text = def.dictionary(forKey: "userData")!["name"] as? String
       let phone_code = def.string(forKey: "phone_code") ?? ""
       let phone = def.dictionary(forKey: "userData")!["phone"] as? String ?? ""
       self.phoneLab.text = "\(phone_code)\(phone)"
       
    }
    
    
    private func setViewActions() {
        for i in viewsCollection {
            i.addActionn(vc: self, action: #selector(self.performViewsActions(_:)))
        }
    }
    @objc private func performViewsActions(_ sender:AnyObject) {
         switch sender.view.tag {
              case 1 : performSegue(withIdentifier: "toWallet", sender: self)
              case 2 : performSegue(withIdentifier: "toSubscrptions", sender: self)
              case 3 : self.rateApp()
              case 4 : performSegue(withIdentifier: "toContactUs", sender: self)
              case 5 : performSegue(withIdentifier: "toProfile", sender: self)
            default : break
    }}
    
    
    private func changeSubscripeApperance() {
     // for label in labelsCollection {
          if jsonData.isEmpty == true {
            //label.isHidden = true
            self.noSubscripeMessaageLab.isHidden = false
            self.requestPostonementBtn.isHidden = true
        }else {
           // label.isHidden = false
            self.noSubscripeMessaageLab.isHidden = true
            self.requestPostonementBtn.isHidden = false
    }}//}
    
    private func localaizeUI() {
        for label in labelsCollection {
            switch label.tag {
                case 1 : label.text = Localized("Start day")
                case 2 : label.text = Localized("Day")
                case 3 : label.text = Localized("Left")
                case 4 : label.text = Localized("My Wallet")
                case 5 : label.text = Localized("Subscriptions")
                case 6 : label.text = Localized("The App")
                case 7 : label.text = Localized("Help and support")
                case 8 : label.text = Localized("Share and connact with us")
                case 9 : label.text = Localized("Update")

            default : break
            }
        }
    }
    
    
}
//MARK: - Networking
extension ProfileVC {
    
    private func getUserSubscription() {
        if support.checkUserId == true {
            print("🚀 userSubscriptionURL = \(userSubscriptionURL)")
            api.userSubscription(URL: userSubscriptionURL) { error, result, code in
                if code == 200 {
                    self.jsonData = JSON(result!)["wash_sub"].arrayValue
                    print("✅ 🚀 userSubscriptionURL = \(self.jsonData)")
                    if self.jsonData.isEmpty == true {
                        print("✅ yes its not empty")
                        self.subscripeBtn.isHidden = false
                        self.requestPostonementBtn.isHidden = true
                    }else{
                        print("❌ yes its empty")
                        self.subscripeBtn.isHidden = false
                        self.requestPostonementBtn.isHidden = false
                        for i in self.jsonData {
                            if i["status"].stringValue == "new" {
                                self.currentJson = i
                                self.displayCurrentInfo()
                                break
         }}}}}}else{
    }}
    
    private func updateSubscriptionsAPI() {
        showSvProgressHUDwithStatus(nil)
        api.updateSubscription(subscription_id: "\(self.currentJson?["id"].intValue ?? 0)", logo: UIImage()) { error, result, code in
            dismissSvProgressHUD()
            if code == 200 {
                self.getUserSubscription()
            }else if code == 422 {
              print("🚀 updateSubscription response \(result) ")
//                if let data =  {
//                    print("🔴 \( JSON(data))")
//                }
                
    }}}
    
    private func displayCurrentInfo() {
        //self.washLeftLab.text =  //self.jsonData.count
        //self.currentJson?["number_of_wash"].stringValue
        let day =  self.currentJson?["day"].stringValue
        self.daayLab.text = self.checkDate(day: day ?? "")
       // if  self.currentJson["status"].stringValue == "new" {
       // self.washStatusLab.text = Localized("new")
        self.washDateLab.text = self.currentJson?["wash_date"].stringValue
        self.time_dealy = self.currentJson?["time_dealy"].intValue ?? 0
        if jsonData.isEmpty == false {
            for i in jsonData {
                self.filterArrayWithoutDone.removeAll()
                if i["status"].stringValue != "done" {
                    self.filterArrayWithoutDone.append(i)
                }
            }
        }else{
            
        }
      
        self.washLeftLab.text = "\(self.jsonData.count - self.filterArrayWithoutDone.count)"
    }
    
    func checkDate(day:String) -> String{
        var date = ""
        if day == "Saturday" {
            date = Localized("Saturday")
        }else if day == "Sunday" {
            date = Localized("Sunday")
        }else if day == "Monday" {
            date = Localized("Monday")
        }else if day == "Tuesday" {
            date = Localized("Tuesday")
        }else if day == "Wednesday" {
            date = Localized("Wednesday")
        }else if day == "Thursday" {
            date = Localized("Thursday")
        }else if day == "Friday" {
            date = Localized("Friday")
        }
        return date
    }
    
    private func getSettingAPI() {
        if !api.isConnectedToInternet() {
               showErrorWithStatus(Localized("connMSG"))
               return
            }else {
                api.getSocial { (error, result, code) in
                    if code == 200 {
                        self.twitter = JSON(result!)["twitter"].stringValue
                        self.instagram = JSON(result!)["instagram"].stringValue
                        self.whatsapp = JSON(result!)["whatsapp"].stringValue
                        self.snapchat =  JSON(result!)["snapchat"].stringValue
                    }else {
                        showErrorWithStatus(Localized("errll"))
    }}}}
    
    private func getAppSetting() {
      api.getSetting { error, result, code in
            if code == 200 {
                self.delay_order_sub_limit = JSON(result!)["delay_order_sub_limit"].intValue
                self.checkIsOverLimit()
    }}}
    
    private func checkIsOverLimit() {
        if self.time_dealy < self.delay_order_sub_limit {
            // true
            
        }else{
            
        }
    }
    
    
    
}
//MARK: Rate app
extension ProfileVC {
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "washsquad-ووش-سكواد/id1489576684") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
