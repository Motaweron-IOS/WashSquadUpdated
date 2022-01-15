//
//  terms.swift
//  WashSquad
//
//  Created by Eslam Moemen on 11/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON

class terms: UIViewController {
    
    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if !api.isConnectedToInternet() {
               showErrorWithStatus(Localized("connMSG"))
               return
            }else {
                api.getTerms { (error, result, code) in
                    if code == 200 {
                        if Locale.preferredLanguages[0] == "ar"{
                        self.textView.text = JSON(result!)["data"]["conditions"]["ar_content"].stringValue
                            self.navigationItem.title = JSON(result!)["data"]["conditions"]["ar_title"].stringValue
                        }else {
                            self.textView.text = JSON(result!)["data"]["conditions"]["en_content"].stringValue
                            self.navigationItem.title = JSON(result!)["data"]["conditions"]["en_title"].stringValue
                        }
                    }else {
                        showErrorWithStatus(Localized("errll"))
                    }
                }
            }

        }
        

    }
    



