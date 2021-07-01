//
//  HomeViewModel.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI
import CoreLocation
import Firebase
import FirebaseStorage

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
    
    // ItemData...
    @Published var items : [Item] = []
    
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
//        after Extracting Location Logging In...
//        self.login()
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
    // anynomois login For Reading Database ....
//
//    func login() {
//        Auth.auth().signInAnonymously{ (res, err) in
//
//            if err != nil{
//                print(err!.localizedDescription)
//                return
//            }
//
//            print("Success = \(res!.user.uid)")
//
//
//    }
//}
    // Fetching Items Data....
    func fetchData(){
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments { (snap, err) in
            guard let itemData = snap else {return}
            
            self.items = itemData.documents.compactMap({ (doc) -> Item? in
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! NSNumber
                let ratings = doc.get("item_ratings") as! String
                let image = doc.get("item_image") as! String
                let details = doc.get("item_details") as! String
                
                return Item(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_ratings: ratings)
            })
        }
    }
}
