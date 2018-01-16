//
//  Scene2ViewController.swift
//  Lab4
//
//  Created by Kaylin Shioshita on 10/16/17.
//  Copyright © 2017 Kaylin Shioshita. All rights reserved.
//

import UIKit

class Scene2ViewController: UIViewController, UITextFieldDelegate {

    
   
    @IBOutlet weak var newSecret: UITextField!
    @IBOutlet weak var newPassword1: UITextField!
    @IBOutlet weak var newPassword2: UITextField!
    @IBOutlet weak var comparePasswordLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSecret" {
            print("Saved")
            let scene1controller=segue.destination as! ViewController
            if (newPassword1.text!.isEmpty==false) {
                    scene1controller.user.password=newPassword1.text
            }
            if (newSecret.text!.isEmpty==false){
                scene1controller.user.secretText=newSecret.text
            } else {
                scene1controller.user.secretText="No Secret Entered"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if newPassword1.text!.isEmpty==false && newPassword2.text!.isEmpty==false{
            let password1=newPassword1.text
            let password2=newPassword2.text
            if (password1 != password2){
                let alert=UIAlertController(title: "Warning", message: "Passwords don't match. Please make sure passwords are the same before proceeding", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction=UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(cancelAction)
                let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                    self.newPassword2.text=""
                })
                alert.addAction(okAction)
                //present alert
                present(alert, animated: true, completion: nil)
            }
        }
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newSecret.delegate=self
        newPassword1.delegate=self
        newPassword2.delegate=self

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
