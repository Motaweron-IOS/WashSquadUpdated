//
//  FinalOrderView.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/23/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class FinalOrderView: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet var mytableview: UITableView!
    @IBOutlet var addtionalLabel: UILabel!
    @IBOutlet var excmal: UIImageView!
    @IBOutlet var acc2: UIActivityIndicatorView!
    @IBOutlet var acc: UIActivityIndicatorView!
    @IBOutlet var madaButton: UIButton!
    @IBOutlet var cashButton: UIButton!
    @IBOutlet var option3Button: UIButton!
    @IBOutlet var walletButton: UIButton!

    @IBOutlet var disCCount: UIButton!
    @IBOutlet var addanother: UIButton!
    @IBOutlet var sendOrder: UIButton!
    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var View1: UIView!
    @IBOutlet var serialTF: UITextField!
    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var locationLbl: UILabel!
    @IBOutlet var userNamelbl: UILabel!
    @IBOutlet var phoneNumber: UILabel!
    @IBOutlet var car_type: UILabel!
    @IBOutlet var serv_type: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var total_price: UILabel!
    @IBOutlet var viewtohide: UIView!
    @IBOutlet var labeltohide: UILabel!
    @IBOutlet var cashLbl: UILabel!
    @IBOutlet var madaLbl: UILabel!
    @IBOutlet weak var optionThreeLab: UILabel!
    @IBOutlet weak var myWalletLab: UILabel!
    @IBOutlet var walletValueLbl: UILabel!

    @IBOutlet private weak var userPackName: UILabel!
    @IBOutlet private weak var userTime: UILabel!
    @IBOutlet private weak var userAddress: UILabel!
    @IBOutlet private weak var userCoupon: UILabel!
    @IBOutlet private weak var userPaymentName: UILabel!
    
    var mesaArr = [WorkTimes]()
    var userid:String!
    var serviceId:String!
    var subServiceId:String!
    var carSizeId:String!
    var carTypeId:String!
    var Longitude:Double!
    var Latitude:Double!
    var orderDate:String!
    var tokenWorkTime:String!
    var Laddress:String!
    var brandId:String!
    var couponSerial:String?
    // NAMES
    var userName:String!
    var phone:String!
    var serviceName:String!
    var cartype:String!
    var servicePrice:String!
    var dateString:String!
    var paymentName:String!
    var servNames = [String]()
    var services = [[String:Any]]()
    var totalPrice = 0.0
    var NCars:String!
    var servicesNames = [[String:String]]()
    //
    var paymentId:String?
    
    var bookTime:String = ""
    var bookDate:String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mytableview.reloadData()
        mytableview.heightAnchor.constraint(equalToConstant:CGFloat(services.count * 40)).isActive = true
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.userAddress.text = self.Laddress
        self.userTime.text = "\(bookDate) \(bookTime)"
        self.userPaymentName.text = paymentName
        self.userPackName.text = self.serviceName
        
        self.profileAPI()
        acc.hidesWhenStopped = true
        if services.count == 0 {
            viewtohide.isHidden = true
            labeltohide.isHidden = true
        }
        design()
//        totalPrice = Double(servicePrice)!
//        for i in 0..<services.count {
//            totalPrice +=  Double(services[i]["price"] as! String) ?? 0
//
//        }
        noFooter(table: mytableview)
        userNamelbl.text = userName
        phoneNumber.text = phone
        price.text = servicePrice + ".0 SAR"
        car_type.text = cartype
        serv_type.text = serviceName
        locationLbl.text = Laddress
        timeLbl.text = dateString
        total_price.text = "\(totalPrice) SAR"
        
       
    }
    
    @IBAction func payment(_ sender: UIButton) {
        excmal.isHidden = true
        addtionalLabel.textColor = UIColor.black
        if sender.tag == 0 {
            cashButton.setImage(UIImage(named: "B_Checked"), for: .normal)
            madaButton.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            option3Button.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            walletButton.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            cashLbl.textColor = UIColor.black
            madaLbl.textColor = UIColor(rgb:0x9A9A9A)
            optionThreeLab.textColor = UIColor(rgb:0x9A9A9A)
            myWalletLab.textColor = UIColor(rgb:0x9A9A9A)
            paymentId = "1"
            paymentName = cashLbl.text
        }else if sender.tag == 1 {
            madaButton.setImage(UIImage(named: "B_Checked"), for: .normal)
            cashButton.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            option3Button.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            walletButton.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            madaLbl.textColor = UIColor.black
            cashLbl.textColor = UIColor(rgb:0x9A9A9A)
            optionThreeLab.textColor = UIColor(rgb:0x9A9A9A)
            myWalletLab.textColor = UIColor(rgb:0x9A9A9A)
            paymentId = "2"
            paymentName = madaLbl.text
        }else if sender.tag == 2 {
            madaButton.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            cashButton.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            option3Button.setImage(UIImage(named: "B_Checked"), for: .normal)
            walletButton.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            cashLbl.textColor = UIColor(rgb:0x9A9A9A)
            madaLbl.textColor = UIColor(rgb:0x9A9A9A)
            optionThreeLab.textColor = UIColor.black
            myWalletLab.textColor = UIColor(rgb:0x9A9A9A)
            paymentId = "3"
            paymentName = optionThreeLab.text
#warning("paymentName / paymentId ??")
        }else if sender.tag == 3 {
            madaButton.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            cashButton.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            option3Button.setImage(UIImage(named: "B_Unchecked"), for: .normal)
            walletButton.setImage(UIImage(named: "B_Checked"), for: .normal)
            madaLbl.textColor = UIColor(rgb:0x9A9A9A)
            cashLbl.textColor = UIColor(rgb:0x9A9A9A)
            optionThreeLab.textColor = UIColor(rgb:0x9A9A9A)
            myWalletLab.textColor = UIColor.black
            paymentId = "4"
            paymentName = myWalletLab.text
#warning("paymentName / paymentId ??")
        }
        
    }
    //MARK:- Sending to Cart
    @IBAction func addOtherOrder(_ sender: UIButton) {
        guard let ppayment = paymentId ,!ppayment.isEmpty else {
            excmal.isHidden = false
            addtionalLabel.textColor = UIColor(rgb: 0xFF3B30)
            return
        }
        if !support.checkUserId{
                   alert.registerAlert(v: self)
                   return
               }
        var id = ""
        if support.checkUserId {
            id = support.getuserId
        }
        
        cartArray.append(FRDData(userId:id, serviceId: serviceId, carSizeId: carSizeId, carTypeId: carTypeId, longitude:String(Longitude), latitude: String(Latitude), address:Laddress, orderDate: orderDate, orderTimeId: tokenWorkTime, numberOfCars:NCars, totalPrice: "\(totalPrice)", subServices: services, userName: userName, userPhone: phone, carTypeName: cartype, serviceTypeName: serviceName, servicePrice: servicePrice,ServicesNames: servNames,Payment:paymentName, subServiceId:subServiceId,paymentId:paymentId!,brandId:brandId,couponSerial:couponSerial ?? ""))
        saveUserData(cartArray)
        showSuccessWithStatus(Localized("CRT"))
        noti.post(name: Notification.Name("cartTye"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
        
        
        
    }
    
    
    //MARK:- Making Order
    @IBAction func makeOrdertapped(_ sender: Any) {
        guard let ppayment = paymentId ,!ppayment.isEmpty else {
            excmal.isHidden = false
            addtionalLabel.textColor = UIColor(rgb: 0xFF3B30)
            return
        }
        if !support.checkUserId{
            alert.registerAlert(v: self)
            return
        }
      if !api.isConnectedToInternet() {
            alert.alertPopUp(title: Localized("err"), msg: Localized("conMSG"), vc: self)
                   return
        }else {
        excmal.isHidden = true
        addtionalLabel.textColor = UIColor.black
        acc2.startAnimating()
        sendOrder.isUserInteractionEnabled = false;sendOrder.isHighlighted = true
        api.MakeOrderApi(serviceId:serviceId,subServiceId:subServiceId,carSizeId:carSizeId,brandId:brandId,cartypeId:carTypeId, logitude:String(Longitude),latitude:String(Latitude),address:Laddress,orderDate:orderDate,orderTimeId:tokenWorkTime, numberOfCars:NCars,paymentId:ppayment,totalPrice:"\(totalPrice)",couponSerial:couponSerial ?? "", services:services) { (error, result, code) in
            if code == 200 {
                self.acc2.stopAnimating()
                showSuccessWithStatus(Localized("suord"))
                self.navigationController?.popToRootViewController(animated: true)
            }else if code == 402 {
                self.acc2.stopAnimating()
                showErrorWithStatus(Localized("maxx"))
                self.sendOrder.isUserInteractionEnabled = true;self.sendOrder.isHighlighted = false
            }else{
                self.acc2.stopAnimating()
                showErrorWithStatus(Localized("errll"))
                self.sendOrder.isUserInteractionEnabled = true;self.sendOrder.isHighlighted = false
            }
            
        }
        
        
        
        }
        
    }
    //MARK:-
    @IBAction func discounttapped(_ sender:
        Any) {
        guard let ser = serialTF.text , !ser.isEmpty else {
            return
        }
        acc.startAnimating()
        
        api.coupon(URL: couponCheck,serial:ser) { (error, result, code) in
            if code == 200 {
                self.couponSerial = ser
                self.acc.stopAnimating()
                let ratio = (JSON(result!)["ratio"].doubleValue)/100
                self.totalPrice = self.totalPrice - (self.totalPrice * ratio)
                self.total_price.text = "\((self.totalPrice*100).rounded()/100) SAR"
                self.disCCount.isHighlighted = true
                self.serialTF.isHighlighted = true
                self.disCCount.isUserInteractionEnabled = false
                self.serialTF.isUserInteractionEnabled = false
                showSuccessWithStatus(Localized("sucv") + "\(ratio * 100)%" + Localized("Disc") )
            }else if code == 422 {
                self.acc.stopAnimating()
                showInfoWithStatus(Localized("noDB"))
            }else {
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servNames.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FSRVCell", for: indexPath) as! FinalSRV
        cell.name.text = servNames[indexPath.row]
        cell.price.text = services[indexPath.row]["price"] as? String
        return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    
}

extension FinalOrderView {
   

    func design (){
           View1.layer.borderWidth = 0.5
           View1.layer.cornerRadius = 10.0
           View1.clipsToBounds = true
           View1.layer.borderColor = UIColor(rgb: 0x450638).cgColor
           //
           view2.layer.borderWidth = 0.5
           view2.layer.cornerRadius = 10.0
           view2.clipsToBounds = true
           view2.layer.borderColor = UIColor(rgb: 0x450638).cgColor
           //
           view3.layer.borderWidth = 0.5
           view3.layer.cornerRadius = 10.0
           view3.clipsToBounds = true
           view3.layer.borderColor = UIColor(rgb: 0x450638).cgColor
           //
           sendOrder.layer.cornerRadius = 5.0
           sendOrder.clipsToBounds = true
           //
           disCCount.layer.cornerRadius = 5.0
           disCCount.clipsToBounds = true
           
           
           
       }
    
    
}

//MARK: - Networking
extension FinalOrderView {
    
    private func profileAPI() {
        showSvProgressHUDwithStatus(nil)
    api.getProfile() { (error, result, code) in
        dismissSvProgressHUD()
           if code == 200 {
               self.walletValueLbl.text = JSON(result!)["wallet"].doubleValue.description
   }}}
    
    
    
    
}
