//
//  CollectionViewController.swift
//  Project1
//
//  Created by Kaylin Shioshita on 2/26/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

//Resources
// Hide header
// https://stackoverflow.com/questions/24558772/how-can-i-enable-disable-section-headers-in-uicollectionview-programmatically
// First day of the month
// https://stackoverflow.com/questions/37093134/get-the-first-day-of-a-month-in-swift
// Number of days in a month
// https://stackoverflow.com/questions/31590316/how-do-i-find-the-number-of-days-in-given-month-and-year-using-swift


import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    var allData=[Data]()
    var data=[Day]()
    @IBOutlet weak var buttonOutlet: UIButton!
    var calendar1 = DateComponents()
    var calendar = Calendar(identifier: .gregorian)
    var month = 0
    var day = 0
    var year = 0
    var daycheck=0
    var today=Date()
    var weekday=0
    let weekDays=["S","M", "T", "W", "T", "F", "S"]
    let sectionInsets=UIEdgeInsets(top: 0.0, left: 10.0, bottom: 5, right: 10.0)
    var tempSendString="purple"
    
    var realm : Realm!
    var listofdays: Results<Data> {
        get{
            return realm.objects(Data.self)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        month=month+1
        if month >= 11{
            year=year+1
            month=1
        }
        calendar1=DateComponents(year:year, month:month, day:day)
        self.collectionView?.reloadData()
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        month=month-1
        if month <= 0{
            year=year-1
            month=12
        }
        day=1
        calendar1=DateComponents(year:year, month:month, day:day)
        print("month in prevButton \(month)")
        self.collectionView?.reloadData()
    }
    override func viewDidLoad() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        do {
            realm = try Realm()
        } catch{
            print(error.localizedDescription)
        }
        
        for row in listofdays{
            allData.append(row)
        }
        super.viewDidLoad()
       
        
        navigationController?.navigationBar.prefersLargeTitles=true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        calendar = Calendar.current
//        print(calendar.monthSymbols)
        
        today=Date()
        month=calendar.component(.month, from: today)
        print(calendar.monthSymbols[month-1])
        print("month is \(month)")
        day=calendar.component(.day, from: today)
        year=calendar.component(.year, from: today)
        calendar1=DateComponents(year:year, month:month, day:day)
        print(allData.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("all data count in collectionview: \(allData.count)")
//        print(listofdays)
        
        collectionView?.reloadData()
        
//        print(tempSendString)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="daysegue"){
//            print("daysegue")
            
            let source = segue.destination as! TableViewController
            let indexPath = collectionView?.indexPath(for: sender as! CollectionViewCell)
            let day=indexPath![1]-weekday+2
            //            print(month)
            //            print(year)
            
            let dateCode=("\(day)\(month)\(year)")
//            source.days=data
            source.alldata=allData
            source.title=calendar.monthSymbols[month-1]+" \(day), \(year)"
            source.dayString=calendar.monthSymbols[month-1]+" \(day), \(year)"
            source.daycode=dateCode
            print(dateCode)
            
        }
        
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier=="daysegue"{
            let cell = sender as! CollectionViewCell
            if cell.cellLabel.text == "M" || cell.cellLabel.text == "S" || cell.cellLabel.text == "T" || cell.cellLabel.text == "W" || cell.cellLabel.text == "F"{
                return false
            }
        }
        return true
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section==0{
            return 7
        } else{
            let date = calendar.date(from: calendar1)!
            let range = calendar.range(of: .day, in: .month, for: date)!
            print(date)
            print(range)
            let newMonth=DateComponents(year:year, month:month, day:1)
            print(newMonth.month!)
//            print(calendar.monthSymbols[newMonth.month!])
            let firstDay=Calendar(identifier: .gregorian).date(from: newMonth)!
            print(firstDay)
            weekday=calendar.component(.weekday, from: firstDay)
            print(weekday)
//            print("Weekday is \(weekday)")
//            print(range.count+weekday)
            return range.count+weekday-1
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentday=Date()
        let currentmonth=calendar.component(.month, from: currentday)
        let currentweekday=calendar.component(.day, from: currentday)
        let currentyear=calendar.component(.year, from: currentday)
//        print(currentweekday)
        if indexPath.section==0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
                cell.cellLabel.font=UIFont.systemFont(ofSize: 18, weight:UIFont.Weight.regular)
                cell.cellLabel.text=weekDays[indexPath.row]
                cell.cellImg.isHidden=true
            // Configure the cell
            
            return cell
        }else{
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
            
            cell.layer.borderWidth = 0.0
            cell.cellLabel.font=UIFont.systemFont(ofSize: 17, weight:UIFont.Weight.ultraLight)
            if (indexPath.row+2)<=weekday{
                cell.cellLabel.text=""
                cell.cellImg.isHidden=true
            } else{
                cell.cellImg.isHidden=false
                if month==currentmonth && year==currentyear && indexPath.row+2-weekday==currentweekday{
                    cell.layer.borderWidth = 1.0
                    cell.layer.cornerRadius=2.0
                    cell.layer.borderColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 0.5).cgColor
                }
                cell.cellLabel.text=String((indexPath.row+2-weekday))
                let someday=indexPath[1]-weekday+2
                //                    print(day.daycode)
                let dateCode = ("\(someday)\(month)\(year)")
                
                for day in allData{
                    
//                    print(dateCode)
//                    print("datecode \(dateCode)")
//                    print("allData.code \(day.code)")
                    if dateCode ==  day.code {
//                        print("set cell img in collection view")
                        var cond = -1
                        for oneday in day.data{
                            cond=oneday.condition
                        }
                        print("day = datecode")
                        switch cond{
                        case 0:
                            cell.cellImg.image=UIImage(named:"0")
                            cell.cellImg.isHidden=false
//                            print("in case 0")
                        case 1:
                            cell.cellImg.image=UIImage(named:"1")
                            cell.cellImg.isHidden=false
//                            print("in case 1")
                        case 2:
                            cell.cellImg.image=UIImage(named:"2")
                            cell.cellImg.isHidden=false
//                            print("in case 2")
                        case 3:
                            cell.cellImg.image=UIImage(named:"3")
                            cell.cellImg.isHidden=false
                        case 4:
                            cell.cellImg.image=UIImage(named:"4")
                            cell.cellImg.isHidden=false
                        default:
                            cell.cellImg.isHidden=true
                        }
                      break
                    } else {
                        cell.cellImg.isHidden=true
                    }
                }
            }
            
//            print(indexPath)
            // Configure the cell
            
            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section==1{
            var header:CollectionSupplementaryView?
            if kind==UICollectionElementKindSectionHeader{
                header=collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? CollectionSupplementaryView
                header?.isHidden=true
            }
            return header!
        }else{
            var header: CollectionSupplementaryView?
            if kind==UICollectionElementKindSectionHeader{
                
                header=collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? CollectionSupplementaryView
                print(month-1)
                header?.monthLabel.text=calendar.monthSymbols[month-1]
                header?.isHidden=false
                //            header?.nextButton.addTarget(self, action: #selector(CollectionSupplementaryView.nextMonth(_:)), for: .touchUpInside)
            }
            return header!
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section==1{
            return CGSize(width: 0, height: 0)
        }
        
        else{
            return CGSize(width: collectionView.frame.size.width-20, height: 70)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print("Screen width is \(UIScreen.main.bounds.width)")
        var newSize=CGSize()
        if UIScreen.main.bounds.width<=375{
            newSize=CGSize(width: UIScreen.main.bounds.width/10, height:UIScreen.main.bounds.width/10)
        } else{
            newSize=CGSize(width: UIScreen.main.bounds.width/9, height:UIScreen.main.bounds.width/9)
        }
        
//        print(newSize.width)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        let rect=CGRect(x: 0, y:0, width:newSize.width, height:newSize.height)
        return newSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let device=UIScreen.main.traitCollection.userInterfaceIdiom
        let screenWidth=UIScreen.main.bounds.width
        switch (device) {
        case .phone:
            switch UIDevice.current.orientation{
            case .landscapeRight:
                if screenWidth >= 800 {
                    return UIEdgeInsets(top: 0, left: 30, bottom: 5, right: 50)
                } else{
                    return UIEdgeInsets(top: 0, left: 30, bottom: 5, right: 30)
                }
            case .landscapeLeft:
                if screenWidth >= 800 {
                    return UIEdgeInsets(top: 0, left: 50, bottom: 5, right: 30)
                } else{
                    return UIEdgeInsets(top: 0, left: 30, bottom: 5, right: 30)
                }
            default:
                return sectionInsets
            }
        case .pad:
            print("ipad")
            switch UIDevice.current.orientation{
            case .portrait:
                print("portrait")
                if screenWidth >= 1024{
                    print("ipadpro")
                    return UIEdgeInsets(top: 0, left: 50, bottom: 5, right: 50)
                }else{
                    return UIEdgeInsets(top: 0, left: 20, bottom: 5, right: 20)
                }
                
            case .landscapeLeft:
                if screenWidth >= 1300 {
                    return UIEdgeInsets(top: 0, left: 50, bottom: 5, right: 50)
                } else{
                    return UIEdgeInsets(top: 0, left: 30, bottom: 5, right: 30)
                }
            case .landscapeRight:
                if screenWidth >= 1300 {
                    return UIEdgeInsets(top: 0, left: 50, bottom: 5, right: 50)
                } else{
                    return UIEdgeInsets(top: 0, left: 30, bottom: 5, right: 30)
                }
            default:
                    print("landscape")
                    return UIEdgeInsets(top: 0, left: 30, bottom: 5, right: 30)
            }
            
            
        default:
            return sectionInsets
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.reloadData()
    }
    
    
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
