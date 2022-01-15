//
//  apiDataModel.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/2/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation
import UIKit

struct allServices {
    var id:String,title:String,image:String
    init(id:String,title:String,image:String) {
        self.id = id;self.title = title;self.image = image
    }
}
struct allServicesLev2 {
    var id:String,title:String,image:String,price:String
    init(id:String,title:String,image:String,price:String) {
        self.id = id;self.title = title;self.image = image;self.price = price
    }
}
struct cartypes {
    var id:String,title:String
    init(id:String,title:String) {
        self.id = id;self.title = title
    }
}

struct brand {
    var id:String,title:String,size:String
    init(id:String,title:String,size:String) {
        self.id = id;self.title = title;self.size = size
    }
}
struct WorkTimes {
    var id:String,title:String,type:String
    init(id:String,title:String,type:String) {
        self.id = id;self.title = title;self.type = type
    }
}

struct FRDData {
    var userId:String,serviceId:String,carSizeId:String,carTypeId:String,longitude:String,latitude:String,address:String,orderDate:String,orderTimeId:String,numberOfCars:String,totalPrice:String,subServices:[[String:Any]],userName:String,userPhone:String,carTypeName:String,serviceTypeName:String,servicePrice:String,ServicesNames:[String],Payment:String,subServiceId:String,paymentId:String,brandId:String,couponSerial:String
init(userId:String,serviceId:String,carSizeId:String,carTypeId:String,longitude:String,latitude:String,address:String,orderDate:String,orderTimeId:String,numberOfCars:String,totalPrice:String,subServices:[[String:Any]],userName:String,userPhone:String,carTypeName:String,serviceTypeName:String,servicePrice:String,ServicesNames:[String],Payment:String,subServiceId:String,paymentId:String,brandId:String,couponSerial:String) {
    self.userId = userId;self.serviceId = serviceId;self.carSizeId = carSizeId;self.carTypeId = carTypeId;self.longitude = longitude;self.latitude = latitude;self.address = address;self.orderDate = orderDate;self.orderTimeId = orderTimeId;self.numberOfCars = numberOfCars;self.totalPrice = totalPrice;self.subServices = subServices;self.userName = userName;self.userPhone = userPhone;self.carTypeName = carTypeName;self.serviceTypeName = serviceTypeName;self.servicePrice = servicePrice;self.ServicesNames = ServicesNames;self.Payment = Payment;self.subServiceId = subServiceId;self.paymentId = paymentId;self.brandId = brandId;self.couponSerial = couponSerial
}
}





