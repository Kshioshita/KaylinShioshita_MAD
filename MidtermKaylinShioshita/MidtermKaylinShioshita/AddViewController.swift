//
//  AddViewController.swift
//  MidtermKaylinShioshita
//
//  Created by Kaylin Shioshita on 3/15/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var addName: UITextField!
    @IBOutlet weak var addUrl: UITextField!
    var addedRest=Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="savesegue"{
            if(addName.text?.isEmpty==false && addUrl.text?.isEmpty==false){
                addedRest.name=addName.text!
                addedRest.url=addUrl.text!
            }
        }
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
