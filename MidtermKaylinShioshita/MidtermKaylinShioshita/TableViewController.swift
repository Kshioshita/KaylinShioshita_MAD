//
//  TableViewController.swift
//  MidtermKaylinShioshita
//
//  Created by Kaylin Shioshita on 3/15/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var restaurants=[Restaurant]()
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadjson()
        navigationController?.navigationBar.prefersLargeTitles=true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        //search results
//        let resultsController = SearchViewController()
//        resultsController.allrest = restaurants
//        searchController = UISearchController(searchResultsController: resultsController) //initialize our search controller with the resultsController when it has search results to display
//
//        //search bar configuration
//        searchController.searchBar.placeholder = "Enter a search term" //place holder text
//        //searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
//        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
//        searchController.searchResultsUpdater = resultsController //sets the instance to update search results
    }
    
    func loadjson(){
        //calcium nutirents=301
        //potassium nutirents=306
        //vitamin a nutirents=320
        //vitamin d nutirents=324
        //magnesium nutirents=304
        let urlpath="https://creative.colorado.edu/~apierce/samples/data/restaurants.json"
        
        guard let url = URL(string:urlpath)
            else{
                print("url error")
                return
        }
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard statusCode==200
                else{
                    print("file download error")
                    return
            }
            print("download complete")
            DispatchQueue.main.async {self.parsejson(data!)}
        })
        session.resume()
    }
    
    func parsejson(_ data:Data) {
        self.restaurants.removeAll()
        tableView.reloadData()
        
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String:String]]
            for restaurant in json{
                guard let name=restaurant["name"],
                    let url=restaurant["url"]
                    else{
                        continue
                }
                let newRestaurant=Restaurant()
                newRestaurant.name=name
                newRestaurant.url=url
                self.restaurants.append(newRestaurant)
                
            }
                        print(restaurants.count)
                        print(restaurants)
        } catch{
            print(error)
            return
        }
        tableView.reloadData()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="showweb"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.restauranturl=restaurants[indexPath.row].url
                controller.title=restaurants[indexPath.row].name
            }
            
        }
    }
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier=="savesegue"{
            let source = segue.source as! AddViewController
            if (source.addedRest.name.isEmpty == false){
                restaurants.append(source.addedRest)
                tableView.reloadData()
                
            }
        }
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
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text=restaurants[indexPath.row].name
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
