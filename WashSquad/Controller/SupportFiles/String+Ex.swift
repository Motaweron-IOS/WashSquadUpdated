//
//  String+Ex.swift
//  Sokyakom
//
//  Created by Ghoost on 10/4/20.
//

import Foundation

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
    
    var isValidPhone: Bool {
        let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: self)
    }
    
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func toDate(format: String)-> Date?{
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "en_US_POSIX")
           dateFormatter.dateFormat = format
           let date = dateFormatter.date(from: self)
           return date

       }
    
    func hasRange(_ range: NSRange) -> Bool {
        return Range(range, in: self) != nil
    }
    
}
extension Data {
var html2AttributedString: NSAttributedString? {
    do {
        return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    } catch {
        print("error:", error)
        return  nil
}}}
extension String {
    func getFormattedDat(fromFormatter:String, toFormat:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = fromFormatter
        dateFormatterGet.timeZone = TimeZone(identifier: "UTC")
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = toFormat
        dateFormatterPrint.timeZone = TimeZone.current
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")

        let date: Date? = dateFormatterGet.date(from: self)
        return dateFormatterPrint.string(from: date!);
    }
    
}
//public extension String {
//    
//    public var replacedArabicDigitsWithEnglish: String {
//        var str = self
//        let map = ["٠": "0",
//                   "١": "1",
//                   "٢": "2",
//                   "٣": "3",
//                   "٤": "4",
//                   "٥": "5",
//                   "٦": "6",
//                   "٧": "7",
//                   "٨": "8",
//                   "٩": "9"]
//        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
//        return str
//    }
//}
