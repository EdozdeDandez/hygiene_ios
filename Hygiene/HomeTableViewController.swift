//
//  HomeTableViewController.swift
//  Hygiene
//
//  Created by Edith Dande on 06/04/2018.
//

import UIKit
import MapKit

class HomeTableViewController: UITableViewController {
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var longitude: Double!
    var latitude: Double!
    var places = [Eatery]()
    var selectedRow:Int = 0
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.estimatedRowHeight = 68.0
        table.rowHeight = UITableViewAutomaticDimension
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Food Hygiene"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cellIdentifier = "HomeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HomeTableViewCell.")
        }

        // Fetches each eatery and displays in a row.
        let eatery = places[indexPath.row]
        cell.name.text = eatery.BusinessName
        if eatery.RatingValue == "5" {
            cell.rating.image = #imageLiteral(resourceName: "five")
        }
        else if eatery.RatingValue == "4" {
            cell.rating.image = #imageLiteral(resourceName: "four")
        }
        else if eatery.RatingValue == "3" {
            cell.rating.image = #imageLiteral(resourceName: "three")
        }
        else if eatery.RatingValue == "2" {
            cell.rating.image = #imageLiteral(resourceName: "two")
        }
        else if eatery.RatingValue == "1" {
            cell.rating.image = #imageLiteral(resourceName: "one")
        }
        else if eatery.RatingValue == "0" {
            cell.rating.image = #imageLiteral(resourceName: "zero")
        }
        else if eatery.RatingValue == "-1" {
            cell.rating.image = #imageLiteral(resourceName: "exempt1")
        }
        
        return cell
    }
    
    // Get selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "showEatery", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier! {
        case "toMap":
            let map = segue.destination as? MapViewController
            map?.places = self.places
            map?.navigationItem.title = "Map View"
            break
        case "search":
            let search = segue.destination as? SearchTableViewController
            search?.navigationItem.title = "Search"
            break
        case "showEatery":
            let eatery = segue.destination as? ShowViewController
            let selected = places[selectedRow]
            eatery?.selected = selected
            eatery?.navigationItem.title = self.places[selectedRow].BusinessName
            break
        default:
            break
        }
        
        navigationItem.title = nil
    }
    
    // used to get devices current location in order to give nearest eateries
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation: CLLocation = locations.last!
        currentLocation = lastLocation
        self.latitude = lastLocation.coordinate.latitude
        self.longitude = lastLocation.coordinate.longitude
        getNearest()
    }
    func getNearest() {
        Eatery.nearest(latitude, longitude) { (eateries, error) in
            if let error = error {
                // got an error in getting the data
                print(error)
                return
            }
            guard let eateries = eateries else {
                print("error getting eateries: result is nil")
                return
            }
            
            // success :)
            self.places = eateries
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
}
extension HomeTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: (location)")
        }
    }
}

