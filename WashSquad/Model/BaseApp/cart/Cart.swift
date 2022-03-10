//
//  Cart.swift
//  WashSquad
//
//  Created by Eslam Moemen on 11/17/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//
var cartArray = [FRDData]()


import UIKit
import CoreData


class Cart: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
   
    
    @IBOutlet var buttonHeight: NSLayoutConstraint!
    @IBOutlet var addV: UIButton!
    @IBOutlet var myTableview: UITableView!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Localized("crt$")
        noti.addObserver(self, selector: #selector(ref), name: Notification.Name("Ref"), object: nil)
        noti.addObserver(self, selector: #selector(regadd), name: Notification.Name("Regf"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        myTableview.reloadData()
        if retrieveSavedUsers()?.count == 0 {
            addV.setTitle(Localized("ordNow"), for: .normal)
        }else{
            addV.setTitle(Localized("adnv"), for: .normal)
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "Main")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    @objc func ref(){
        myTableview.reloadData()
    }
    
    @IBAction func logout(_ sender: Any) {
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
                self.present(self.storyboard!.instantiateViewController(withIdentifier: "loginVC"), animated: true, completion: nil)
             
            default:
                dismissSvProgressHUD()
                alert.alertPopUp(title: Localized("err"), msg: Localized("errll"), vc: self)
                
            }
        }
    }
    
    
    var lastContentOffset: CGFloat = 0

    func scrollViewWillBeginDragging(_ scrollView:UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView:UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            // did move up
            UIView.animate(withDuration: 0.8) {
                self.addV.isHidden = true
                self.view.layoutIfNeeded()
            }
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            UIView.animate(withDuration: 0.8) {
                 self.addV.isHidden = false
                 self.view.layoutIfNeeded()
            }
          
        } else {
            // didn't move
        }
    }
    
    @IBAction func addanother(_ sender: Any) {
        noti.post(name: Notification.Name("selctr"), object: nil)
    }
    @objc func regadd(){
        alert.registerAlert(v: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if retrieveSavedUsers()?.count != 0 {
            tableView.isScrollEnabled = true;tableView.backgroundView = nil
            return retrieveSavedUsers()!.count
        }else{
            emptytable(tableView)
            return 0
        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)  as! CartCellProtoType
        //cell.delegate = self
        if retrieveSavedUsers()![indexPath.row].subServices.count == 0 {
            cell.smalTab.constant = 0;cell.servLabel.isHidden = true;cell.view1.isHidden = true
        }else {
            cell.smalTab.constant = CGFloat((retrieveSavedUsers()![indexPath.row].subServices.count * 50))
            cell.view1.isHidden = false;cell.servLabel.isHidden = false;
        }
        cell.name.text = retrieveSavedUsers()![indexPath.row].userName
        cell.totalPrice.text = retrieveSavedUsers()![indexPath.row].totalPrice + " \(Localized("ryal"))"
        cell.serviceType.text = retrieveSavedUsers()![indexPath.row].serviceTypeName
        cell.servicePrice.text = retrieveSavedUsers()![indexPath.row].servicePrice
        cell.carBrand.text = retrieveSavedUsers()![indexPath.row].carTypeName
        cell.payment.text = retrieveSavedUsers()![indexPath.row].Payment
        cell.servicesTableview.tag = indexPath.row
        cell.sendOrder.tag = indexPath.row
        cell.phone.text = retrieveSavedUsers()![indexPath.row].userPhone
        return cell
        
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 365 + CGFloat((retrieveSavedUsers()![indexPath.row].subServices.count * 50))
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deleteDataAtIndex(atIndex: indexPath.row, array:retrieveSavedUsers()!)
        tableView.reloadData()
    }
    
    
    

    

}

//MARK:-CartCellClass
class CartCellProtoType: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
   

    @IBOutlet var name: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var carBrand: UILabel!
    @IBOutlet var servicesTableview: UITableView!
    @IBOutlet var serviceType: UILabel!
    @IBOutlet var servicePrice: UILabel!
    @IBOutlet var payment: UILabel!
    @IBOutlet var totalPrice: UILabel!
    @IBOutlet var sendOrder: UIButton!
    @IBOutlet var smalTab: NSLayoutConstraint!
    @IBOutlet var servLabel: UILabel!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    
    
   // var delegate:exs?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        servicesTableview.delegate = self
        servicesTableview.dataSource = self
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func sendTapped(_ sender: Any) {
        let arr = retrieveSavedUsers()![sendOrder.tag]
        if !support.checkUserId{
            noti.post(name: Notification.Name("Regf"), object: nil)
            return
        }
        
        showSvProgressHUDwithStatus(nil)
        api.MakeOrderApi(serviceId:arr.serviceId, subServiceId:arr.subServiceId, carSizeId: arr.carSizeId, brandId: arr.brandId, cartypeId: arr.carTypeId, logitude: arr.longitude, latitude: arr.latitude, address: arr.address, orderDate: arr.orderDate, orderTimeId: arr.orderTimeId, numberOfCars: arr.numberOfCars, paymentId:arr.paymentId, totalPrice: arr.totalPrice, couponSerial:arr.couponSerial, services: arr.subServices) { (error, result, code) in
            if code == 200 {
                deleteDataAtIndex(atIndex: self.sendOrder.tag, array: retrieveSavedUsers()!)
                noti.post(name: Notification.Name("Ref"), object: nil)
                dismissSvProgressHUD()
                noti.post(name: Notification.Name("cartTye"), object: nil)
                showSuccessWithStatus(Localized("suord"))

            }else if code == 402 {
                showErrorWithStatus(Localized("maxx"))
            }else {
                showErrorWithStatus(Localized("errll"))
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrieveSavedUsers()![servicesTableview.tag].subServices.count
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sefvcc", for: indexPath) as! FinalSRV
       
        if retrieveSavedUsers()![servicesTableview.tag].subServices.count != 0 {
            cell.price.text = retrieveSavedUsers()![servicesTableview.tag].subServices[indexPath.row]["price"] as? String
            cell.name.text = retrieveSavedUsers()![servicesTableview.tag].ServicesNames[indexPath.row]
        }
        return cell
       }
    
       

}


