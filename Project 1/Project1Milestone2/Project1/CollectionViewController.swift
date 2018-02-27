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

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    @IBOutlet weak var buttonOutlet: UIButton!
    var calendar1 = DateComponents()
    var calendar = Calendar(identifier: .gregorian)
    var month = 0
    var day = 0
    var year = 0
    var today=Date()
    var weekday=0
    let weekDays=["S","M", "T", "W", "T", "F", "S"]
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        month=month+1
        if month > 12{
            year=year+1
            month=1
        }
        calendar1=DateComponents(year:year, month:month, day:day)
        self.collectionView?.reloadData()
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        month=month-1
        if month<1{
            year=year-1
            month=12
        }
        day=1
        calendar1=DateComponents(year:year, month:month, day:day)
        print(month)
        self.collectionView?.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        calendar = Calendar.current
//        print(calendar.monthSymbols)
        
        today=Date()
        month=calendar.component(.month, from: today)
        day=calendar.component(.day, from: today)
        year=calendar.component(.year, from: today)
        calendar1=DateComponents(year:year, month:month, day:day)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
            let newMonth=DateComponents(year:year, month:month, day:1)
            let firstDay=Calendar(identifier: .gregorian).date(from: newMonth)!
            weekday=calendar.component(.weekday, from: firstDay)
            print("Weekday is \(weekday)")
            print(range.count+weekday)
            return range.count+weekday-1
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section==0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
                cell.cellLabel.text=weekDays[indexPath.row]
            // Configure the cell
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
            
            if (indexPath.row+2)<=weekday{
                cell.cellLabel.text=""
            } else{
                cell.cellLabel.text=String((indexPath.row+2-weekday))
            }
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
            
            print("section2")
            if kind==UICollectionElementKindSectionHeader{
                
                header=collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? CollectionSupplementaryView
                header?.monthLabel.text=calendar.monthSymbols[month-1]
                header?.isHidden=false
                //            header?.nextButton.addTarget(self, action: #selector(CollectionSupplementaryView.nextMonth(_:)), for: .touchUpInside)
            }
            return header!
        }
       
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
