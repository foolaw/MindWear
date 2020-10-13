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
        
        if locationManger.location?.coordinate != nil {
            
            longitude = (locationManger.location?.coordinate.longitude)!
            latitude = (locationManger.location?.coordinate.latitude)!
        }
        
        print("longitude: " + String(longitude))
        print("latitude: " + String(latitude))
        
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
        
    }
}
