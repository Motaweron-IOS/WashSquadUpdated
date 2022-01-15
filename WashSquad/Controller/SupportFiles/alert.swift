//
//  Alert.swift
//  Iris
//
//  Created by mahmoudhajar on 2/6/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation
import UIKit


class alert {
 
   class func alertPopUp(title: String, msg: String , vc: UIViewController) {
//    let myString  = title
//    let message  = msg

    let alert = UIAlertController(title: title , message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localized("done"), style: .default, handler: nil))
    
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
        let okAction = UIAlertAction(title: Localized("regBut"), style: UIAlertAction.Style.default) { UIAlertAction in
//            let vc = v.storyboard?.instantiateViewController(withIdentifier: "loginVc") as! login
//            v.present(vc, animated: true, completion: nil)
            
            
        }
        
        alertController.addAction(okAction)
        alertController.addAction(UIAlertAction(title: Localized("cann"), style: .cancel, handler: nil))
        v.present(alertController, animated: true, completion: nil)
        
    
        }
  
}
