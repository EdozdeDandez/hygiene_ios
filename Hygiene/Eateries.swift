//
//  Eateries.swift
//  Hygiene
//
//  Created by Edith Dande on 06/04/2018.
//

import Foundation
import MapKit
import Contacts


class Eateries: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let subtitle: String?
    var id: String
    let title: String?
    var AddressLine1: String
    var AddressLine2: String
    var AddressLine3: String
    var RatingValue: String
    var RatingDate: String
    var DistanceKM: String?
    var pinTintColor: UIColor  {
        switch RatingValue {
        case "5":
            return .green
        case "4":
            return .cyan
        case "3":
            return .magenta
        case "2":
            return .yellow
        case "1":
            return .brown
        case "0":
            return .orange
        case "-1":
            return .red
        default:
            return .blue
        }
    }
    var imageName: String? {
        return "restaurant"
    }
    
    
    init(eatery: Eatery) {
        let latitude = Double(eatery.Latitude!)
        let longitude = Double(eatery.Longitude!)
        self.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        self.id = eatery.id!
        self.title = eatery.BusinessName
        self.subtitle = "Click to get directions"
        self.AddressLine1 = eatery.AddressLine1!
        self.AddressLine2 = eatery.AddressLine2!
        self.AddressLine3 = eatery.AddressLine3!
        self.RatingValue = eatery.RatingValue!
        self.RatingDate = eatery.RatingDate!
        if eatery.DistanceKM != nil {
            self.DistanceKM = eatery.DistanceKM!
        }
        
        
        super.init()
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: title!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    

}
