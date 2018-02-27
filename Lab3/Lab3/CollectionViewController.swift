//
//  CollectionViewController.swift
//  Lab3
//
//  Created by Kaylin Shioshita on 2/26/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var laniImgs=[String]()
    var mozzieImgs=[String]()
    let reuseIdentifier="Cell"
    let sectionInsets=UIEdgeInsetsMake(25.0, 10.0, 25.0, 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        for i in 1...22{
            laniImgs.append("lani"+String(i))
        }
        for i in 1...3{
            mozzieImgs.append("mozzie"+String(i))
        }
        print(mozzieImgs)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="showDetail"{
            let indexPath = collectionView?.indexPath(for: sender as! CollectionViewCell)
            let detailVC=segue.destination as! DetailViewController
            detailVC.imageName=laniImgs[(indexPath?.row)!]
            
        }
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
            return mozzieImgs.count
        } else {
            return laniImgs.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section==0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
            let image=UIImage(named: mozzieImgs[indexPath.row])
            cell.imageView.image=image
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
            let image=UIImage(named: laniImgs[indexPath.row])
            cell.imageView.image=image
            return cell
        }
        
        
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section==0{
            let image=UIImage(named:mozzieImgs[indexPath.row])
            let newSize=CGSize(width: (image?.size.width)!/18, height:(image?.size.height)!/18)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            let rect = CGRect(x:0, y:0, width:newSize.width, height: newSize.height)
            image?.draw(in: rect)
            let image2=UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return (image2?.size)!
        } else{
            let image=UIImage(named:laniImgs[indexPath.row])
            let newSize=CGSize(width: (image?.size.width)!/18, height:(image?.size.height)!/18)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            let rect = CGRect(x:0, y:0, width:newSize.width, height: newSize.height)
            image?.draw(in: rect)
            let image2=UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return (image2?.size)!
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: CollectionSupplementaryView?
        var footer: CollectionSupplementaryFooterView?
        if kind == UICollectionElementKindSectionHeader{
            if indexPath.section==0{
                header=collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? CollectionSupplementaryView
                header?.headerLabel.text="Mozzie"
                return header!
            } else{
                header=collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? CollectionSupplementaryView
                header?.headerLabel.text="Lani"
                return header!
            }
            
        } else{
            if indexPath.section==0{
                footer=collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? CollectionSupplementaryFooterView
                footer?.footerLabel.text="Taken: 2017"
                return footer!
            } else{
                footer=collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? CollectionSupplementaryFooterView
                footer?.footerLabel.text="Taken: 2012-Present"
                return footer!
            }
            
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
