//
//  CollectionSupplementaryView.swift
//  Project1
//
//  Created by Kaylin Shioshita on 2/26/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class CollectionSupplementaryView: UICollectionReusableView {
    
//    var nextButtonPressed : ButtonAction?
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextMonth(_ sender: UIButton) {
        print("next")
//        var vc:CollectionViewController?
//        vc.nextButton.addTarget(self, action: #selector(CollectionViewController.nextMon(_:)), for: .touchUpInside)
    }
    
}
