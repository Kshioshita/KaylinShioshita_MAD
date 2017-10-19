//
//  ViewController.swift
//  Lab4
//
//  Created by Kaylin Shioshita on 10/16/17.
//  Copyright © 2017 Kaylin Shioshita. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var secretLabel: UILabel!
    var user=Secret()
    let filename="secret.plist"
    
    @IBAction func revealSecret(_ sender: UIButton) {
        print(user.secretText!)
        print(user.password!)
        if (enterPasswordTextField.text==user.password){
            secretLabel.text=user.secretText
        } else{
            secretLabel.text="Enter the Correct Password"
        }
//        else {
//            secretLabel.text="Enter the Password"
//        }
    }
    
    func docFilePath(_ filename: String) -> String? {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString
        return dir.appendingPathComponent(filename)
        
    }
    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        secretLabel.text=""
        enterPasswordTextField.text=""
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        enterPasswordTextField.delegate=self
        
        let filePath = docFilePath(filename)
        if FileManager.default.fileExists(atPath: filePath!){
            let path = filePath
            let dataDictionary = NSDictionary(contentsOfFile: path!) as! [String:String]
            if dataDictionary.keys.contains("password") {
                user.password=dataDictionary["password"]
            }
            if dataDictionary.keys.contains("secret") {
                user.secretText=dataDictionary["secret"]
                print(dataDictionary["secret"]!)
            }
        }
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func applicationWillResignActive(_ notification: Notification){
        let filePath = docFilePath(filename)
        let data = NSMutableDictionary()
        if user.password != nil {
            data.setValue(user.password, forKey: "password")
        }
        if (user.secretText != nil){
            data.setValue(user.secretText, forKey: "secret")
        }
        data.write(toFile: filePath!, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

