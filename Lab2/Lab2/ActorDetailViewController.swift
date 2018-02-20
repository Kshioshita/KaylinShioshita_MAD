//
//  ActorDetailViewController.swift
//  Lab2
//
//  Created by Kaylin Shioshita on 2/19/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class ActorDetailViewController: UITableViewController {
    
    var selectedActor=0
    var selectedDramas=[String]()
    var selectedFacts=[String]()
    
    var actorDetail=Actor()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let source=segue.source as! AddDramaViewController
            if((source.addedDrama.isEmpty)==false){
                print("added \(source.addedDrama)")
                actorDetail.actorData[actorDetail.actors[selectedActor]]!["Dramas"]!.append(source.addedDrama)
                actorDetail.dramas[selectedActor].append(source.addedDrama)
                selectedDramas.append(source.addedDrama)
//                print(actorDetail.dramas[selectedActor])
                tableView.reloadData()
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
//        print(actorDetail.actors)
//        print(selectedActor)
        let chosenActor=actorDetail.actors[selectedActor]
        print("chosenActor is \(chosenActor)")
//        selectedDramas=actorDetail.actorData[chosenActor]!["Dramas"]!
        selectedDramas=actorDetail.dramas[selectedActor]
//        print(selectedDramas)
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
        return selectedDramas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text=selectedDramas[indexPath.row]
        // Configure the cell...

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
            selectedDramas.remove(at: indexPath.row)
            let chosenActor=actorDetail.actors[selectedActor]
//            actorDetail.actorData[chosenActor]!["Dramas"]!.remove(at: indexPath.row)
            actorDetail.dramas[selectedActor].remove(at: indexPath.row)
            actorDetail.actorData[chosenActor]!["Dramas"]!.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let fromRow=fromIndexPath.row
        let toRow=toIndexPath.row
        let moveDrama=selectedDramas[fromRow]
        selectedDramas.remove(at: toRow)
        selectedDramas.insert(moveDrama, at: toRow)
//        let chosenActor=actorDetail.actors[selectedActor]
//        actorDetail.actorData[chosenActor]!["Dramas"]!.remove(at: fromRow)
        actorDetail.dramas[selectedActor].remove(at: fromRow)
        actorDetail.dramas[selectedActor].insert(moveDrama, at: toRow)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
