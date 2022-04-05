//
//  SubscriptionVC.swift
//  WashSquad
//
//  Created by Motaweron on 30/03/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubscriptionVC: UIViewController {
    
    @IBOutlet private weak var headTitle: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var labelsCollection: [UILabel]!
    
    @IBOutlet weak var washNumLab: UILabel!
    @IBOutlet weak var washDateLab: UILabel!
    @IBOutlet weak var daayLab: UILabel!
    @IBOutlet weak var washStatusLab: UILabel!
    @IBOutlet private weak var requestPostonementBtn: UIButton!
    
    
    var jsonData = [JSON]()
    var currentJson:JSON?
    var delay_order_sub_limit:Int = 0
    var time_dealy:Int = 0
    lazy var isSubscribeEnaable:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          self.getAppSetting()
          self.tableViewConfigs()
          self.getUserSubscription()
          self.localizeUI()
          self.checkIsOverLimit()

    }
    
    
    @IBAction func updateBtn(_ sender: Any) {
      if self.isSubscribeEnaable == true {
             self.updateSubscriptionsAPI()
    }}
    
    

}
//MARK: -  UI
extension SubscriptionVC {
    
    private func localizeUI() {
        self.requestPostonementBtn.setTitle(Localized("Subscribe"), for: .normal)
        for label in labelsCollection {
            switch label.tag {
                case 1 : label.text = Localized("Wash NO")
                case 2 : label.text = Localized("Date")
                case 3 : label.text = Localized("Day")
                case 4 : label.text = Localized("Status")
                case 5 : label.text = Localized("Subscriptions")
                case 6 : label.text = Localized("Wash details")
            default : break
            }
        }
    }
    
    
}
//MARK: - Networking
extension SubscriptionVC {
    
    private func getUserSubscription() {
        if support.checkUserId == true {
            print("🚀 userSubscriptionURL = \(userSubscriptionURL)")
            showSvProgressHUDwithStatus(nil)
            api.userSubscription(URL: userSubscriptionURL) { error, result, code in
                dismissSvProgressHUD()
                if code == 200 {
                    self.jsonData = JSON(result!)["wash_sub"].arrayValue
                    if self.jsonData.isEmpty == true {
                        self.requestPostonementBtn.setTitle(Localized("Subscribe"), for: .normal)

                    }else{
                        print("✅ 🚀 userSubscriptionURL = \(self.jsonData)")
                        self.requestPostonementBtn.setTitle(Localized("requestPostonement"), for: .normal)
                        self.tableView.reload()
                        for i in self.jsonData {
                            if i["status"].stringValue == "new" || i["status"].stringValue == "wait" {
                                self.currentJson = i
                                self.displayCurrentInfo()
                                break
                    }}
                    }
        }}}else{
    }}
    
    
    private func displayCurrentInfo() {
        self.washNumLab.text = self.currentJson?["number_of_wash"].stringValue
        let day =  self.currentJson?["day"].stringValue
        self.daayLab.text = self.checkDate(day: day ?? "")
        
        if  self.currentJson?["status"].stringValue == "new" {
          self.washStatusLab.text = Localized("new")
            self.washDateLab.text = self.currentJson?["wash_date"].stringValue
        } else  if self.currentJson?["status"].stringValue == "wait" {
            self.washStatusLab.text = Localized("Wait")
            self.washDateLab.text = self.currentJson?["will_wash_date"].stringValue
        }else {
            self.washDateLab.text = self.currentJson?["wash_date"].stringValue
        }
        
        self.time_dealy = self.currentJson?["time_dealy"].intValue ?? 0
        self.checkIsOverLimit()

//        }else if self.jsonData[indexPath.row]["status"].stringValue == "done" {
//            self.washStatusLab.text = Localized("done")
//            self.washDateLab.text = self.jsonData[indexPath.row]["wash_date"].stringValue
//        }else if self.jsonData[indexPath.row]["status"].stringValue == "wait" {
//            self.washStatusLab.text = Localized("wait")
//            self.washDateLab.text = self.jsonData[indexPath.row]["will_wash_date"].stringValue
//        }
    }
    
    
    private func updateSubscriptionsAPI() {
        showSvProgressHUDwithStatus(nil)
        api.updateSubscription(subscription_id: "\(self.currentJson?["id"].intValue ?? 0)", logo: UIImage()) { error, result, code in
            dismissSvProgressHUD()
            if code == 200 {
                self.daayLab.text = nil
                self.washDateLab.text = nil
                self.washNumLab.text = nil
                self.getUserSubscription()
    }}}
    
    private func checkIsOverLimit() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("⛳️  time_dealy \(self.time_dealy) , delay_order_sub_limit \(self.delay_order_sub_limit)")
            if self.time_dealy < self.delay_order_sub_limit {
                // true
                // init request
                self.isSubscribeEnaable = true
                self.requestPostonementBtn.isUserInteractionEnabled = true
                self.requestPostonementBtn.backgroundColor = UIColor(named: "Main")
            }else{
                self.isSubscribeEnaable = false
                self.requestPostonementBtn.backgroundColor = .gray
                self.requestPostonementBtn.isUserInteractionEnabled = false
    }}}
    
    private func getAppSetting() {
      api.getSetting { error, result, code in
            if code == 200 {
                self.delay_order_sub_limit = JSON(result!)["delay_order_sub_limit"].intValue
                self.checkIsOverLimit()
    }}}
    
    
}
//MARK: - TableView Configs
extension SubscriptionVC: UITableViewDelegate, UITableViewDataSource {
 
    private func tableViewConfigs() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(cell: SubscripeCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeue() as SubscripeCell
        
        cell.washNumLab.text = self.jsonData[indexPath.row]["number_of_wash"].stringValue
        let day = self.jsonData[indexPath.row]["day"].stringValue
        cell.daayLab.text = self.checkDate(day: day)
        if self.jsonData[indexPath.row]["status"].stringValue == "new" {
            cell.washStatusLab.text = Localized("new")
            cell.washDateLab.text = self.jsonData[indexPath.row]["wash_date"].stringValue
        }else if self.jsonData[indexPath.row]["status"].stringValue == "done" {
            cell.washStatusLab.text = Localized("done")
            cell.washDateLab.text = self.jsonData[indexPath.row]["wash_date"].stringValue
        }else if self.jsonData[indexPath.row]["status"].stringValue == "wait" {
            cell.washStatusLab.text = Localized("wait")
            cell.washDateLab.text = self.jsonData[indexPath.row]["will_wash_date"].stringValue
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
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
    
    
    
}
