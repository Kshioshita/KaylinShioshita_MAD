//
//  ViewController.swift
//  Lab3
//
//  Created by Kaylin Shioshita on 10/4/17.
//  Copyright © 2017 Kaylin Shioshita. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var singlePicker: UIPickerView!
    @IBOutlet weak var dollarsTextField: UITextField!
    @IBOutlet weak var estimateTextField: UITextField!
    @IBOutlet weak var estimateResultsLabel: UILabel!
    
    private let currencies = ["British Pound", "Indian Rupee", "Australian Dollar","Canadian Dollar", "Euro", "Japanese Yen", "Chinese Yuan", "South Korean Won", "Mexican Peso"]
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let row = singlePicker.selectedRow(inComponent: 0)
        let selected = currencies[row]
//        let title = "You selected \(selected)"
//        currencyLabel.text=title
        let money = Float(dollarsTextField.text!)
        var estimate = Float(estimateTextField.text!)
        var amount:Float
        amount=0
        if money != nil && money!>0{
            amount=convertMoney(row, money!)
            if row==5 || row==6 || row==7 {
                currencyLabel.text=String(format: "%.2f \(selected)", amount)
                dollarsTextField.text=""
                estimateTextField.text=""

            } else{
                currencyLabel.text=String(format: "%.2f \(selected)s", amount)
                dollarsTextField.text=""
                estimateTextField.text=""
            }
            
            if estimate != nil {
                let dif = abs(amount-estimate!)
                if row==5 || row==6 || row==7 {
                    estimateResultsLabel.text=String(format: "You estimated %.2f \(selected) from the actual result", dif)
                } else{
                    estimateResultsLabel.text=String(format: "You estimated %.2f \(selected)s from the actual result", dif)
                }
                
                
            } else{
                estimate = 0
                let dif = abs(amount-estimate!)
                if row==5 || row==6 || row==7 {
                    estimateResultsLabel.text=String(format: "You estimated %.2f \(selected) from the actual result", dif)
                } else{
                    estimateResultsLabel.text=String(format: "You estimated %.2f \(selected)s from the actual result", dif)
                }
                
            }
        } else{
            let alert=UIAlertController(title: "Warning", message: "Enter a dollar amount greater than 0", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction=UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancelAction)
            let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                self.dollarsTextField.text="1"
            })
            alert.addAction(okAction)
            //present alert
            present(alert, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    func convertMoney(_ row:Int, _ money:Float) -> Float {
        var converted:Float
        converted=0
        if(row==0){
            converted=money*(0.764183)
            
        } else if (row==1) {
            converted=money*(65.2623)
            
        } else if (row==2) {
            converted=money*(1.289)
            
        } else if (row==3) {
            converted=money*(1.258322)
            
        } else if (row==4) {
            converted=money*(0.854744)
            
        } else if (row==5) {
            converted=money*(112.9609)
            
        } else if (row==6) {
            converted=money*(6.6538)
            
        } else if (row==7) {
            converted=money*(1142.470599)
            
        } else if (row==8) {
            converted=money*(18.510541)
            
        }
        
        return converted
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dollarsTextField.delegate=self
        estimateTextField.delegate=self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField){
        sender.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        dollarsTextField.resignFirstResponder()
        estimateTextField.resignFirstResponder()
    }
}

