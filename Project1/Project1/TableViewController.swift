//
//  TableViewController.swift
//  Project1
//
//  Created by Kaylin Shioshita on 3/4/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

// Resources
// Execute action when back button is pressed
// https://stackoverflow.com/questions/27713747/execute-action-when-back-bar-button-of-uinavigationcontroller-is-pressed
import UIKit
import RealmSwift

class TableViewController: UITableViewController, UINavigationControllerDelegate {

    var realm : Realm!
    
    var days=[Day]()
    var alldata=[Data]()
    var oneDay=[Day]()
    let exampleday=Day()
    var daycode=String()
    var oneData = Data()
    var detailday=Day()
    var dayString=String()
    
    var listofdays: Results<Database> {
        get{
            return realm.objects(Database.self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="addsegue"{
            let source = segue.destination.childViewControllers[0] as! AddEntryViewController
            source.daycode=daycode
            print("Send data to add entry: \(daycode)")
        } else if segue.identifier=="getinfosegue"{
            let source = segue.destination.childViewControllers[0] as! AddEntryViewController
            let cell = sender as! UITableViewCell
            let indexcell = tableView.indexPath(for: cell)
            source.title=dayString
            source.reload=true
            source.reloadDay = oneData.data[(indexcell?.row)!]
            source.entryrow=(indexcell?.row)!
            print("entryrow is \(source.entryrow)")
        }
    }
    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        if segue.identifier=="savesegue"{
            
            let source=segue.source as! AddEntryViewController
            if source.selectedCond != nil{
                let tempDay=Day()
                tempDay.condition=source.selectedCond!
                tempDay.steps=source.newDay.steps
                tempDay.daycode = daycode
                tempDay.timeofday = source.newDay.timeofday
                tempDay.notes = source.newDay.notes
                print(tempDay.notes)
//                oneDay.append(tempDay)
                print("all data in tableview before for loop: \(alldata.count)")
                
                var dateFound=false
                for day in alldata{
                    if day.code == daycode{
                        dateFound=true
                        print("something added additional entry to day \(oneData.data.count)")
                        if source.sendUpdatedEntry{
                            print("updating entry")
                            let rowtoupdate=source.entryrow
//                            day.data[rowtoupdate]=tempDay
                            try! self.realm.write {
                                day.data[rowtoupdate]=tempDay
                            }
                            break
                        }else{
                            print("additional entry to day")
//                            day.data.append(tempDay)
                            try! self.realm.write{
                                day.data.append(tempDay)
                            }
                            break
                        }
                        
                        
                    }
                    
                }
                
                if !dateFound{
                    print("add entry to new day")
                    let tempData=Data()
                    tempData.code=daycode
                    tempData.data.append(tempDay)
                    //                        oneData=tempData
                    //                        alldata.append(tempData)
                    oneData=tempData
                    alldata.append(tempData)
                    //                        oneData=tempData
                    print("in else oneData has:  \(oneData.data.count)")
                    let tempDatabase=Database()
                    tempDatabase.daycode=tempDay.daycode
                    tempDatabase.condition=tempDay.condition
                    tempDatabase.notes=tempDay.notes
                    tempDatabase.timeofday=tempDay.timeofday
                    for step in tempDay.steps{
                        tempDatabase.steps.append(step)
                    }
                    
                    do{
                        try self.realm.write ({
                            self.realm.add(tempData)
                        })
                    } catch{
                        print(error.localizedDescription)
                    }
                }
                
                if alldata.count==0{
//                    print("first date in alldata")
                    let tempData=Data()
                    tempData.code=daycode
                    tempData.data.append(tempDay)
                    oneData=tempData
//                    oneData.data.append(tempDay)
                    alldata.append(tempData)
                    do{
                        try self.realm.write ({
                            print("added to database")
                            self.realm.add(tempData)
                        })
                    } catch let error{
                        print(error.localizedDescription)
                    }
//                    print("alldata number of entries in first date in all data \(alldata[0].data.count)")
                }
//                print("oneData in tableview: \(oneData.data.count)")
//                print("all data in tableview: \(alldata.count)")
//                days.append(tempDay)
                tableView.reloadData()
            }
        } else if segue.identifier=="cancelSegue"{
//             let source=segue.source as! AddEntryViewController
//            print("yay")
        }
    }
    
    override func viewDidLoad() {
//        print("inside viewDidLoad")
        do{
            realm = try Realm()
//            print("inside realm init")
            
        }catch let error{
            print(error.localizedDescription)
        }
        
//        print(listofdays)
        super.viewDidLoad()
//        exampleday.condition="Meh"
//        days.append(exampleday)
        navigationController?.navigationBar.prefersLargeTitles=true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        print("oneData entries: \(oneData.data.count)")
        print("all data count in tableview \(alldata.count)")
    
//        oneData.data.removeAll()
        
        
//        print("inside viewwillappear allData.count: \(alldata.count)")
//        for day in alldata{
//
//            print("entires in day inside view will appear \(day.data.count)")
//            if day.code==daycode{
//
//                print("inside if viewwillappear day matches \(day.data.count)")
//                oneData.data=day.data
////                for entry in day.data{
////                    oneData.data.append(entry)
////                }
////                break
//
//            }
//        }
        for day in alldata{
            if day.code == daycode{
                oneData=day
            }
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        print("Number of entries: \(oneData.data.count)")
        return oneData.data.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        var stepString=""
        let cond = oneData.data[indexPath.row].condition
        switch cond {
            case 0:
                cell.imageView?.image=UIImage(named:"great-t")
                cell.textLabel?.text="Great"
            case 1:
                cell.imageView?.image=UIImage(named:"good-t")
                cell.textLabel?.text="Good"
            case 2:
                cell.imageView?.image=UIImage(named:"fine-t")
                cell.textLabel?.text="Ok"
            case 3:
                cell.imageView?.image=UIImage(named:"bad-t")
                cell.textLabel?.text="Bad"
            case 4:
                cell.imageView?.image=UIImage(named:"terrible-t")
                cell.textLabel?.text="Terrible"
            default:
                cell.imageView?.isHidden=true
                cell.textLabel?.text=""
            }
        for step in oneData.data[indexPath.row].steps{
            stepString+=("\(step), ")
        }
            if stepString.count > 2{
                let endOfText=stepString.index(stepString.endIndex, offsetBy: -2)
                stepString=String(stepString[..<endOfText])
            }
//        cell.detailTextLabel?.text=String(stepString)
        
        if oneData.data[indexPath.row].timeofday == 0{
            cell.detailTextLabel?.text = "Morning"
        } else{
            cell.detailTextLabel?.text = "Evening"
        }
        
//        print("draw cell\(oneData.data.count)")
        return cell
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if self.isMovingFromParentViewController{
            let source = self.parent?.childViewControllers[0] as! CollectionViewController
            source.tempSendString="yellow"
//            print("days count: \(days.count)")
//            source.allData=oneData
            source.allData=alldata
            
        }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            try! self.realm.write {
                oneData.data.remove(at: indexPath.row)
                for day in alldata{
                    if day.code == daycode{
                        day.data=oneData.data
                        //                    print("data for day: \(daycode)")
                    }
                }
            }
            print("ouch")
            
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
