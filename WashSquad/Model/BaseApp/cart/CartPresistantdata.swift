//
//  CartPresistantdata.swift
//  WashSquad
//
//  Created by Eslam Moemen on 11/23/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation
import UIKit
import CoreData



  
    func saveUserData(_ users: [FRDData]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        for user in users {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "CartModel", into: context)
            newUser.setValue(user.userId, forKey: "userid")
            newUser.setValue(user.serviceId, forKey: "serviceId")
            newUser.setValue(user.carSizeId, forKey: "carSizeId")
            newUser.setValue(user.carTypeId, forKey: "carTypeId")
            newUser.setValue(user.longitude, forKey: "longitude")
            newUser.setValue(user.latitude, forKey: "latitude")
            newUser.setValue(user.address, forKey: "address")
            newUser.setValue(user.orderDate, forKey: "orderDate")
            newUser.setValue(user.orderTimeId, forKey: "orderTimeId")
            newUser.setValue(user.numberOfCars, forKey: "numberOfCars")
            newUser.setValue(user.totalPrice, forKey: "totalPrice")
            newUser.setValue(user.subServices, forKey: "subServices")
            newUser.setValue(user.userName, forKey: "userName")
            newUser.setValue(user.userPhone, forKey: "userPhone")
            newUser.setValue(user.carTypeName, forKey: "carTypeName")
            newUser.setValue(user.serviceTypeName, forKey: "serviceTypeName")
            newUser.setValue(user.servicePrice, forKey: "servicePrice")
            newUser.setValue(user.ServicesNames, forKey: "servicesNames")
            newUser.setValue(user.Payment, forKey: "payment")
            newUser.setValue(user.subServiceId, forKey: "subServiceId")
            newUser.setValue(user.paymentId, forKey: "paymentId")
            newUser.setValue(user.brandId, forKey: "brandId")
            newUser.setValue(user.couponSerial, forKey: "couponSerial")
            
        }
        do {
            try context.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func retrieveSavedUsers() -> [FRDData]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CartModel")
        request.returnsObjectsAsFaults = false
        var retrievedUsers: [FRDData] = []
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    guard let userid = result.value(forKey: "userid") as? String else { return nil }
                    guard let serviceId = result.value(forKey: "serviceId") as? String else { return nil }
                    guard let carSizeId = result.value(forKey: "carSizeId") as? String else { return nil }
                    guard let carTypeId = result.value(forKey: "carTypeId") as? String else { return nil }
                    guard let longitude = result.value(forKey: "longitude") as? String else { return nil }
                    guard let latitude = result.value(forKey: "latitude") as? String else { return nil }
                    guard let address = result.value(forKey: "address") as? String else { return nil }
                    guard let orderDate = result.value(forKey: "orderDate") as? String else { return nil }
                    guard let orderTimeId = result.value(forKey: "orderTimeId") as? String else { return nil }
                    guard let numberOfCars = result.value(forKey: "numberOfCars") as? String else { return nil }
                    guard let totalPrice = result.value(forKey: "totalPrice") as? String else { return nil }
                    guard let subServices = result.value(forKey: "subServices") as? [[String:Any]] else { return nil }
                    guard let userName = result.value(forKey: "userName") as? String else { return nil }
                    guard let userPhone = result.value(forKey: "userPhone") as? String else { return nil }
                    guard let carTypeName = result.value(forKey: "carTypeName") as? String else { return nil }
                    guard let serviceTypeName = result.value(forKey: "serviceTypeName") as? String else { return nil }
                    guard let servicePrice = result.value(forKey: "servicePrice") as? String else { return nil }
                    guard let ServicesNames = result.value(forKey: "servicesNames") as? [String] else { return nil }
                    guard let Payment = result.value(forKey: "payment") as? String else { return nil }
                    guard let subServiceId = result.value(forKey: "subServiceId") as? String else { return nil }
                    guard let paymentId = result.value(forKey: "paymentId") as? String else { return nil }
                    guard let brandId = result.value(forKey: "brandId") as? String else { return nil }
                    guard let couponSerial = result.value(forKey: "couponSerial") as? String else { return nil }
                    let user = FRDData(userId: userid, serviceId: serviceId, carSizeId: carSizeId, carTypeId: carTypeId, longitude: longitude, latitude: latitude, address: address, orderDate: orderDate, orderTimeId: orderTimeId, numberOfCars: numberOfCars, totalPrice: totalPrice, subServices: subServices, userName: userName, userPhone: userPhone, carTypeName: carTypeName, serviceTypeName: serviceTypeName, servicePrice: servicePrice, ServicesNames: ServicesNames, Payment: Payment, subServiceId: subServiceId,paymentId:paymentId,brandId:brandId,couponSerial:couponSerial)
                    retrievedUsers.append(user)
                }
            }
        } catch {
            print("Error retrieving: \(error)")
        }
        return retrievedUsers
    }
func deleteAllData(entity: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

    do{
        
    let results = try managedContext.fetch(fetchRequest)
    for managedObject in results {
        let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
        managedContext.delete(managedObjectData)
    }
} catch let error as NSError {
    print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
}
}


func deleteDataAtIndex(atIndex:Int,array:[FRDData]){
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartModel")

//    fetchRequest.predicate = NSPredicate(format: "userid = %@ AND serviceId = %@ AND carSizeId = %@ AND carTypeId = %@ AND longitude = %@ AND latitude = %@ AND address = %@ AND orderDate = %@ AND orderTimeId = %@ AND numberOfCars = %@ AND totalPrice = %@ AND subServices = %@ AND userName = %@ AND userPhone = %@ AND carTypeName = %@ AND serviceTypeName = %@ AND servicePrice = %@ AND servicesNames = %@ AND payment = %@",array[atIndex].userId,array[atIndex].serviceId,array[atIndex].carSizeId,array[atIndex].carTypeId,array[atIndex].longitude,array[atIndex].latitude,array[atIndex].address,array[atIndex].orderDate,array[atIndex].orderTimeId,array[atIndex].numberOfCars,array[atIndex].totalPrice,array[atIndex].subServices,array[atIndex].userName,array[atIndex].userPhone,array[atIndex].carTypeName,array[atIndex].serviceTypeName,array[atIndex].servicePrice,array[atIndex].ServicesNames,array[atIndex].Payment)
    fetchRequest.predicate = NSPredicate(format: "userid = %@",array[atIndex].userId)

   do{
        let dateRequest = try managedContext.fetch(fetchRequest)
        let objectToDelete = dateRequest[atIndex] as! NSManagedObject
        managedContext.delete(objectToDelete)
    
        do{
            try managedContext.save()
            
        }catch{
            print("Error Delete",error)
            
    }
        
    }catch{
        print("Error Delete",error)
        
    }
}
    
    
    
    
    
    
    

