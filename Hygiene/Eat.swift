//
//  Eat.swift
//  Hygiene
//
//  Created by Edith Dande on 08/04/2018.
//

import Foundation
import MapKit
import Contacts

class Eat: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var rating: String
    var pinTintColor: UIColor  {
        switch rating {
        case "5":
            return .green
        case "-1":
            return .red
        case "0":
            return .orange
        case "2":
            return .yellow
        default:
            return .blue
        }
    }
    var imageName: String? {
        return "restaurant"
    }
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, rating: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.rating = rating
    }
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: title!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
