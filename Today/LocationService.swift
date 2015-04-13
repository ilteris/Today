//
//  LocationService.swift
//  Today
//
//  Created by ilteris on 4/12/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import Foundation
import CoreLocation


protocol CurrentLocation {
    func updatedLocation(lat:String, lon:String)
}


class LocationService: NSObject, CLLocationManagerDelegate {
    
    var coreLocationManager: CLLocationManager?
    var delegate: CurrentLocation?
    
    override init() {
        super.init()
        
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
                case .AuthorizedWhenInUse:
                        /* Yes, only when our app is in use. */
                        createLocationManager(startImmediately: true)
                case .Denied:
                        /* No. */
                        //displayAlertWithTitle("Not Determined", message: "Location services are not allowed for this app")
                        println("Location services are not allowed for this app")

                case .NotDetermined:
                        /* We don't know yet; we have to ask */
                        createLocationManager(startImmediately: false)
                if let manager = self.coreLocationManager {
                        manager.requestWhenInUseAuthorization()
                    }
                case .Restricted:
                        /* Restrictions have been applied; we have no access
                        ￼9.3. Pinpointing the Location of a Device
                        | 419
                        to location services. */
                       // displayAlertWithTitle("Restricted", message: "Location services are not allowed for this app")
                        println("Location services are not allowed for this app")
                default:
                        println("default")
            }
            
        } else {
            /* Location services are not enabled.
            Take appropriate action: for instance, prompt the user to enable the location services. */
            println("Location services are not enabled")
        }
        
        
    }
    
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        print("The authorization status of location services is changed to: ")
        switch CLLocationManager.authorizationStatus() {
    case .AuthorizedWhenInUse:
        println("Authorized when in use")
    case .Denied:
        println("Denied")
    case .NotDetermined:
        println("Not determined")
    case .Restricted:
        println("Restricted")
    default:
        println("Unhandled")
        }
    }
       
    
    func createLocationManager(#startImmediately: Bool) {
        coreLocationManager = CLLocationManager()
        if let manager = coreLocationManager {
            println("Successfully created the location manager")
                manager.delegate = self
            
            
            if startImmediately {
                manager.startUpdatingLocation()
            }
        
        }
    }
        
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
            println("Location manager failed with error = \(error)")
    }
    
    

    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        var latitude:String = "\(newLocation.coordinate.latitude)"
        var longitude:String = "\(newLocation.coordinate.longitude)"
        coreLocationManager?.stopUpdatingLocation()
       delegate?.updatedLocation(latitude, lon: longitude)
    
    }    
    
    
    
    
    
    
    
}
