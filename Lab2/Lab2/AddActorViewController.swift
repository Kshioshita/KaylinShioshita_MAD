//
//  AddActorViewController.swift
//  Lab2
//
//  Created by Kaylin Shioshita on 2/19/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class AddActorViewController: UIViewController {

    @IBOutlet weak var addActorTextField: UITextField!
    var addedActor=String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="doneSegue"{
            if((addActorTextField.text?.isEmpty)==false){
                addedActor=addActorTextField.text!
            }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
