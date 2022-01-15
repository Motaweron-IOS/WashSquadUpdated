//
//  repeatedStaff.swift
//  HandBreak
//
//  Created by Eslam Moemen on 7/20/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

func textFeildCornerraduis(textFeild: UITextField){
    textFeild.layer.cornerRadius = 10.0
    textFeild.clipsToBounds = true
    
}
let def = UserDefaults.standard
let noti = NotificationCenter.default

func buttonCornerraduis(Button: UIButton){
    Button.layer.cornerRadius = 10.0
    Button.clipsToBounds = true
    
}

let acc = UIActivityIndicatorView()

func ShowActivity (align:CGPoint,to:UIView){
    
    acc.hidesWhenStopped = true
    acc.center = align
    acc.style = .gray
    acc.alpha = 0.5
    to.addSubview(acc)
    acc.startAnimating()
}

func StopActivity(){
    acc.stopAnimating()
}




func viewCornerraduis(view: UIView){
    view.layer.cornerRadius = 10.0
    view.clipsToBounds = true
    
}



//func ShowMBProgressHUDWithStatus(ParentView:UIView,withMessage:String){
//    let hud = MBProgressHUD.showAdded(to: ParentView, animated: true)
//    hud.show(animated: true)
//    hud.mode = MBProgressHUDMode.indeterminate
//    hud.label.text = withMessage
//    hud.bezelView.style = .solidColor
//    //hud.bezelView.setRoundCorners(radius: 10.0)
//    //hud.bezelView.color = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
//    hud.sizeThatFits(CGSize(width: 5, height: 5))
//    hud.bezelView.color = UIColor.clear
//    hud.isUserInteractionEnabled = true
//    hud.contentColor = UIColor(displayP3Red: 222/255, green: 18/255, blue: 12/255, alpha: 1.0)
//    hud.animationType = .zoomIn
//
//}
func noArabicNumbers(SS:String)-> Bool{
       return SS.rangeOfCharacter(from: CharacterSet(charactersIn: "١٢٣٤٥٦٧٨٩٠")) == nil
    }

func noFooter(table:UITableView){
    table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: table.frame.size.width, height: 1))
}


//func dismissMBProgressHUD(parentView:UIView){
//    MBProgressHUD.hide(for: parentView, animated: true)
//
//}


func showInfoWithStatus(_ Status:String) {
    SVProgressHUD.setDefaultStyle(.dark)
    // SVProgressHUD.setDefaultAnimationType(.native)
     SVProgressHUD.setFont(UIFont.systemFont(ofSize: 12.0))
     SVProgressHUD.setBackgroundColor(.clear)
     SVProgressHUD.setForegroundColor(.white)
     SVProgressHUD.setDefaultMaskType(.black)
     SVProgressHUD.showInfo(withStatus: Status)
    SVProgressHUD.dismiss(withDelay: 2.5)
    
        }
func appFont()-> UIFont {
    return UIFont(name: "cairo", size: 17.0)!
}
func UserDefaultSetter(Value:Any,Key:String){
    
    UserDefaults.standard.set(Value, forKey: Key)
    
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

func time_as_string(timeStamp : Double) -> String {
    
    let date = NSDate(timeIntervalSince1970: timeStamp)
    
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"
    // UnComment below to get only time
    //  dayTimePeriodFormatter.dateFormat = "hh:mm a"
    
    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}


func showSvProgressHUDwithStatus(_ message:String?){
    SVProgressHUD.setDefaultStyle(.dark)
   // SVProgressHUD.setDefaultAnimationType(.native)
    SVProgressHUD.setFont(UIFont.systemFont(ofSize: 12.0))
    SVProgressHUD.setBackgroundColor(.clear)
    SVProgressHUD.setForegroundColor(.white)
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show(withStatus: message ?? NSLocalizedString("sv", comment: ""))
    SVProgressHUD.setRingRadius(CGFloat(17.0))
    }

func dismissSvProgressHUD(){SVProgressHUD.dismiss()}


func Localized(_ Key:String)-> String{
    return NSLocalizedString(Key, comment: "")
}
func collectiobFitwidth (_ SS:String)-> CGSize{
    let label = UILabel(frame: CGRect.zero)
    label.text = SS
    label.sizeToFit()
    return CGSize(width: label.frame.width, height: 30)
}
func collectiobFitHeight(_ SS:String,width:CGFloat)-> CGSize{
    let label = UILabel(frame: CGRect.zero)
    label.text = SS
    label.sizeToFit()
    return CGSize(width: width, height: label.frame.width)
}
func ArabicNumReplacement(TF:UITextField,SS:String)->Bool {
    if TF.keyboardType == .numberPad && SS != "" {
        let numberStr: String = SS
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = Locale(identifier: "EN")
        if let final = formatter.number(from: numberStr) {
            TF.text =  "\(TF.text ?? "")\(final)"
        }
            return false
    }
    return true
}





extension UIViewController{
    
    func setTitle(_ title: String, andImage image: UIImage) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont(name: "GE SS Two", size: 20)!
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let titleView = UIStackView(arrangedSubviews: [imageView, titleLbl])
        titleView.axis = .horizontal
       // titleView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        titleView.spacing = 10.0
        navigationItem.titleView = titleView
    }
    
    
    
    
}

extension UIStackView {
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}
func emptyCollection(_ table:UICollectionView){
    let emptyImage = UIImageView(image: UIImage(named: "empty-cart"))
    emptyImage.translatesAutoresizingMaskIntoConstraints = false //missed it in first place
    table.backgroundView = emptyImage
    NSLayoutConstraint.activate([
        emptyImage.centerXAnchor.constraint(equalTo: table.centerXAnchor),
        emptyImage.centerYAnchor.constraint(equalTo: table.centerYAnchor),
        emptyImage.heightAnchor.constraint(equalToConstant: 150),
        emptyImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    table.isScrollEnabled = false
}


    func emptytable(_ table:UITableView){
    let emptyImage = UIImageView(image: UIImage(named: "empty-cart"))
    emptyImage.translatesAutoresizingMaskIntoConstraints = false //missed it in first place
    table.backgroundView = emptyImage
    NSLayoutConstraint.activate([
        emptyImage.centerXAnchor.constraint(equalTo: table.centerXAnchor),
        emptyImage.centerYAnchor.constraint(equalTo: table.centerYAnchor),
        emptyImage.heightAnchor.constraint(equalToConstant: 150),
        emptyImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    table.isScrollEnabled = false
    }

 func Noemptytable(_ table:UITableView){
    table.backgroundView = nil
    table.isScrollEnabled = true
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
    
    extension UIView {

      // OUTPUT 1
      func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }

      // OUTPUT 2
      func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    }

extension UIViewController {
    
    
    
}
extension String {
 var replacedArabicDigitsWithEnglish: String {
    var str = self
    let map = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
    return str  }
}
extension api {
    class var setter:Bool{
        return true
    }
}

