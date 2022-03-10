//
//  Profile.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/14/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import EzPopup

class Profile: uploadPhoto,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    @IBOutlet var ratingView: UIView!
    @IBOutlet var accSend: UIActivityIndicatorView!
    @IBOutlet var nameError: UIImageView!
    @IBOutlet var myScrollView: UIScrollView!
    @IBOutlet var ordersCollectionView: UICollectionView!
    @IBOutlet var nameView: UIView!
    @IBOutlet var aview: UIView!
    @IBOutlet var ProfileView: UIImageView!
    @IBOutlet var save: UIButton!
    @IBOutlet var servName: UILabel!
    @IBOutlet var servPrice: UILabel!
    @IBOutlet var servdate: UILabel!
    @IBOutlet var carName: UILabel!
    @IBOutlet var servTime: UILabel!
    @IBOutlet var rate1: UIButton!
    @IBOutlet var rate2: UIButton!
    @IBOutlet var rate3: UIButton!
    @IBOutlet var rate4: UIButton!
    @IBOutlet var rate5: UIButton!
    @IBOutlet var aviewtohide: UIView!
    @IBOutlet var fullname: UITextField!
    @IBOutlet var serviceImage: UIImageView!
    @IBOutlet var acc: UIActivityIndicatorView!
    @IBOutlet var thatView: UIView!
    @IBOutlet var opinion: UITextView!
    @IBOutlet var sendrateButton: UIButton!
    @IBOutlet var viewHeightConst: NSLayoutConstraint!
    
    var selectedIndex:IndexPath?
    var ordersData = [JSON]()
    var phone:String?
    var ref = UIRefreshControl()
    var currentPage = 1
    var lastPage = 0
    var rate:Int?
    var flag = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
        navigationItem.title = Localized("prof")
        if Locale.preferredLanguages[0] == "ar" {
                ordersCollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        ShowActivity(align: view.center, to: view)
        fullname.delegate = self
        //ref.addTarget(self, action: #selector(getMyorders), for:UIControl.Event.valueChanged)
        //myScrollView.addSubview(ref)
        fullname.text = def.dictionary(forKey: "userData")!["name"] as? String
        phone = def.dictionary(forKey: "userData")!["phone"] as? String
        ProfileView.image = UIImage(data:(def.dictionary(forKey: "userData")!["logo"] as? Data)!)
        viewHeightConst.constant = 0
        aviewtohide.isHidden = true

        nameView.layer.borderWidth = 0.5
        nameView.layer.cornerRadius = 10.0
        nameView.clipsToBounds = true
        nameView.layer.borderColor = UIColor(rgb: 0x450038).cgColor
        //
        ProfileView.layer.cornerRadius = ProfileView.frame.size.height / 2
        ProfileView.clipsToBounds = true
        ProfileView.layer.borderWidth = 1.0
        ProfileView.layer.borderColor = UIColor(rgb: 0x450038).cgColor
        //
        getMyorders()
        
    }
    
    
    @IBAction func changePasswordTapped(_ sender: Any){
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "passFORG") as! passRest
        let popupVC = PopupViewController(contentController: popOverVC, popupWidth: UIScreen.main.bounds.width-20, popupHeight: 250)
        popupVC.backgroundAlpha = 0.3
        popupVC.backgroundColor = .black
        popupVC.canTapOutsideToDismiss = true
        popupVC.cornerRadius = 10
        popupVC.shadowEnabled = true
        present(popupVC, animated: true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameError.isHidden = true
    }
    var RatingGun:Bool{
        set{
          ratingView.heightAnchor.constraint(equalToConstant: 0).isActive = newValue
        }get{
          return  ratingView.heightAnchor.constraint(equalToConstant: 0).isActive
        }
    }
    
  @objc func getMyorders(){
      if !api.isConnectedToInternet() {
                    showErrorWithStatus(Localized("connMSG"))
                    return
         }else {
            api.myOrders(page: "\(currentPage)") { (error, result, code) in
                if code == 200 {
                    StopActivity()
                    self.thatView.layer.borderWidth = 0.5
                    self.thatView.layer.cornerRadius = 10.0
                    self.thatView.clipsToBounds = true
                    self.thatView.layer.borderColor = UIColor(rgb: 0x450038).cgColor
                    if self.flag == true {
                        self.currentPage += 1
                        self.ordersData += JSON(result!)["data"].arrayValue
                    }else{
                        self.currentPage += 1
                        self.ordersData = JSON(result!)["data"].arrayValue
                        self.flag = true
                    }
                    self.lastPage = JSON(result!)["last_page"].intValue
                    self.ordersCollectionView.reloadData()
                    self.ref.endRefreshing()
                }else if code == 404 {
                    StopActivity()
                    self.ref.endRefreshing()
                }else {
                    showErrorWithStatus(Localized("errll"))
                    self.ref.endRefreshing()
                    StopActivity()
                }}}
        
    }
    override func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //.MARK: - Logout
    @IBAction func logout(_ sender: Any) {
//        if !api.isConnectedToInternet() {
//            alert.alertPopUp(title:Localized("err"), msg: Localized("connMSG"), vc: self)
//            return
//            }
//        if !support.checkUserId{
//            alert.registerAlert(v: self)
//            return
//        }
//
//        showSvProgressHUDwithStatus(nil)
//        api.Logout(URL: logOutUrl, userId:support.getuserId){ (error, result, code) in
//            switch code {
//            case 200:
//                dismissSvProgressHUD()
//                support.deleteAllData
//                deleteAllData(entity:"CartModel")
//                self.present(self.storyboard!.instantiateViewController(withIdentifier: "loginVC"), animated: true, completion: nil)
//
//            default:
//                dismissSvProgressHUD()
//                alert.alertPopUp(title: Localized("err"), msg: Localized("errll"), vc: self)
//
//            }
//        }
    }
    
     //MARK: - Setting button
    @IBAction func infotapped(_ sender: Any) {
      //  performSegue(withIdentifier: "infosecs", sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            ProfileView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func sendRate(_ sender: Any) {
        
        if !api.isConnectedToInternet() {
            showErrorWithStatus(Localized("connMSG"))
                return
        }else{
            accSend.startAnimating()
            sendrateButton.isUserInteractionEnabled = false
            api.rateSender(orderId: ordersData[selectedIndex!.row]["id"].stringValue, rateVal: "\(rate ?? 0)", opinion:opinion.text ?? "None") { (error, resut, code ) in
                if code == 200 {
                    self.sendrateButton.isUserInteractionEnabled = true
                    showSuccessWithStatus(Localized("rts"))
                    self.accSend.stopAnimating()
                    
                }else {
                    self.sendrateButton.isUserInteractionEnabled = true
                   showErrorWithStatus(Localized("noComp"))
                    self.accSend.stopAnimating()
                }
            }
            
        }
    }
    
    @IBAction func ratetapped(_ sender: UIButton) {
        rate(sender: sender.tag)
        rate = sender.tag
    }
    @IBAction func uploadPhoto(_ sender: Any) {
        uplaodTapped()
    }
    @IBAction func saveTapped(_ sender: Any) {
            acc.startAnimating()
            save.isUserInteractionEnabled = false
            guard let name = fullname.text, !name.isEmpty else {
                nameError.isHidden = false
                acc.stopAnimating()
                return
            }
            if let imageData = ProfileView.image!.jpegData(compressionQuality: 1.0) {
                if !api.isConnectedToInternet() {
                    showErrorWithStatus(Localized("connMSG"))
                        return
                }else{
                    api.updateProfile(targetURL: updateMyProfileUrl, name: name, pass:"", logo: ProfileView.image!) { (error, result, code) in
                        if code == 200 {
                            self.save.isUserInteractionEnabled = true
                            def.set(["name":name,"phone":self.phone!,"logo":imageData], forKey: "userData")
                            self.acc.stopAnimating()
                            showSuccessWithStatus(Localized("su"))
                        }else {
                            showErrorWithStatus(Localized("errll"))
                            self.save.isUserInteractionEnabled = true
                    }}}}
        }
        
        
    
    
    
   

    

}
//MARK: - Rate
extension Profile {
    func rate(sender:Int){
        switch sender {
        case 1:
            rate1.setImage(UIImage(named: "rateOn"), for: .normal)
            rate2.setImage(UIImage(named: "rateOff"), for: .normal)
            rate3.setImage(UIImage(named: "rateOff"), for: .normal)
            rate4.setImage(UIImage(named: "rateOff"), for: .normal)
            rate5.setImage(UIImage(named: "rateOff"), for: .normal)
        case 2:
           rate1.setImage(UIImage(named: "rateOn"), for: .normal)
            rate2.setImage(UIImage(named: "rateOn"), for: .normal)
            rate3.setImage(UIImage(named: "rateOff"), for: .normal)
            rate4.setImage(UIImage(named: "rateOff"), for: .normal)
            rate5.setImage(UIImage(named: "rateOff"), for: .normal)
        case 3:
            rate1.setImage(UIImage(named: "rateOn"), for: .normal)
            rate2.setImage(UIImage(named: "rateOn"), for: .normal)
            rate3.setImage(UIImage(named: "rateOn"), for: .normal)
            rate4.setImage(UIImage(named: "rateOff"), for: .normal)
            rate5.setImage(UIImage(named: "rateOff"), for: .normal)
        case 4:
            rate1.setImage(UIImage(named: "rateOn"), for: .normal)
            rate2.setImage(UIImage(named: "rateOn"), for: .normal)
            rate3.setImage(UIImage(named: "rateOn"), for: .normal)
            rate4.setImage(UIImage(named: "rateOn"), for: .normal)
            rate5.setImage(UIImage(named: "rateOff"), for: .normal)
        case 5:
            rate1.setImage(UIImage(named: "rateOn"), for: .normal)
            rate2.setImage(UIImage(named: "rateOn"), for: .normal)
            rate3.setImage(UIImage(named: "rateOn"), for: .normal)
            rate4.setImage(UIImage(named: "rateOn"), for: .normal)
            rate5.setImage(UIImage(named: "rateOn"), for: .normal)
        default:
            return
            
        }
    }
}
//MARK: - CollectionView
extension Profile {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ordersData.count == 0 {
            if Locale.preferredLanguages[0] == "ar"{collectionView.setEmptyMessage(Localized("EMPY"));collectionView.backgroundView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0) }else {collectionView.setEmptyMessage(Localized("EMPY"))}
            return 0
        }else {
            collectionView.restore()
            return ordersData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Ocells", for: indexPath) as! ordersCell
        cell.number.text = "\(indexPath.row + 1)"
        if Locale.preferredLanguages[0] == "ar"{
             cell.number.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        if indexPath == selectedIndex{
            UIView.animate(withDuration: 0.5) {
                self.aviewtohide.isHidden = false
                self.viewHeightConst.constant = 550
                
            }
            cell.number.textColor = .white
            cell.aview.backgroundColor = UIColor(rgb: 0x450038)
            if ordersData[indexPath.row]["rating"].stringValue != "" {
                RatingGun = true
                ratingView.isHidden = true
                viewHeightConst.constant = 280
                
            }
            servdate.text = time_as_string(timeStamp: ordersData[indexPath.row]["order_date"].doubleValue)
            servPrice.text = Localized("ppRice") +  ordersData[indexPath.row]["total_price"].stringValue + " \(Localized("ryal"))"
            serviceImage.kf.setImage(with:ImageResource(downloadURL: URL(string: imageURL + ordersData[indexPath.row]["service_image"].stringValue)!))
            if Locale.preferredLanguages[0] == "ar" {
                   
                    
                servName.text = ordersData[indexPath.row]["service_ar_title"].stringValue + " - " + ordersData[indexPath.row]["service_level2_ar_title"].stringValue
                servTime.text = ordersData[indexPath.row]["work_time_choosen"].stringValue + " " + ordersData[indexPath.row]["work_time_ar_title"].stringValue
                carName.text = ordersData[indexPath.row]["carType__ar_title"].stringValue + " - " + ordersData[indexPath.row]["brand__ar_title"].stringValue
                
                
            }else{
                servName.text = ordersData[indexPath.row]["service_en_title"].stringValue + " - " + ordersData[indexPath.row]["service_level2_en_title"].stringValue
                servTime.text = ordersData[indexPath.row]["work_time_choosen"].stringValue + " " + ordersData[indexPath.row]["work_time_en_title"].stringValue
                carName.text = ordersData[indexPath.row]["carType_en_title"].stringValue + " - " + ordersData[indexPath.row]["brand_en_title"].stringValue
                
            }
            
            
        }else {
            cell.number.textColor = .black
            cell.aview.backgroundColor = .white
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if ordersData.count != 0{
        if indexPath.row == ordersData.count-1{
        if currentPage <= lastPage{perform(#selector(getMyorders))}
           }
        }
    }
    
}
