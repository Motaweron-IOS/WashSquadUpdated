//
//  repeatedQuestions.swift
//  WashSquad
//
//  Created by Eslam Moemen on 11/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON

class repeatedQuestions: UITableViewController {
    var data = [JSON]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if !api.isConnectedToInternet() {
           showErrorWithStatus(Localized("connMSG"))
           return
        }else {
            api.getQustions { (error, result, code) in
                if code == 200 {
                    self.data = JSON(result!)["data"].arrayValue
                    self.tableView.reloadData()
                }else {
                    showErrorWithStatus(Localized("errll"))
                }
            }
        }

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questIdent", for: indexPath) as! repeatedQuestionsCell
        if data.count != 0 {
            if Locale.preferredLanguages[0] == "ar"{
                cell.questTitle.text = data[indexPath.row]["ar_title"].stringValue
                cell.answer.text = data[indexPath.row]["ar_content"].stringValue
            }else{
                cell.questTitle.text = data[indexPath.row]["en_title"].stringValue
                cell.answer.text = data[indexPath.row]["en_content"].stringValue
            }
        }
        
        return cell
    }
    
    

    

}

class repeatedQuestionsCell:UITableViewCell {
    
    @IBOutlet var questTitle: UILabel!
    @IBOutlet var answer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
