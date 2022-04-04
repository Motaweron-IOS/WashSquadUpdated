//
//  washMain.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

var servicesmain = [allServices]()

class washMain: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var servicesSub = [[JSON]]()
    var serviceId:String?
    
    @IBOutlet var mycollectionview: UICollectionView!
    
   
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        
            servicesmain.removeAll()
            getllServ()
        
            //navigationController?.navigationBar.prefersLargeTitles = true

            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(named: "Main")
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Localized("srvs")
    }
    
    func getllServ(){
        if !api.isConnectedToInternet() {
            showErrorWithStatus(Localized("connMSG"))
            return
         }else {
            ShowActivity(align: view.center, to: view)
            api.allServices(URL: allservicesUrl) { (error, result, code) in
                if code == 200 {
                    if Locale.preferredLanguages[0] == "ar" {
                    for i in 0..<JSON(result!)["data"].count {
                        servicesmain.append(allServices(id: JSON(result!)["data"][i]["id"].stringValue, title: JSON(result!)["data"][i]["ar_title"].stringValue, image: JSON(result!)["data"][i]["image"].stringValue))
                        self.servicesSub.append(JSON(result!)["data"][i]["level2"].arrayValue)

                    }
                    }else{
                        for i in 0..<JSON(result!)["data"].count {
                        servicesmain.append(allServices(id: JSON(result!)["data"][i]["id"].stringValue, title: JSON(result!)["data"][i]["en_title"].stringValue, image: JSON(result!)["data"][i]["image"].stringValue))
                            self.servicesSub.append(JSON(result!)["data"][i]["level2"].arrayValue)

                 }
                }
                    StopActivity()
                    self.mycollectionview.reloadData()
                }else {
                    StopActivity()
                    showErrorWithStatus(Localized("errll"))

                }
          }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goingSub" {
            let cell = sender as! washMainCell
            let indexPath = mycollectionview.indexPath(for: cell)!
            let vc = segue.destination as! washSub
            vc.Subview = servicesSub[indexPath.row]
            vc.serviceId = serviceId
        }
    }
        
    @IBAction func logout(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if servicesmain.count != 0 {return servicesmain.count}else{return 0}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "washidentifier", for: indexPath) as! washMainCell
        if servicesmain.count != 0 {
            cell.title.text = servicesmain[indexPath.row].title
            cell.image.kf.setImage(with: ImageResource(downloadURL: URL(string:imageURL + servicesmain[indexPath.row].image)!))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        serviceId = servicesmain[indexPath.row].id
        performSegue(withIdentifier: "goingSub", sender: cell)
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "washMainCell") as! subSubWashMain
//            vc.serviceId = self.serviceId
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2)-15 , height: 150.0 )
        
    }
  

}
