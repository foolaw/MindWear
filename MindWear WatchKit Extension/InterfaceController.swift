//
//  InterfaceController.swift
//  MindWear WatchKit Extension
//
//  Created by flog on 13.10.20.
//

import WatchKit
import Foundation
import CoreLocation
import Alamofire

class InterfaceController: WKInterfaceController, CLLocationManagerDelegate {
    
    let API_URL = "https://dummy.mindwear.org/watchlocations/api"
    let APP_ID = "xx7cdbb1be1cbd9b17e97a52530974xx"

    @IBOutlet var longitudeTextField: WKInterfaceTextField!
    
    @IBOutlet var latitudeTextField: WKInterfaceTextField!
    
    @IBOutlet var sendLocationButton: WKInterfaceButton!
    
    let locationManger = CLLocationManager()
    
    var longitude: Double = 0
    var latitude: Double = 0
    
    
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        locationManger.delegate = self
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManger.requestWhenInUseAuthorization()
        self.locationManger.startUpdatingLocation()
        
        if locationManger.location?.coordinate.longitude != nil {
            
            longitude = (locationManger.location?.coordinate.longitude)!
            
        }
        
        if locationManger.location?.coordinate.latitude != nil {
            
            latitude = (locationManger.location?.coordinate.latitude)!

        }
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func buttonPressed() {
        
        longitudeTextField.setText(String(longitude))
        latitudeTextField.setText(String(latitude))
        postLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {

        print("longitude = \(location.coordinate.longitude)\nlatitude = \(location.coordinate.latitude)")

            let cLatitude = location.coordinate.latitude
            latitude = cLatitude
            let cLongitude = location.coordinate.longitude
            longitude = cLongitude

        }
    }
    
    func postLocation() {
        
        let params: Parameters = ["long": self.longitude, "lat": self.latitude ]
                
        AF.request(API_URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
            do {
                print("Api not available")
            }
           
        }

    }

}
