//
//  Offers.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/15/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON


class Offers:  UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var jsonData = [JSON]()
    @IBOutlet var offerTableview: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Localized("ofrs")
        Offers()
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
    }
    
    
    func Offers(){
        if !api.isConnectedToInternet() {
            showErrorWithStatus(Localized("connMSG"))
        return
        }else {
            ShowActivity(align: view.center, to: view)
            api.AllOffersApi(URL: OffersUrl) { (err, result, code) in
                if code == 200 {
                    self.jsonData = JSON(result!)["data"].arrayValue
                    
                    self.offerTableview.reloadData()
                    StopActivity()
                }else {
                    StopActivity()
                    showErrorWithStatus(Localized("errll"))
                }
                
            }
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ocell", for: indexPath) as! OffersCell
        cell.offerImage.kf.setImage(with:ImageResource(downloadURL: URL(string: imageURL + jsonData[indexPath.row]["image"].stringValue)!))
        return cell
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 258
           
       }
    

    

}
