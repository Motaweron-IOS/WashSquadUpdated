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
import CoreData

//class sesem:NSObject {
//    class var StatusActivity:Bool{
//           get {UIApplication.shared.isNetworkActivityIndicatorVisible}set {UIApplication.shared.isNetworkActivityIndicatorVisible = newValue}}
//}

class alert {
 
   class func alertPopUp(title: String, msg: String , vc: UIViewController) {
//    let myString  = title
//    let message  = msg

    let alert = UIAlertController(title: title , message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localized("ok"), style: .default, handler: nil))
    
//    var myMutableString = NSMutableAttributedString()
//    myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "GE SS Two", size: 17.0)!])
//    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:myString.count))
//    alert.setValue(myMutableString, forKey: "attributedTitle")
//
//    var messageMutableString = NSMutableAttributedString()
//    messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font:UIFont(name: "GE SS Two", size: 15.0)!])
//    messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:message.count))
//    alert.setValue(messageMutableString, forKey: "attributedMessage")


    
    
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func registerAlert(v: UIViewController){
        
        let alertController = UIAlertController(title:Localized("err"), message: Localized("reg"), preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localized("regBut"), style: UIAlertAction.Style.default) {
            UIAlertAction in
            let vc = v.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! login
            v.present(vc, animated: true, completion: nil)
            
            
        }
        
        alertController.addAction(okAction)
        alertController.addAction(UIAlertAction(title: Localized("cann"), style: .cancel, handler: nil))
        v.present(alertController, animated: true, completion: nil)
        
    
        }
    
    
  
}
struct validaton {
    
    
    
   static func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
   static func validatephone(value: String) -> Bool {
    let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
    //"^((?:[+?0?0?966]+)(?:\s?\d{2})(?:\s?\d{7}))$"

    
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
   static func isPasswordSame(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    
    
    
    
    
    
}

class support: NSObject {
    class var AppLangDefaultEnglish:Void{
        if def.string(forKey: "#CL") == nil {
            def.set(["en"], forKey: "AppleLanguages")
            def.synchronize()
            def.set(Locale.preferredLanguages[0], forKey: "#CL")
        }
    }

    class var deleteAllData:Void {
          UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
    }
    
    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        if checkUserId == false {
            vc = sb.instantiateInitialViewController()!
        } else {
            vc = sb.instantiateViewController(withIdentifier: "main")
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .curveLinear, animations: nil, completion: nil)
    }
    
   
    class func saveUserId(token: String) {
        def.set(token, forKey: "user_id")
        def.synchronize()
    }
    
    class func saveUserType(type:String){
        def.set(type, forKey: "userType")
        def.synchronize()
    }
    
    class var getUserType:String{
        get{
          return (def.object(forKey: "userType") as! String)
        }
    }
    class var checkUserId:Bool{
        get{
          return (def.object(forKey: "user_id") as? String) != nil
        }
    }
   

    class var getuserId:String {
        get{
         return (def.object(forKey: "user_id") as! String)
        }
    }
    
    
    
    class func deletUserDefaults() {
        def.removeObject(forKey: "user_id")
        UserDefaults.standard.synchronize()
        restartApp()
        
    }
    
    
    
    class func hudStart() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(UIColor.white)           //Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)        //HUD Color
        SVProgressHUD.setRingThickness(3.0)
        //SVProgressHUD.setBackgroundLayerColor(UIColor.green)    //Background Color
        SVProgressHUD.show()
    }
    
    
    class func showSuccess(title:String){
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(.init(white: 0.0, alpha: 0.5))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.show(UIImage(named: "done.png")!, status: title)
        SVProgressHUD.setShouldTintImages(false)
        SVProgressHUD.setImageViewSize(CGSize(width: 50, height: 50))
        SVProgressHUD.setFont(appFont())
        SVProgressHUD.dismiss(withDelay: 1.5)
        
    }
    

    
    class func showError(title:String) {
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(.init(white: 0.0, alpha: 0.5))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.show(UIImage(named: "cancel.png")!, status: title)
        SVProgressHUD.setShouldTintImages(false)
        SVProgressHUD.setImageViewSize(CGSize(width: 50, height: 50))
        SVProgressHUD.setFont(appFont())
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
    
    class func statusBar(UIColor: UIColor) {
        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {return}
        statusBarView.backgroundColor = UIColor
        //.withAlphaComponent(0.87)
    }
     
    class func EmptyMessage(message:String, viewController:UITableViewController) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center
        messageLabel.font = appFont()
        messageLabel.sizeToFit()
        
        viewController.tableView.backgroundView = messageLabel;
    }
    class func currentDate () -> String{
    
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        
            return result
    }
    
    
    
}
class uploadPhoto:UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var currentImageView:UIImageView?
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        }
    }
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func uplaodTapped (){
        let alert = UIAlertController(title:Localized("upldpho"), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title:Localized("cm"), style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title:Localized("glry"), style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title:Localized("cann"), style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

@IBDesignable
   extension UIView {
     
       // MARK: - Border
    
       @IBInspectable public var borderColor:UIColor {
           set{
            layer.borderColor = newValue.cgColor
           }get{
            return UIColor(cgColor:layer.borderColor!)
           }
       }
       
       @IBInspectable var borderWidth: CGFloat {
           set{
               layer.borderWidth = newValue
           }get{
               return layer.borderWidth
           }
       }
       
       @IBInspectable public var cornerRadius: CGFloat {
           set {
               layer.cornerRadius = newValue
           }get{
               return layer.cornerRadius
           }
       }
       
       // MARK: - Shadow
       
       @IBInspectable public var shadowOpacity: CGFloat {
           set {
               layer.shadowOpacity = Float(newValue)
           }get{
               return CGFloat(layer.shadowOpacity)
           }
       }
       
       @IBInspectable public var shadowColor: UIColor{
           set{
               layer.shadowColor = newValue.cgColor
           }get{
               return UIColor(cgColor: layer.shadowColor!)
           }
       }
       
       @IBInspectable public var shadowRadius: CGFloat {
           set{
               layer.shadowRadius = newValue
           }get{
               return layer.shadowRadius
           }
       }
       
       @IBInspectable public var shadowOffset: CGSize {
           set{
               layer.shadowOffset = newValue
           }get{
              return layer.shadowOffset
           }
       }
   }



//MARK:-############################################################################################################################################################

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
func dateToTimeStamp(Date:Date)->String {
    return String(Date.timeIntervalSince1970)
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
 SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
 SVProgressHUD.setBackgroundColor(.clear)
 SVProgressHUD.setForegroundColor(.white)
 SVProgressHUD.setDefaultMaskType(.black)
 SVProgressHUD.showInfo(withStatus: Status)
SVProgressHUD.dismiss(withDelay: 2.5)

    }

func showSuccessWithStatus(_ Status:String) {
SVProgressHUD.setDefaultStyle(.dark)
// SVProgressHUD.setDefaultAnimationType(.native)
 SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
 SVProgressHUD.setBackgroundColor(.clear)
 SVProgressHUD.setForegroundColor(.white)
 SVProgressHUD.setDefaultMaskType(.black)
 SVProgressHUD.showSuccess(withStatus: Status)
SVProgressHUD.dismiss(withDelay: 2.5)

    }


func showErrorWithStatus(_ Status:String) {
    SVProgressHUD.setDefaultStyle(.dark)
    // SVProgressHUD.setDefaultAnimationType(.native)
     SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
     SVProgressHUD.setBackgroundColor(.clear)
     SVProgressHUD.setForegroundColor(.white)
     SVProgressHUD.setDefaultMaskType(.black)
     SVProgressHUD.showError(withStatus: Status)
    SVProgressHUD.dismiss(withDelay: 2.5)
    
        }
func appFont()-> UIFont {
    return UIFont(name: "cairo", size: 20.0)!
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
    //"dd MMM YY, hh:mm a"
    dayTimePeriodFormatter.dateFormat = "dd MMM YY"
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
extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
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
        emptyImage.heightAnchor.constraint(equalToConstant: 20),
        emptyImage.widthAnchor.constraint(equalToConstant: 20)
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


extension String {
 var replacedArabicDigitsWithEnglish: String {
    var str = self
    let map = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
    return str  }
}


