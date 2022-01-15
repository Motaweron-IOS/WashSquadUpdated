//
//  locationOnMap.swift
//  WashSquad
//
//  Created by Eslam Moemen on 10/22/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import GoogleMaps

class locationOnMap: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
private let locationManager = CLLocationManager()
    var long:String?
    var lat:String?
    var address:String?
    var delegate:sendBacwards?
    
    @IBOutlet var useButton: UIButton!
    @IBOutlet var theMap: GMSMapView!
    override func viewDidLoad() {
        showInfoWithStatus(Localized("tpmap"))
       super.viewDidLoad();locationManager.delegate = self;locationManager.requestWhenInUseAuthorization(); theMap.delegate = self
        useButton.layer.cornerRadius = 10.0
        useButton.clipsToBounds = true
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           
           guard status == .authorizedWhenInUse else {
               return
           }
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.startUpdatingLocation()
           theMap.isMyLocationEnabled = true
           theMap.settings.myLocationButton = true
           theMap.settings.compassButton = true
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let location = locations[locations.count - 1]
           if location.horizontalAccuracy > 0 {
               self.locationManager.stopUpdatingLocation()
               let latitude = location.coordinate.latitude
               let longitude = location.coordinate.longitude
               theMap.camera = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 15.0, bearing: 6, viewingAngle: 100)
               getAddressFromLatLon(pdblLatitude: String(latitude), withLongitude: String(longitude))
           }
           
       }
       
       func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
           theMap.clear()
           getAddressFromLatLon(pdblLatitude:String(coordinate.latitude) , withLongitude: String(coordinate.longitude))
           
           
       }
       
       
       func addMarker(long:Double,lat:Double,addres:String){
           let marker = GMSMarker()
           marker.position = CLLocationCoordinate2D(latitude: lat , longitude: long)
           //marker.title = "Sydney"
           marker.title = addres
           marker.snippet = addres
           marker.icon = UIImage(named: "pin")
           marker.map = theMap
           useButton.isHidden = false
       }
       
       
       func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
           var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
           let lat: Double = Double("\(pdblLatitude)")!
           //21.228124
           let lon: Double = Double("\(pdblLongitude)")!
           //72.833770
           let ceo: CLGeocoder = CLGeocoder()
           center.latitude = lat
           center.longitude = lon
           
           let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
           
           
           ceo.reverseGeocodeLocation(loc, completionHandler:
               {(placemarks, error) in
                   if (error != nil)
                   {
                       print("reverse geodcode fail: \(error!.localizedDescription)")
                   }
                   let pm = placemarks! as [CLPlacemark]
                   
                   if pm.count > 0 {
                       let pm = placemarks![0]
                       var addressString : String = ""
                       if pm.subLocality != nil {
                           addressString = addressString + pm.subLocality! + ", "
                       }
                       if pm.thoroughfare != nil {
                           addressString = addressString + pm.thoroughfare! + ", "
                       }
                       if pm.locality != nil {
                           addressString = addressString + pm.locality! + ", "
                       }
                       if pm.country != nil {
                           addressString = addressString + pm.country! + ", "
                       }
                       if pm.postalCode != nil {
                           addressString = addressString + pm.postalCode! + " "
                       }
                       
                       self.addMarker(long: Double(pdblLongitude)!, lat: Double(pdblLatitude)!, addres: addressString)
                       //self.displayLabel.text = addressString
                       self.long = pdblLongitude
                       self.lat = pdblLatitude
                       self.address = addressString
                   
                    
                       
                       
                   }
           })
           
       }
    
    @IBAction func used(_ sender: Any) {
        if let del = delegate {
            del.address(address: address!, long: Double(long!)!, Lat: Double(lat!)!)
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    

}
