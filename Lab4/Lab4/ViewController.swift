//
//  ViewController.swift
//  Lab4
//
//  Created by Kaylin Shioshita on 3/1/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var foods=[Foods]()
    var nutrients = ["Calcium", "Potassium", "Vitamin A", "Vitamin B", "Magnesium"]
    var nutirentsCode = ["301", "306", "320", "324", "304"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadjson()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadjson(){
        //calcium nutirents=301
        //potassium nutirents=306
        //vitamin a nutirents=320
        //vitamin d nutirents=324
        //magnesium nutirents=304
        let urlpath="https://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=ZaY5y5AflRDr9apfR7ygWSbB1zpO0iISBDQ7L1Lf&nutrients=301&subset=1&sort=c&max=10"
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
            print(foods.count)
            print(foods)
        } catch{
            print(error)
            return
        }
        tableView.reloadData()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutrients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text=nutrients[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="foodsegue"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let nutrient = nutrients[indexPath.row]
//                let sendfoods=foods
                let controller=segue.destination as! FoodsViewController
//                controller.foods=sendfoods
                controller.nutrient=indexPath.row
                controller.nutrientName=nutrients[indexPath.row]
                controller.title=nutrient
            }
        }
    }
   


}

