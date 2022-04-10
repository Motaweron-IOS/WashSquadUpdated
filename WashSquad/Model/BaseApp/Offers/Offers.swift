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


class Offers:  UIViewController{
   
    var jsonData = [JSON]()
    
    @IBOutlet var offerTableview: UITableView!{
        didSet {
            self.offerTableview.delegate = self
            self.offerTableview.dataSource = self
    }}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Localized("ofrs")
        Offers()
        print("⛵️✅ Offers === ")

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
    }}}}
    
    @IBAction func logout(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
   
    
    

}
//MARK: - TableView Configs
extension Offers : UITableViewDelegate, UITableViewDataSource {
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
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // if self.jsonData.isEmpty == false {
            print("🔴 selected cell offer === \(indexPath.row)")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "washMainCell") as! subSubWashMain
            vc.serviceId = self.jsonData[indexPath.row]["service_id"].intValue.description
            self.navigationController?.pushViewController(vc, animated: true)
      //  }
    }

    

}
