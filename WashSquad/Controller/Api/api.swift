//
//  APIs.swift
//  HandBreak
//
//  Created by Ghoost on 7/18/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class api: NSObject {
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    class func login(URL:String,phone:String,PhoneCode:String,Pass:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["phone":phone,"phone_code":PhoneCode,"password":Pass]
        Alamofire.request(URL, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
            print(response)
            
        }
    }
    
    class func visit(URL:String,date:String,softType:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["software_type":softType,"date":date]
        Alamofire.request(URL, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
            
            
        }
    }
    
    class func register(URL:String,username:String,phone:String,PhoneCode:String,Pass:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["phone":phone,"phone_code":PhoneCode,"password":Pass,"full_name":username,"software_type":"2"]
        Alamofire.request(URL, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
            
        }
    }
    class func validateCode(URL:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["user_id":def.string(forKey:"tempID")!]
        Alamofire.request(URL, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
            
        }
    }
    class func confirmCode(URL:String,code:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["user_id":def.string(forKey:"tempID")!,"code":code]
        Alamofire.request(URL, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
            
        }
    }
    
    class func allServices(URL:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        Alamofire.request(URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
        }
    }
    class func carSizes(URL:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        Alamofire.request(URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
        }
    }
    
    
    
    class func updateProfile(targetURL:String,name:String,pass:String,logo:UIImage,completion : @escaping (_ error:Error?,_ result:Any?,_ code:Int? ) -> Void){
        
        let par : [String:Any] = ["user_id":support.getuserId,"full_name":name,"password":pass]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in par {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if logo.size.width != 0 {
                multipartFormData.append(logo.jpegData(compressionQuality: 0.6)!, withName: "logo", fileName: "user_image.jpeg", mimeType: "image/jpeg")
            }
            
        },// usingThreshold:UInt64.init(),
            to: targetURL,
            method: .post,
            headers: nil,
            encodingCompletion:{ result in
                switch result {
                case .success(let upload, _, _):
                upload.validate(statusCode: 200..<600).responseJSON { response in
                completion(response.result.error,response.result.value,response.response?.statusCode)
                    }
                case .failure(let encodingError):
                    print("the error is  : \(encodingError.localizedDescription)")
                    break
                }
            })
        
        
        
        
    }
    
    class func AllOffersApi(URL:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        Alamofire.request(URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
        }
    }
    
    class func AllCartypesAPI(URL:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
           Alamofire.request(URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
               completion(response.result.error,response.result.value,response.response?.statusCode)
           }
       }
    
    class func alltimes(URL:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        Alamofire.request(URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
        }
    }
    class func coupon(URL:String,serial:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["user_id":support.getuserId,"coupon_serial":serial]
        Alamofire.request(URL, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
        }
    }
    class func MakeOrderApi(serviceId:String,subServiceId:String,carSizeId:String,brandId:String,cartypeId:String,logitude:String,latitude:String,address:String,orderDate:String,orderTimeId:String,numberOfCars:String,paymentId:String,totalPrice:String,couponSerial:String,services:[[String:Any]],completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para:[String:Any] = ["user_id":support.getuserId,"service_id":serviceId,"sub_serv_id":subServiceId,"carSize_id":carSizeId,"brand_id":brandId,"carType_id":cartypeId,"longitude":logitude,"latitude":latitude,"address":address,"order_date":orderDate,"order_time_id":orderTimeId,"number_of_cars":numberOfCars,"payment_method":paymentId,"total_price":totalPrice,"coupon_serial":couponSerial,"sub_services":services]
        
        Alamofire.request(makeOrderUrl, method: .post, parameters: para, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            
            completion(response.result.error,response.result.value,response.response?.statusCode)
        }
    }
    
    class func myOrders(page:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["user_id":support.getuserId,"page":page]
           Alamofire.request(getMyOrdersUrl, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            print(response)
               completion(response.result.error,response.result.value,response.response?.statusCode)
           }
       }
    
    class func rateSender(orderId:String,rateVal:String,opinion:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
           let para = ["order_id":orderId,"rating":rateVal,"opinion_des":opinion]
              Alamofire.request(orderRating, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
                  completion(response.result.error,response.result.value,response.response?.statusCode)
                print(response)
              }
          }
    class func getQustions(completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
                 Alamofire.request(questionsUrrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
                     completion(response.result.error,response.result.value,response.response?.statusCode)
                 }
             }
    class func getTerms(completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        Alamofire.request(termsUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            print(response)
            completion(response.result.error,response.result.value,response.response?.statusCode)
        }
    }
    class func Logout(URL:String,userId:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["user_id":userId]
        Alamofire.request(URL, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
            
            
        }
    }
    class func contactUs(name:String,email:String,subject:String,message:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["name":name,"email":email,"subject":subject,"message":message]
        Alamofire.request(contactUrl, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
            
            
        }
    }
    class func getPriceApi(serviceId:String,carsizeId:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
           let para = ["service_id":serviceId,"size_id":carsizeId]
              Alamofire.request(getPriceUrl, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
                  completion(response.result.error,response.result.value,response.response?.statusCode)
              }
          }
    
    class func changePasswordApi(id:String,newPass:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        let para = ["user_id":id,"new_pass":newPass]
           Alamofire.request(passwordChangeUrl, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            print(response)
               completion(response.result.error,response.result.value,response.response?.statusCode)
           }
       }
    class func forgetPassword(code:String,phone:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
     let para = ["phone_code":code,"phone":phone]
        Alamofire.request(frogetPassUrl, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            print(response)
            completion(response.result.error,response.result.value,response.response?.statusCode)
        }
    }
    
       
    
    class func userSubscription(URL:String,completion: @escaping(_ error:Error?,_ result:Any?,_ code:Int?)->Void) {
        Alamofire.request(URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON { (response) in
            completion(response.result.error,response.result.value,response.response?.statusCode)
        }
    }
    

}
