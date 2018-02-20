//
//  ViewController.swift
//  Lab2
//
//  Created by Kaylin Shioshita on 2/19/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var actorList=Actor()
    var dramas=[[String]]()
    var facts=[[String]]()
    var kfilename="data1.plist"
    var selectedActor=0
    var searchController:UISearchController!
    let resultsController = SearchResultsController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pathURL:URL?
        let dirPath=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        let dataFileURL = docDir.appendingPathComponent(kfilename)
        if FileManager.default.fileExists(atPath: dataFileURL.path){
            pathURL=dataFileURL
        } else{
            pathURL=Bundle.main.url(forResource: "dramas", withExtension: "plist")
        }
        
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        // Do any additional setup after loading the view, typically from a nib.
        let plistdecoder=PropertyListDecoder()
        do {
            let data = try Data(contentsOf:pathURL!)
            actorList.actorData=try plistdecoder.decode([String: [String:[String]]].self, from: data)
            actorList.actors=Array(actorList.actorData.keys)
            
            for actors in actorList.actors{
                actorList.dramas.append(actorList.actorData[actors]!["Dramas"]!)
//                actorList.facts.append(actorList.actorData[actors]!["Facts"]!)
//                    print(actorList.actorData[actors]!["Dramas"]!)
        
            }
//                let dramas=[Array(actorList.actorData.keys["Dramas"])]
            print(dramas)
//                print(facts)
            
        } catch {
            print(error)
        }
        
        
        resultsController.allActors=actorList.actors
        print(actorList.actors)
        searchController=UISearchController(searchResultsController:resultsController)
        searchController.searchBar.placeholder="Enter a search term"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView=searchController.searchBar
        searchController.searchResultsUpdater=resultsController
        
    
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.applicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: app)
    }
    
    @objc func applicationWillResignActive(_ notification: NSNotification){
        let dirPath=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir=dirPath[0]
//        print(docDir)
        let dataFileUrl=docDir.appendingPathComponent(kfilename)
        let plistencoder=PropertyListEncoder()
        plistencoder.outputFormat = .xml
        do{
            let data = try plistencoder.encode(actorList.actorData)
            try data.write(to: dataFileUrl)
//            print(actorList.actorData)
        } catch {
            print(error)
        }
    }
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let source=segue.source as! AddActorViewController
            if((source.addedActor.isEmpty)==false){
                actorList.actors.append(source.addedActor)
                actorList.dramas.append([])
                actorList.facts.append([])
                actorList.actorData[source.addedActor]=["Dramas":[]]
                resultsController.allActors=actorList.actors
                tableView.reloadData()
                
            }
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            dramas.remove(at: indexPath.row)
            let chosenActor=actorList.actors[selectedActor]
//            print(chosenActor)
            actorList.actors.remove(at: indexPath.row)
            actorList.actorData.removeValue(forKey: chosenActor)
//            print(actorList.actors)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorList.actors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for:indexPath)
        cell.textLabel?.text=actorList.actors[indexPath.row]
        return cell
        
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let fromRow=fromIndexPath.row
        let toRow=toIndexPath.row
        let moveActor=actorList.actors[fromRow]
        actorList.actors.remove(at: fromRow)
        actorList.actors.insert(moveActor, at: toRow)
//        let chosenActor=actorDetail.actors[selectedActor]

    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="profilesegue"{
            let detailvc=segue.destination as! ActorDetailViewController
            let indexPath=tableView.indexPath(for: sender as! UITableViewCell)!
            detailvc.title=actorList.actors[indexPath.row]
            detailvc.actorDetail=actorList
            detailvc.actorDetail.actors=actorList.actors
            detailvc.actorDetail.dramas=actorList.dramas
            print("actorList passed is \(actorList.dramas)")
            detailvc.selectedActor=indexPath.row
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }


}

