//
//  HomeViewModel.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI
import CoreLocation

// Fetching User Location.....
class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    // Location Details....
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    // Menu...
    @Published var showMenu = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // checking Location Access....
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied authorized")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            // Direct Call
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // reading User Location And Extracting Details...
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation(){
        
        CLGeocoder().reverseGeocodeLocation(self.userLocation){ (res, error) in
            
            guard let safeData = res else {return}
            
            var address = ""
            
            // getting area location
            address += safeData.first?.name ?? ""
            address += " ,"
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
}
