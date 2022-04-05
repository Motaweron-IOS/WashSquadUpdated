//
//  subSubWashMain.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import DropDown
import CalendarFoundation

protocol sendBacwards{
    func address(address: String,long:Double,Lat:Double)
}
protocol excutecell{
    func excutcell()
}
var services = [[String:String]]()
var servicesNames = [[String:String]]()
var servNames = [String]()


class subSubWashMain: UIViewController,sendBacwards{
  
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var counter: UILabel!
    @IBOutlet var acc:UIActivityIndicatorView!
    @IBOutlet var cartypeError: UIImageView!
    @IBOutlet var brandtypeError: UIImageView!
    @IBOutlet var locationError: UIImageView!
    @IBOutlet var dateError: UIImageView!
    @IBOutlet var timeError: UIImageView!
    @IBOutlet var pricelabel: UILabel!
    @IBOutlet var spinnerPrice: UIActivityIndicatorView!
    
    var carSizes = [allServicesLev2]()
    var selectedIndex:IndexPath?
    var TableSelectedIndex:IndexPath?
    var brandTypeJson = [JSON]()
    var workTimes = [WorkTimes]()
    var cartypesJson = [JSON]()
    var subSubview = [JSON]()
    
    var typedown = DropDown()
    var brandDown = DropDown()
    var timesDown = DropDown()
    var placedown = DropDown()

    var placesData = [JSON]()

    
    var sendDate = 0
    var userid = ""
    var serviceId:String?
    var subServiceId:String?
    var carSizeId:String?
    var carTypeId:String?
    var Longitude:Double?
    var Latitude:Double?
    var orderDate:String?
    var tokenWorkTime:String?
    var Laddress:String?
    var brandId:String?
    var count = 1
    var price = 0.0
    var tempPrice = 0.0
    var totalPrice = 0.0
    var placeId:String?

    // NAMES
    var userName = "???"
    var phone = "???"
    var serviceName:String?
    var cartype:String?
    var servicePrice:String?
    var dateString:String?
    var identifier:String?
    
        
    @IBOutlet var dateButton: UITapGestureRecognizer!
    @IBOutlet var chooseBrandLbl: UILabel!
    @IBOutlet var servicesView: UIView!
    @IBOutlet var cartypelbl: UILabel!
    @IBOutlet var titleSubs: UILabel!
    @IBOutlet var timeView: UIView!
    @IBOutlet var dateView: UIView!
    @IBOutlet var locationView: UIView!
    @IBOutlet var timeLable: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var orderNowButton: UIButton!
    @IBOutlet var brandView: UIView!
    @IBOutlet var cartypeView: UIView!
    @IBOutlet var lblMoreStack: UIStackView!
    @IBOutlet var moredettext: UILabel!
    @IBOutlet var showMore: UIButton!
    @IBOutlet var aview: UIView!
    @IBOutlet var mycoll: UICollectionView!
    @IBOutlet var mytable: UITableView!
    @IBOutlet var Pic: UIImageView!
    @IBOutlet var placeView: UIView!{
        didSet{
            self.placeView.addActionn(vc: self, action: #selector(self.placestapped(_:)))
    }}

    
    @IBOutlet private weak var packageCollectionView: UICollectionView!
    
    @IBOutlet weak var placeLab: UILabel!{
        didSet{
            self.placeLab.text = Localized("Place")
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)        
       
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pricelabel.text = "\(price) \(Localized("ryal"))"
        totalPriceLabel.text = "\(totalPrice) \(Localized("ryal"))"
        counter.text = "\(count)"
        if support.checkUserId {
            userid = support.getuserId
            userName = (def.dictionary(forKey: "userData")!["name"] as? String)!
            phone = (def.dictionary(forKey: "userData")!["phone"] as? String)!
        }
        //typedown.cornerRadius = 10
        typedown.textFont = UIFont(name: "cairo", size: 17.0)!
        //brandDown.cornerRadius = 10
        brandDown.textFont = UIFont(name: "cairo", size: 17.0)!
        //timesDown.cornerRadius = 10
        timesDown.textFont = UIFont(name: "cairo", size: 17.0)!
        Pic.layer.cornerRadius = 5.0
        Pic.clipsToBounds = true
        design()
        
        self.getSingleService()
        carstypes()
         
        moredettext.isHidden = true
        carsizes()
        alltimes()
        self.getPlacesAPI()
        
        }
    //MARK:- OrderNOW!
       @IBAction func ordertapped(_ sender: Any) {
        guard let cartype = carTypeId,!cartype.isEmpty else {
            cartypeError.isHidden = false
            return
        }
        guard let brandtype = brandId,!brandtype.isEmpty else {
            brandtypeError.isHidden = false
            return
        }
        guard let location = Laddress,!location.isEmpty else {
            locationError.isHidden = false
            return
        }
        guard let date = orderDate,!date.isEmpty else {
            dateError.isHidden = false
            return
        }
        guard let time = tokenWorkTime,!time.isEmpty else {
            timeError.isHidden = false
            return
        }
        
        performSegue(withIdentifier: "afterOrder", sender: self)
    }
    
    @IBAction func showMore(_ sender: Any) {
        if showMore.title(for: .normal) == Localized("md") {
            showMore.setTitle(Localized("ld"), for: .normal)
            UIView.animate(withDuration:0.2) {
                self.moredettext.isHidden = false
            }
        }else{
           showMore.setTitle(Localized("md"), for: .normal)
            UIView.animate(withDuration:0.2) {
                self.moredettext.isHidden = true
            }
        
        }
    }
   
    @IBAction func carTypetapped(_ sender: Any) {
        typedown.anchorView = cartypeView
        if Locale.preferredLanguages[0] == "ar" {typedown.dataSource = cartypesJson.map{$0 ["ar_title"].stringValue} }else{
            typedown.dataSource = cartypesJson.map{$0 ["en_title"].stringValue}
        }
        typedown.customCellConfiguration = { (index,item,cell) -> Void in cell.optionLabel.textAlignment = .center}
        typedown.bottomOffset = CGPoint(x: 0, y:(typedown.anchorView?.plainView.bounds.height)!)
        typedown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.carTypeId = self.cartypesJson[index]["id"].stringValue
            self.cartypelbl.text = item
            self.cartypeError.isHidden = true
            self.totalPrice = self.totalPrice - self.price
            self.price = 0.0
            self.pricelabel.text = "\(self.price) \(Localized("ryal"))"
            self.totalPrice = (self.price * Double(self.count)) + self.tempPrice
            self.totalPriceLabel.text = "\(self.totalPrice) \(Localized("ryal"))"
            self.carSizeId = nil
            self.chooseBrandLbl.text = Localized("CB")
            self.brandTypeJson = self.cartypesJson[index]["level2"].arrayValue

        }
        typedown.show()
    }
    
    @objc func placestapped(_ sender: Any) {
        placedown.anchorView = placeView
        if Locale.preferredLanguages[0] == "ar" {
            placedown.dataSource = placesData.map{$0 ["title_ar"].stringValue}
           }else{
            placedown.dataSource = placesData.map{$0 ["title_en"].stringValue}
        }
        placedown.customCellConfiguration = { (index,item,cell) -> Void in cell.optionLabel.textAlignment = .center}
        placedown.bottomOffset = CGPoint(x: 0, y:(placedown.anchorView?.plainView.bounds.height)!)
        placedown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.placeId = "\(self.placesData[index]["id"].intValue)"
            if Locale.preferredLanguages[0] == "ar" {
                self.placeLab.text = self.placesData[index]["title_ar"].stringValue
            }else{
                self.placeLab.text = self.placesData[index]["title_en"].stringValue
            }
        }
        placedown.show()
    }
    
    
    
    @IBAction func sendingLocaion(_ sender: Any) {
        performSegue(withIdentifier: "getMyLocation", sender: self)
    }
    @IBAction func timeTapped(_ sender: Any) {
        timesDown.anchorView = timeView
        timesDown.dataSource = workTimes.map{$0.title}
        timesDown.customCellConfiguration = { (index, item, cell) -> Void in cell.optionLabel.textAlignment = .center}
        timesDown.bottomOffset = CGPoint(x: 0, y:(timesDown.anchorView?.plainView.bounds.height)!)
        timesDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.timeLable.text = item
            self.timeError.isHidden = true
            self.tokenWorkTime = self.workTimes[index].id
        }
        timesDown.show()
        
    }
    
    @IBAction func numberShow(_ sender: UIButton) {
        if carSizeId == nil {
            guard let cartype = carTypeId,!cartype.isEmpty else {
                cartypeError.isHidden = false
                return
            }
            guard let brandtype = brandId,!brandtype.isEmpty else {
                brandtypeError.isHidden = false
                return
            }
        }
        if sender.tag == 0 {
            count += 1
            counter.text = "\(count)"
            totalPrice += (price + tempPrice)
            self.totalPriceLabel.text = "\(self.totalPrice) \(Localized("ryal"))"

        }else {
            if  count != 1 {
                totalPrice -= (price + tempPrice)
                self.totalPriceLabel.text = "\(self.totalPrice) \(Localized("ryal"))"
                count -= 1
                counter.text = "\(count)"
                

            }
           
        }
        
    }
    
    @IBAction func chooserandTapped(_ sender: Any) {
        brandDown.anchorView = brandView
        if Locale.preferredLanguages[0] == "ar" {brandDown.dataSource = brandTypeJson.map{$0 ["ar_title"].stringValue} }else{
            brandDown.dataSource = brandTypeJson.map{$0 ["en_title"].stringValue}
        }
        brandDown.customCellConfiguration = { (index, item, cell) -> Void in cell.optionLabel.textAlignment = .center}
        brandDown.bottomOffset = CGPoint(x: 0, y:(brandDown.anchorView?.plainView.bounds.height)!)
        brandDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.chooseBrandLbl.text = item
            self.brandtypeError.isHidden = true
            self.carSizeId = self.brandTypeJson[index]["size"].stringValue
            self.brandId = self.brandTypeJson[index]["id"].stringValue
            self.cartype = self.cartypelbl.text! + " - " + self.chooseBrandLbl.text!
            self.spinnerPrice.startAnimating()
            api.getPriceApi(serviceId:self.subServiceId!,carsizeId:self.carSizeId!) { (error, result, code) in
                if code == 200 {
                     self.totalPrice = self.totalPrice - self.price
                    self.price = 0.0
                    self.price = JSON(result!).doubleValue
                    self.pricelabel.text = "\(self.price) \(Localized("ryal"))"
                    self.totalPrice = (self.price * Double(self.count)) + self.tempPrice
                    self.totalPriceLabel.text = "\(self.totalPrice) \(Localized("ryal"))"
                    self.spinnerPrice.stopAnimating()
                }
            }
            if self.brandTypeJson[index]["size"].stringValue == "1" {
                self.servicePrice = self.carSizes[0].price
                self.selectedIndex = [0,0]
                self.mycoll.reloadData()
            }else {
                self.servicePrice = self.carSizes[1].price
                self.selectedIndex = [0,1]
                self.mycoll.reloadData()

            }
        }
        brandDown.show()
    }
    @IBAction func datePicked(_ sender: Any) {
        let calendarVC = CalendarViewController(dateSelectedBlock: { [weak self] date in
            if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let todaysDate = dateFormatter.string(from: date)
            self!.dateLabel.text = todaysDate
            self!.sendDate = Int(dateFormatter.date(from: todaysDate)!.timeIntervalSince1970)
                self?.dateString = todaysDate
            self!.orderDate = todaysDate
                self!.dateError.isHidden = true
                
            } else {self!.orderDate = nil;self?.dateLabel.text = Localized("iodate")
                          }
                                })
                present(calendarVC, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getMyLocation" {
            let vc = segue.destination as! locationOnMap
            vc.delegate = self
            
        }else if segue.identifier == "afterOrder"{
            let vc = segue.destination as! FinalOrderView
            vc.userid = userid;vc.serviceId = serviceId;vc.subServiceId = subServiceId;vc.carSizeId = carSizeId;vc.carTypeId = carTypeId;vc.Longitude = Longitude;vc.Latitude = Latitude;vc.orderDate = orderDate;vc.tokenWorkTime = tokenWorkTime;vc.Laddress = Laddress;vc.userName = userName;vc.phone = phone;vc.serviceName = serviceName;vc.cartype = cartype;vc.servicePrice = servicePrice;vc.dateString = dateString;vc.services = services;vc.servNames = servNames;vc.brandId = brandId;vc.servicesNames = servicesNames;vc.totalPrice = totalPrice;vc.NCars = "\(count)"
        }
    }
    
    func address(address: String,long:Double,Lat:Double) {
        locationLabel.text = address;Longitude = long;Latitude = Lat;Laddress = address;locationError.isHidden = true
    }
    
}

//MARK: - CollectionView
extension subSubWashMain: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           if carSizes.count != 0 {return carSizes.count}else{return 0}
          }
          
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarSCell", for: indexPath) as! carSizeCell
              if carSizes.count != 0 {
                cell.title.text = carSizes[indexPath.row].title
                cell.image.kf.setImage(with: ImageResource(downloadURL: URL(string:imageURL + carSizes[indexPath.row].image)!))
              }
            if indexPath == selectedIndex {
                       cell.biggerView.layer.borderColor = UIColor(rgb:0xC95E2B).cgColor
                       cell.title.textColor = UIColor(rgb:0xC95E2B)

                   }else{
                       
                       cell.biggerView.layer.borderColor = UIColor.black.cgColor
                       cell.title.textColor = .black
                       cell.isSelected = false
                       
                   }
              return cell
          }
          func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              selectedIndex = indexPath
            collectionView.reloadData()
          }
          
          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (UIScreen.main.bounds.width/2)-5 , height: 150.0 )
              
          }
        
    
    
    
}

//MARK: - TableView
extension subSubWashMain:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subSubview[0]["level3"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "SRVCell", for: indexPath) as! servicesCell
        //cell.ckeck.image = UIImage(named: "B_Unchecked")
        for i in servNames {
            if i ==  subSubview[0]["level3"][indexPath.row]["en_title"].stringValue {
                cell.ckeck.image = UIImage(named: "B_Checked")
            }
        }
        cell.price.text = subSubview[0]["level3"][indexPath.row]["price"].stringValue
        cell.ckeck.tag = indexPath.row
        if Locale.preferredLanguages[0] == "ar" {
            cell.servname.text = subSubview[0]["level3"][indexPath.row]["ar_title"].stringValue
        }else {
            cell.servname.text = subSubview[0]["level3"][indexPath.row]["en_title"].stringValue
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            guard let cartype = carTypeId,!cartype.isEmpty else {
                cartypeError.isHidden = false
                return
            }
            guard let brandtype = brandId,!brandtype.isEmpty else {
                brandtypeError.isHidden = false
                return
            }
        if carSizeId == nil {
            return
        }
        let cell = tableView.cellForRow(at: indexPath) as! servicesCell
        if cell.ckeck.image == UIImage(named:"B_Unchecked"){
            api.getPriceApi(serviceId:subSubview[0]["level3"][indexPath.row]["id"].stringValue,carsizeId: carSizeId!) { (error, result, code) in
                if code == 200{
                    
                    services.append(["sub_service_id":self.subSubview[0]["level3"][indexPath.row]["id"].stringValue,"price":"\(JSON(result!).doubleValue)"])
                    self.tempPrice += JSON(result!).doubleValue
                    self.totalPrice += (JSON(result!).doubleValue * Double(self.count))
                    self.totalPriceLabel.text = "\(self.totalPrice) \(Localized("ryal"))"
                    if Locale.preferredLanguages[0] == "ar" {servicesNames.append(["names":self.subSubview[0]["level3"][indexPath.row]["ar_title"].stringValue])}else{servicesNames.append(["names":self.subSubview[0]["level3"][indexPath.row]["en_title"].stringValue])}
                    if Locale.preferredLanguages[0] == "ar" {
                        servNames.append(self.subSubview[0]["level3"][indexPath.row]["ar_title"].stringValue)
                    }else{
                        servNames.append(self.subSubview[0]["level3"][indexPath.row]["en_title"].stringValue)
                    }
                    cell.ckeck.image = UIImage(named:"B_Checked")
                    
                }else {
                  cell.ckeck.image = UIImage(named:"B_Unchecked")
                }
            }
        }else{
            if services.count != 0 {
                api.getPriceApi(serviceId:subSubview[0]["level3"][indexPath.row]["id"].stringValue,carsizeId: carSizeId!) { (error, result, code) in
                    if code == 200{
                        
                        services.remove(at:services.firstIndex(where:{$0 == ["sub_service_id":self.subSubview[0]["level3"][indexPath.row]["id"].stringValue,"price":"\(JSON(result!).doubleValue)"]})!)
                        if self.totalPrice != 0 {
                            self.tempPrice -= JSON(result!).doubleValue

                            self.totalPrice -= (JSON(result!).doubleValue * Double(self.count))
                            self.totalPriceLabel.text = "\(self.totalPrice) \(Localized("ryal"))"
                        }
                        if Locale.preferredLanguages[0] == "ar" {
                            servNames.remove(at:servNames.firstIndex(where:{$0 == self.subSubview[0]["level3"][indexPath.row]["ar_title"].stringValue})!)
                        }else{
                            servNames.remove(at:servNames.firstIndex(where:{$0 == self.subSubview[0]["level3"][indexPath.row]["en_title"].stringValue})!)
                        }
                        cell.ckeck.image = UIImage(named:"B_Unchecked")
                    }else{
                      cell.ckeck.image = UIImage(named:"B_Checked")
                    }
                }
                
            }

        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
   
    
}
//MARK: - Design&Funcs
extension subSubWashMain {
    func carsizes(){
        if !api.isConnectedToInternet() {
                   alert.alertPopUp(title: Localized("err"), msg: Localized("conMSG"), vc: self)
                   return
        }else {
            ShowActivity(align: mycoll.center, to: mycoll)
            api.carSizes(URL: carSizesUrl) { (error, result, code) in
                if code == 200 {
                    if Locale.preferredLanguages[0] == "ar" {
                    for i in 0..<JSON(result!)["data"].count {
                        self.carSizes.append(allServicesLev2(id: JSON(result!)["data"][i]["id"].stringValue, title: JSON(result!)["data"][i]["ar_title"].stringValue, image: JSON(result!)["data"][i]["image"].stringValue, price:JSON(result!)["data"][i]["price"].stringValue))
                        }
                    }else{
                    for i in 0..<JSON(result!)["data"].count {
                        self.carSizes.append(allServicesLev2(id: JSON(result!)["data"][i]["id"].stringValue, title: JSON(result!)["data"][i]["en_title"].stringValue, image: JSON(result!)["data"][i]["image"].stringValue, price: JSON(result!)["data"][i]["price"].stringValue))
                        }
                        
                    }
                    StopActivity()
                    self.mycoll.reloadData()
            }
            
            
        }
    }
        }
    
    func carstypes(){
        if !api.isConnectedToInternet() {
             alert.alertPopUp(title: Localized("err"), msg: Localized("conMSG"), vc: self)
                       return
            }else {
            acc.startAnimating()
                api.AllCartypesAPI(URL: getCarTypes) { (error, result, code) in
                    if code == 200 {
                        self.cartypesJson = JSON(result!)["data"].arrayValue
                        self.acc.stopAnimating()
 
                }
                
                
            }
        }
        
    }
    func profileData(){
        
    }
    
    func design (){
        aview.layer.borderWidth = 0.5
        aview.layer.cornerRadius = 10.0
        aview.clipsToBounds = true
        aview.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        cartypeView.layer.borderWidth = 0.5
        cartypeView.layer.cornerRadius = 10.0
        cartypeView.clipsToBounds = true
        cartypeView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        brandView.layer.borderWidth = 0.5
        brandView.layer.cornerRadius = 10.0
        brandView.clipsToBounds = true
        brandView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        locationView.layer.borderWidth = 0.5
        locationView.layer.cornerRadius = 10.0
        locationView.clipsToBounds = true
        locationView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        dateView.layer.borderWidth = 0.5
        dateView.layer.cornerRadius = 10.0
        dateView.clipsToBounds = true
        dateView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        timeView.layer.borderWidth = 0.5
        timeView.layer.cornerRadius = 10.0
        timeView.clipsToBounds = true
        timeView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        cartypeView.layer.borderWidth = 0.5
        cartypeView.layer.cornerRadius = 10.0
        cartypeView.clipsToBounds = true
        cartypeView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        cartypeView.layer.borderWidth = 0.5
        cartypeView.layer.cornerRadius = 10.0
        cartypeView.clipsToBounds = true
        cartypeView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        servicesView.layer.borderWidth = 0.5
        servicesView.layer.cornerRadius = 10.0
        servicesView.clipsToBounds = true
        servicesView.layer.borderColor = UIColor(rgb: 0x450638).cgColor
        //
        orderNowButton.layer.cornerRadius = 10.0
        orderNowButton.clipsToBounds = true
        
        
    }
}

//MARK: - Networking
extension subSubWashMain {
    
    private func getSingleService() {
        ShowActivity(align: view.center, to: view)
        api.singleService(service_id: Int(self.serviceId ?? "") ?? 0) { error, result, code in
            StopActivity()
            if code == 200 {
                self.subSubview = JSON(result!)["data"]["level2"].arrayValue
               //JSON(result!)["data"]["level2"][0].arrayValue
                print("⛳️ single count === \(self.subSubview.count)")
                if Locale.preferredLanguages[0] == "ar"{
                    self.serviceName = self.subSubview[0]["ar_title"].stringValue
                    self.moredettext.text = self.subSubview[0]["ar_des"].stringValue
                    self.titleSubs.text = self.subSubview[0]["ar_title"].stringValue
                }else {
                    self.serviceName = self.subSubview[0]["en_title"].stringValue
                    self.moredettext.text = self.subSubview[0]["en_des"].stringValue
                    self.titleSubs.text = self.subSubview[0]["en_title"].stringValue
                }
               // if self.subSubview[0]["level3"].count == 0 {
                self.Pic.kf.setImage(with:ImageResource(downloadURL: URL(string:imageURL + self.subSubview[0]["image"].stringValue)!))
                if self.subSubview.count == 0 {
                    self.servicesView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                }
                DispatchQueue.main.async {
                    self.mytable.reload()
                    self.mytable.heightAnchor.constraint(equalToConstant: self.mytable.contentSize.height).isActive = true
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func alltimes(){
        api.alltimes(URL: alltimesUrl) { (error, result, code) in
            if JSON(result!)["data"].count != 0 {
                for i in 0..<JSON(result!)["data"].count {
                    if JSON(result!)["data"][i]["type"].stringValue == "1" {
                    self.workTimes.append(WorkTimes(id:JSON(result!)["data"][i]["id"].stringValue , title: JSON(result!)["data"][i]["time_text"].stringValue + " AM", type: JSON(result!)["data"][i]["type"].stringValue))
                }else{
                    self.workTimes.append(WorkTimes(id:JSON(result!)["data"][i]["id"].stringValue , title: JSON(result!)["data"][i]["time_text"].stringValue + " PM", type: JSON(result!)["data"][i]["type"].stringValue))
    }}}}}
    
    private func getPlacesAPI() {
        ShowActivity(align: view.center, to: view)
        api.baseGet(url: placesURL) { error, result, code in
            StopActivity()
            if code == 200 {
                self.placesData = JSON(result!)["data"].arrayValue
    }}}
    
    
}
