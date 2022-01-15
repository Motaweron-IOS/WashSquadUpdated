//
//  InfoSection.swift
//  WashSquad
//
//  Created by Eslam Moemen on 11/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import DropDown

class InfoSection: UIViewController {
    let dropDown = DropDown()
    var lng:String?
    var langs = ["English","العربية"]
    var langscode = ["en","ar"]
    @IBOutlet var langButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.setupCornerRadius(10)
        dropDown.textFont = UIFont(name: "cairo", size: 17.0)!
        self.dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .center}
        def.set(Locale.preferredLanguages[0], forKey: "#CL")

    }
    
    @IBAction func dismisal(_ sender: Any) {
        dismiss(animated: true)
    }
    
   @IBAction func retpTapped(_ sender: Any) {
        performSegue(withIdentifier: "repQesty", sender: self)
    
    }
    
    @IBAction func termsAndConditions(_ sender: Any) {
        performSegue(withIdentifier: "termsAndConditions", sender: self)
    
    }
    @IBAction func contact(_ sender: Any) {
        performSegue(withIdentifier: "contactUs", sender: self)
    
    }
    @IBAction func langChoose(_ sender: Any) {
       
        dropDown.anchorView = langButton
        dropDown.dataSource = langs
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "English"{self.lng = "en"}else {self.lng = "ar"}
            if Locale.preferredLanguages[0] != self.lng! {
            self.showAlert()
            }
        }
        dropDown.show()
    }

    func showAlert(){
        
        let alert = UIAlertController(title: Localized("AppRes"), message:Localized("resEn"), preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Localized("AppRes"), style: .default , handler:{ (UIAlertAction)in
            def.set(self.lng!, forKey: "#CL")
            if self.lng == "en" {UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()}else{UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()}
           exit(-1)
            }))
        alert.addAction(UIAlertAction(title: Localized("cann"), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}



