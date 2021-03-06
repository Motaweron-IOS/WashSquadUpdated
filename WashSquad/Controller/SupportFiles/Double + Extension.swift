//
//  Double + Extension.swift
//  Shell kom
//
//  Created by mahmoudhajar on 3/12/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation


/*
 
 let timeStamp = 82749029.0
 print(timeStamp. dateFormatted)
 //output
 //12/11/1994
 
 let timeStamp = 82749029.0
 print(timeStamp. dateFormatted(withFormat : "MM-dd-yyyy HH:mm"))
 output
 12-11-1994 13:04
 
 */


extension Double {
    
    
    // returns the date formatted.
    var dateFormatted : String? {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
        return dateFormatter.string(from: date)
    }
    
    // returns the date formatted according to the format string provided.
    func dateFormatted(withFormat format : String) -> String{
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    
    
    func rounded(digits: Int) -> Double {
          let multiplier = pow(10.0, Double(digits))
          return (self * multiplier).rounded() / multiplier
      }
    
    
    func roundToNf(n : Int) -> NSString
    {
        return NSString(format: "%.\(n)f" as NSString, self)
    }
    
    func getDateStringFromGTM() -> String {
            let date = Date(timeIntervalSince1970: self)

            let dateFormatter = DateFormatter()
               dateFormatter.locale = Locale(identifier: "en_US")
               dateFormatter.timeStyle = .medium
               dateFormatter.timeZone = TimeZone(identifier: "GMT")
               dateFormatter.dateFormat = "hh:mm"
            return dateFormatter.string(from: date)
        }
    
    func multipleThousand() -> Double {
        return self * 1000
    }
    
    func dividerThousand() -> Double{
        return self / 1000
    }
    
}
