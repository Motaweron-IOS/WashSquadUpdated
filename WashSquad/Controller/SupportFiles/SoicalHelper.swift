//
//  SoicalHelper.swift
//  MvvmRxSwiftProOne
//
//  Created by Ghoost on 9/11/20.
//  Copyright © 2020 Khalij. All rights reserved.
//

import UIKit

class SocialHelper: NSObject {

    private override init() {}
    
    static let shared = SocialHelper()
    
     func openWhatsapp(phone:String) {
        let appURL = NSURL(string: "https://api.whatsapp.com/send?phone=\(phone)")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            }else {
                UIApplication.shared.openURL(appURL as URL)
            }}else {
            // Whatsapp is not installed
    }}
    
     func openFacebook(facebook: String) {
        let appURL = URL(string: "fb://profile/\(facebook)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://facebook.com/\(facebook)")!
            application.open(webURL)
    }}
    
     func openEmail(email:String) {
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
    
     func openTwitter(twitter:String) {
//        let appURL = NSURL(string: "twitter:///user?screen_name=\(twitter)")!
//        let webURL = NSURL(string: "https://twitter.com/\(twitter)")!
        let appURL = NSURL(string: twitter)!
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            }else {
                UIApplication.shared.openURL(appURL as URL)
            }}else {
          //  UIApplication.shared.open(webURL as URL)
                UIApplication.shared.open(appURL as URL)

        }}
    
     func openInstagram(instgram:String) {
       // let appURL = URL(string: "instagram://user?username=\(instgram)")!
        let appURL = URL(string: instgram)!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
                //let webURL = URL(string: "https://instagram.com/\(instgram)")!
            let webURL = URL(string: instgram)!
            application.open(webURL)
        }}
    
     func openCalling(phone:String) {
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }}
    
     func openSnapChat(snapName:String) {
        //let appURL = URL(string: "snapchat://add/\(snapName)")!
        let appURL = URL(string: snapName)!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            //let webURL = URL(string: "https://www.snapchat.com/add/\(snapName)")!
            let webURL = URL(string: snapName)!
            application.open(webURL)
        }
    }
    
     func openYoutube(YoutubeUser:String) {
        let YoutubeUser =  "Your Username"
        let appURL = NSURL(string: "youtube://www.youtube.com/user/\(YoutubeUser)")!
        let webURL = NSURL(string: "https://www.youtube.com/user/\(YoutubeUser)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    
    
    
}
