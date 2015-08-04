//
//  ViewController.swift
//  CurrentLocation
//
//  Created by LOANER on 8/2/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("\(manager.location.coordinate.latitude) \(manager.location.coordinate.longitude)")
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                println("An error occured \(error.localizedDescription)")
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                println("\(pm.subThoroughfare) \(pm.thoroughfare)")
                println(pm.locality)
                println(pm.postalCode)
            }
        })
    }

    @IBAction func locateMe(sender: AnyObject) {
        // Request authorization
        locationManager.requestWhenInUseAuthorization()
        
        // Set accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        // Set our self as the delegate
        locationManager.delegate = self
        
        // Start updating location
        locationManager.startUpdatingLocation()
    }
}

