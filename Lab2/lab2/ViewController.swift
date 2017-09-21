//
//  ViewController.swift
//  lab2
//
//  Created by Kaylin Shioshita on 9/19/17.
//  Copyright © 2017 Kaylin Shioshita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var fontSizeCGFloat:CGFloat=16
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starryImg: UIImageView!
    @IBOutlet weak var pixelSwitch: UISwitch!
    @IBAction func updatePixel(_ sender: UISwitch) {
        if pixelSwitch.isOn {
            if infoControl.selectedSegmentIndex==0{
                starryImg.image=UIImage(named: "starry-pixel-img")
            } else if infoControl.selectedSegmentIndex==1{
                starryImg.image=UIImage(named: "vincentpixel")
            }
            
            titleLabel.font=UIFont(name: "Menlo", size:fontSizeCGFloat)
//            titleLabel.textColor = UIColor.blue
//            titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        } else {
            if infoControl.selectedSegmentIndex==0{
                starryImg.image=UIImage(named: "starry-img")
            } else if infoControl.selectedSegmentIndex==1{
                starryImg.image=UIImage(named: "vincent")
            }
            titleLabel.font=UIFont(name: "Avenir Next", size:fontSizeCGFloat)
        }
    }

    @IBOutlet weak var infoControl: UISegmentedControl!
    @IBAction func changeInfo(_ sender: UISegmentedControl) {
        updateImg()
        changeCap()
    }
    
    @IBOutlet weak var capSwitch: UISwitch!
    @IBAction func updateCap(_ sender: UISwitch) {
        changeCap()
    }
    
    @IBOutlet weak var fontLabel: UILabel!
    @IBAction func changeFontSize(_ sender: UISlider) {
        let fontSize=sender.value
        fontLabel.text=String(format: "%.0f", fontSize)
        fontSizeCGFloat=CGFloat(fontSize)
        titleLabel.font=UIFont.systemFont(ofSize: fontSizeCGFloat)
    }
    
    func changeCap(){
        if capSwitch.isOn {
            titleLabel.text=titleLabel.text?.uppercased()
        } else {
            titleLabel.text=titleLabel.text?.lowercased()
        }
    }
    
    func updateImg(){
        if infoControl.selectedSegmentIndex==0{
            titleLabel.text="The Starry Night"
            if pixelSwitch.isOn {
                starryImg.image=UIImage(named: "starry-pixel-img")
            } else {
                starryImg.image=UIImage(named: "starry-img")
            }
            
        } else if infoControl.selectedSegmentIndex==1{
            titleLabel.text="Vincent van Gogh"
            if pixelSwitch.isOn {
                starryImg.image=UIImage(named: "vincentpixel")
            } else {
                starryImg.image=UIImage(named: "vincent")
            }
        }
    }
}

