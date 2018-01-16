//
//  ViewController.swift
//  Midterm
//
//  Created by Kaylin Shioshita on 10/19/17.
//  Copyright © 2017 Kaylin Shioshita. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tankSlider: UISlider!
    @IBOutlet weak var tankLabel: UILabel!
    @IBOutlet weak var transportationImg: UIImageView!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var monthlySwitch: UISwitch!
    @IBOutlet weak var transportationSegment: UISegmentedControl!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gasLabel: UILabel!
    var gas:Float=0
    
    @IBAction func tankSliderChanged(_ sender: UISlider) {
        let gasAmount=sender.value
        tankLabel.text=String(format:"%.2f", gasAmount)+" gallons"
        checkTank()
    }
    @IBAction func calcCommute(_ sender: UIButton) {
        updateCommute()
        checkTank()
    }
    @IBAction func monthlyChanged(_ sender: UISwitch) {
        updateCommute()
        checkTank()
    }
    
    @IBAction func transportationChanged(_ sender: UISegmentedControl) {
        updateCommute()
        checkTank()
    }
    
    func checkTank(){
        updateCommute()
        let sliderValue=tankSlider.value
        if (sliderValue<gas){
            let alert=UIAlertController(title: "Warning", message: "You don't have enough gas in your tank", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction=UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(cancelAction)
            let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                
            })
            alert.addAction(okAction)
            //present alert
            present(alert, animated: true, completion: nil)
        }
    }
    func updateCommute(){
        if monthlySwitch.isOn{
            if (transportationSegment.selectedSegmentIndex==0){
                transportationImg.image=UIImage(named: "car_icon")
                if(tripTextField.text != ""){
                    let commuteTime = Float(tripTextField.text!)!/20*20
                    timeLabel.text=String(format: "%.2f", commuteTime) + " hours"
                    gas = Float(tripTextField.text!)!/24*20
                    gasLabel.text=String(format: "%.2f", gas)+" gallons"
                }
                
            } else if (transportationSegment.selectedSegmentIndex==1){
                transportationImg.image=UIImage(named: "bus_icon")
                gas=0
                if(tripTextField.text != ""){
                    let commuteTime = (Float(tripTextField.text!)!/12+10)*20
                    timeLabel.text=String(format: "%.2f", commuteTime)+" hours"
                    gasLabel.text="0 gallons"
                }
            } else {
                gas=0
                transportationImg.image=UIImage(named: "bike_icon")
                if(tripTextField.text != ""){
                    let commuteTime = Float(tripTextField.text!)!/10*20
                    timeLabel.text=String(format: "%.2f", commuteTime)+" hours"
                    gasLabel.text="0 gallons"
                }
            }
        } else {
            if (transportationSegment.selectedSegmentIndex==0){
                transportationImg.image=UIImage(named: "car_icon")
                if(tripTextField.text != ""){
                    let commuteTime = Float(tripTextField.text!)!/20*60
                    timeLabel.text=String(commuteTime) + " mins"
                    gas = Float(tripTextField.text!)!/24
                    gasLabel.text=String(format: "%.2f", gas)+" gallons"
                }
                
            } else if (transportationSegment.selectedSegmentIndex==1){
                gas=0
                transportationImg.image=UIImage(named: "bus_icon")
                if(tripTextField.text != ""){
                    let commuteTime = (Float(tripTextField.text!)!/12+10)*60
                    timeLabel.text=String(commuteTime) + " mins"
                    gasLabel.text="0 gallons"
                }
            } else {
                transportationImg.image=UIImage(named: "bike_icon")
                gas=0
                if(tripTextField.text != ""){
                    let commuteTime = Float(tripTextField.text!)!/10*60
                    timeLabel.text=String(commuteTime) + " mins"
                    gasLabel.text="0 gallons"
                }
            }
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tripTextField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tripTextField.delegate=self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

