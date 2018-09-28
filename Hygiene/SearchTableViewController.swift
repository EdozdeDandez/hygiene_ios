//
//  SearchTableViewController.swift
//  Hygiene
//
//  Created by Edith Dande on 08/04/2018.
//

import UIKit

class SearchTableViewController: UITableViewController {

    // MARK: - Variables
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    var results = [Eatery]()
    var selectedRow:Int = 0
    
    // MARK: - Actions
    @IBAction func clearSearch(_ sender: Any) {
        searchField.text = ""
    }
    @IBAction func searchPostCode(_ sender: Any) {
        getPostCode()
    }
    @IBAction func searchName(_ sender: Any) {
        getName()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTable.estimatedRowHeight = 68.0
        searchTable.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Search"
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
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cellIdentifier = "SearchTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SearchTableViewCell.")
        }
        
        // Fetches each eatery and displays in a row.
        let eatery = results[indexPath.row]
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "showSearchEatery", sender: self)
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
        if segue.identifier == "showSearchEatery" {
            let eatery = segue.destination as? ShowViewController
            let selected = results[selectedRow]
            eatery?.selected = selected
            eatery?.navigationItem.title = self.results[selectedRow].BusinessName
        }
        navigationItem.title = nil
    }
    func getName(){
        let name = searchField.text
        if name == nil {return}
        Eatery.name(name!) { (eateries, error) in
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
            self.results = eateries
            DispatchQueue.main.async {
                self.searchTable.reloadData()
            }
        }
    }
    func getPostCode(){
        let postCode = searchField.text
        if postCode == nil {return}
        Eatery.postCode(postCode!) { (eateries, error) in
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
            self.results = eateries
            DispatchQueue.main.async {
                self.searchTable.reloadData()
            }
        }
    }

}
