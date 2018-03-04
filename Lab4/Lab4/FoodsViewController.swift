//
//  FoodsViewController.swift
//  Lab4
//
//  Created by Kaylin Shioshita on 3/3/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit
import WebKit

class FoodsViewController: UITableViewController {

    var foods = [Foods]()
    var nutrient=0
    var nutrientName=""

    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tempfood=Foods(measure:"", name:"Loading Top 10 Sources of \(nutrientName)")
        foods.append(tempfood)
        loadjson()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return foods.count
    }
    
    func loadjson(){
        //calcium nutirents=301
        //potassium nutirents=306
        //vitamin a nutirents=320
        //vitamin d nutirents=324
        //magnesium nutirents=304
        var urlpath=""
        if nutrient==0 {
            urlpath="https://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=ZaY5y5AflRDr9apfR7ygWSbB1zpO0iISBDQ7L1Lf&nutrients=301&subset=1&sort=c&max=10"
        } else if nutrient==1{
            urlpath="https://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=ZaY5y5AflRDr9apfR7ygWSbB1zpO0iISBDQ7L1Lf&nutrients=306&subset=1&sort=c&max=10"
        } else if nutrient==2{
            urlpath="https://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=ZaY5y5AflRDr9apfR7ygWSbB1zpO0iISBDQ7L1Lf&nutrients=320&subset=1&sort=c&max=10"
        } else if nutrient==3{
            urlpath="https://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=ZaY5y5AflRDr9apfR7ygWSbB1zpO0iISBDQ7L1Lf&nutrients=324&subset=1&sort=c&max=10"
        } else{
            urlpath="https://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=ZaY5y5AflRDr9apfR7ygWSbB1zpO0iISBDQ7L1Lf&nutrients=304&subset=1&sort=c&max=10"
        }
        
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
        self.foods.removeAll()
        tableView.reloadData()
        //        do{
        //            print("here")
        //            let api = try JSONDecoder().decode(Report.self, from: data)
        //            print("ok")
        //            print(api)
        ////            for food in api.report
        ////            {
        ////                foods.append(food)
        ////            }
        //
        //        }
        //        catch let jsonError
        //        {
        //            print(jsonError.localizedDescription)
        //            return
        //        }
        
        
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
            let allResults=json["report"] as!  [String:Any]
            let foods=allResults["foods"]! as! [[String:Any]]
            for food in foods{
                guard let name=food["name"] as? String,
                    let measure=food["measure"] as? String
                    else{
                        continue
                }
                let newfood=Foods(measure:measure, name:name)
                self.foods.append(newfood)

            }
//            print(foods.count)
//            print(foods)
        } catch{
            print(error)
            return
        }
        tableView.reloadData()
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text=foods[indexPath.row].name
        cell.detailTextLabel?.text=foods[indexPath.row].measure
        // Configure the cell...

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
