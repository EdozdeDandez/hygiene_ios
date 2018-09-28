//
//  ShowViewController.swift
//  Hygiene
//
//  Created by Edith Dande on 08/04/2018.
//

import UIKit
import MapKit

class ShowViewController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    @IBOutlet weak var address3: UILabel!
    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var dateRated: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distance: UILabel!
    
    
    var selected = Eatery()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        address1.text = selected.AddressLine1
        address2.text = selected.AddressLine2
        address3.text = selected.AddressLine3
        dateRated.text = selected.RatingDate
        distance.text = selected.DistanceKM
        if selected.RatingValue == "5" {
            rating.image = #imageLiteral(resourceName: "five")
        }
        else if selected.RatingValue == "4" {
            rating.image = #imageLiteral(resourceName: "four")
        }
        else if selected.RatingValue == "3" {
            rating.image = #imageLiteral(resourceName: "three")
        }
        else if selected.RatingValue == "2" {
            rating.image = #imageLiteral(resourceName: "two")
        }
        else if selected.RatingValue == "1" {
            rating.image = #imageLiteral(resourceName: "one")
        }
        else if selected.RatingValue == "0" {
            rating.image = #imageLiteral(resourceName: "zero")
        }
        else if selected.RatingValue == "-1" {
            rating.image = #imageLiteral(resourceName: "exempt1")
        }
        mapView.delegate = self
        mapView.region = makeRegion()
        let marker = Eateries(eatery: selected)
        mapView.addAnnotation(marker)
        
    }
    
    func makeRegion()-> MKCoordinateRegion {
        let center = CLLocationCoordinate2DMake(Double(selected.Latitude!)!, Double(selected.Longitude!)!)
        let widthMeters:CLLocationDistance = 1000
        let heightMeters:CLLocationDistance = 1000
        return MKCoordinateRegionMakeWithDistance(center, widthMeters, heightMeters)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ShowViewController: MKMapViewDelegate {
    // puts annotations for each of the places nearest
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // ensure the annotation is of eateries class or nil
        
        guard let annotation = annotation as? Eateries else { return nil }
        let identifier = "pin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "drive"), for: UIControlState())
            view.rightCalloutAccessoryView = mapsButton
            view.pinTintColor = annotation.pinTintColor
        }
        return view
    }
    // shows driving directions when user taps on an eatery
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Eateries
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
