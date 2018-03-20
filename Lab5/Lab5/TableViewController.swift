//
//  TableViewController.swift
//  Lab5
//
//  Created by Kaylin Shioshita on 3/19/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {

    var realm:Realm!
    
    
    var showList:Results<Show> {
        get{
            return realm.objects(Show.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            realm=try Realm()
        } catch let error{
            print(error.localizedDescription)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    @IBAction func unwind(_ segue:UIStoryboardSegue){
        if segue.identifier=="saveSegue"{
            print("adding to realm")
            let source = segue.source as! AddViewController
            if source.newShow.name.isEmpty==false{
                let newShow = Show()
                newShow.name=source.newShow.name
                newShow.days=source.newShow.days
                do{
                    try self.realm.write({
                    self.realm.add(newShow)
                    tableView.reloadData()
                    })
                } catch let error{
                    print(error.localizedDescription)
                }
            }
        }
        print("after adding to realm")
        
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
        return showList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text=showList[indexPath.row].name
        cell.detailTextLabel?.text=showList[indexPath.row].days
        cell.accessoryType = showList[indexPath.row].watched ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let changeShow = showList[indexPath.row]
        try! self.realm.write{
            changeShow.watched = !changeShow.watched
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteShow = showList[indexPath.row]
            try! self.realm.write {
                self.realm.delete(deleteShow)
            }
            print(showList.count)
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
