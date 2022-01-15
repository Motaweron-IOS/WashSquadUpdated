//
//  washSub.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class washSub: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var Subview = [JSON]()
    @IBOutlet var mycollectionview: UICollectionView!
    var serviceId:String?
    var subServiceId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mycollectionview.reloadData()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        services.removeAll()
        servNames.removeAll()
        servicesNames.removeAll()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subSubmainView" {
            let cell = sender as! washMainCell
            let indexPath = mycollectionview.indexPath(for: cell)!
            let vc = segue.destination as! subSubWashMain
            vc.subSubview.append(Subview[indexPath.row])
            vc.subServiceId = subServiceId
            vc.serviceId = serviceId
            vc.identifier = segue.identifier
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Subview.count != 0 {return Subview.count}else{return 0}
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "washidentifiersub", for: indexPath) as! washMainCell
           if Subview.count != 0 {
            if Locale.preferredLanguages[0] == "ar"{
            cell.title.text = Subview[indexPath.row]["ar_title"].stringValue
            }else {
                cell.title.text = Subview[indexPath.row]["en_title"].stringValue
            }
            cell.title.heightAnchor.constraint(equalToConstant:cell.title.bounds.height).isActive = true
               cell.image.kf.setImage(with: ImageResource(downloadURL: URL(string:imageURL + Subview[indexPath.row]["image"].stringValue)!))
           }
           return cell
       }
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at:indexPath)
        subServiceId = Subview[indexPath.row]["id"].stringValue
        performSegue(withIdentifier: "subSubmainView", sender: cell)
           
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (UIScreen.main.bounds.width/2)-15 , height:200)
            
        
           
       }
     

    

    

}
