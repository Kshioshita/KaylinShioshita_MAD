//
//  AddEntryViewController.swift
//  Project1
//
//  Created by Kaylin Shioshita on 3/5/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

//Resources
// Placeholder text for textview
// https://stackoverflow.com/questions/27652227/text-view-placeholder-swift
// Scroll View
// https://stackoverflow.com/questions/28144739/swift-uiscrollview-not-scrolling
// https://medium.com/@dzungnguyen.hcm/autolayout-for-scrollview-keyboard-handling-in-ios-5a47d73fd023
// Change Text of Bar Button
// https://ryanjin.weebly.com/technology/swift-how-to-change-the-title-text-of-a-uibarbuttonitem-in-swift
// Stop Segue if Condition not selected
// http://jamesleist.com/ios-swift-tutorial-stop-segue-show-alert-text-box-empty/

import UIKit
import RealmSwift

class AddEntryViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var scrollHeightConstraint: NSLayoutConstraint!
    var lastOffset: CGPoint!
    var activeField: UITextView?
    var keyboardHeight: CGFloat!

   
    
    var realm : Realm!
    
    var newDay=Day()
    var daycode=String()
    var selectedCond:Int?
    var oil = false
    var cleanser=false
    var exfoliator=false
    var toner=false
    var essence=false
    var treatment=false
    var mask=false
    var eye=false
    var moisturizer=false
    var sun=false
    var other=false
    var reloadDay=Day()
    var reload=false
    var sendUpdatedEntry = false
    var entryrow = -1
    
    @IBOutlet weak var saveBarbtn: UIBarButtonItem!
    @IBOutlet weak var cancelBarbtn: UIBarButtonItem!
    @IBOutlet weak var timeControl: UISegmentedControl!
    @IBOutlet weak var textBox: UITextView!
    
    @IBOutlet weak var greatBtn: UIButton!
    @IBOutlet weak var goodBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var badBtn: UIButton!
    @IBOutlet weak var terribleBtn: UIButton!
    
    @IBOutlet weak var oilBtn: UIButton!
    @IBOutlet weak var waterBtn: UIButton!
    @IBOutlet weak var exfoliatorBtn: UIButton!
    @IBOutlet weak var tonerBtn: UIButton!
    @IBOutlet weak var essenceBtn: UIButton!
    @IBOutlet weak var treatmentBtn: UIButton!
    @IBOutlet weak var maskBtn: UIButton!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var moisturizerBtn: UIButton!
    @IBOutlet weak var sunBtn: UIButton!
    @IBOutlet weak var otherBtn: UIButton!
    
    @IBOutlet weak var oilLabel: UILabel!
    @IBOutlet weak var cleanserLabel: UILabel!
    @IBOutlet weak var exfoliatorLabel: UILabel!
    @IBOutlet weak var tonerLabel: UILabel!
    @IBOutlet weak var essenceLabel: UILabel!
    @IBOutlet weak var treatmentLabel: UILabel!
    @IBOutlet weak var maskLabel: UILabel!
    @IBOutlet weak var eyeLabel: UILabel!
    @IBOutlet weak var moisturizerLabel: UILabel!
    @IBOutlet weak var sunLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.delegate=self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        view.addSubview(scrollview)
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        //        self.saveBarbtn.title="Done"
        //        let item=self.navigationItem.rightBarButtonItem
        //        let button = item!.customView as! UIButton
        //        button.setTitle("Done", for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    //    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    //
    //    @objc func keyboardNotification(notification: NSNotification){
    //        if let user = notification.userInfo{
    //            let endframe=(user[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    //            let endyframe = endframe?.origin.y ?? 0
    //            let duration: TimeInterval = (user[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
    //            let animationCurveRawNSN = user[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
    //            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
    //            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue:animationCurveRaw)
    //            if endyframe >= UIScreen.main.bounds.size.height{
    //                self.keyboardHeightLayoutConstraint?.constant = 0.0
    //                print("keyboard move")
    //            } else{
    //                self.keyboardHeightLayoutConstraint?.constant=endframe?.size.height ?? -10.0
    //                print("keyboard move2")
    //
    //            }
    //            UIView.animate(withDuration: duration, delay:TimeInterval(0), options: animationCurve, animations: {self.view.layoutIfNeeded()}, completion: nil)
    //        }
    //    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        let device=UIScreen.main.traitCollection.userInterfaceIdiom
        let screenWidth=UIScreen.main.bounds.width
        switch (device) {
        case .phone:
            switch UIDevice.current.orientation{
            case .landscapeRight:
                if screenWidth >= 800 {
                    scrollview.contentSize = CGSize(width: 375, height: 1100)
                } else{
                   scrollview.contentSize = CGSize(width: 375, height: 1100)
                }
            case .landscapeLeft:
                if screenWidth >= 800 {
                    scrollview.contentSize = CGSize(width: 375, height: 1100)
                } else{
                    scrollview.contentSize = CGSize(width: 375, height: 1100)
                }
            default:
                print("portrait")
//                scrollview.contentSize = CGSize(width: screenWidth, height: UIScreen.main.bounds.height)
            }
        default: print("portait")
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        textBox.text="Notes"
        textBox.textColor=UIColor.lightGray
        if reload{
            //            print("reloading day data")
            self.navigationItem.leftBarButtonItem!=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
            self.navigationItem.rightBarButtonItem!=UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddEntryViewController.unwindfromreload(_:)))
            textBox.textColor=UIColor.black
            for step in reloadDay.steps{
                if step=="Oil Cleanser"{
                    oilBtn.setImage(UIImage(named:"oil-s"), for: .normal)
                } else if step=="Water Based Cleanser"{
                    waterBtn.setImage(UIImage(named:"water-s"), for: .normal)
                } else if step=="Exfoliator"{
                    exfoliatorBtn.setImage(UIImage(named:"exfoliator-s"), for: .normal)
                } else if step == "Toner"{
                    tonerBtn.setImage(UIImage(named:"toner-s"), for: .normal)
                } else if step == "Essence"{
                    essenceBtn.setImage(UIImage(named:"essence-s"), for: .normal)
                } else if step=="Treatments"{
                    treatmentBtn.setImage(UIImage(named:"treatment-s"), for: .normal)
                } else if step == "Sheet Mask"{
                    maskBtn.setImage(UIImage(named:"mask-s"), for: .normal)
                } else if step == "Eye Cream"{
                    eyeBtn.setImage(UIImage(named:"eye-s"), for: .normal)
                } else if step == "Moisturizer"{
                    moisturizerBtn.setImage(UIImage(named:"moisturizer-s"), for: .normal)
                } else if step == "Sunscreen"{
                    sunBtn.setImage(UIImage(named:"sun-s"), for: .normal)
                } else if step == "Other"{
                    otherBtn.setImage(UIImage(named:"other-s"), for: .normal)
                }
            }
            
            textBox.text=reloadDay.notes
            timeControl.selectedSegmentIndex=reloadDay.timeofday
            conditionChange(condition: reloadDay.condition)
            
            
        }
        
        
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        activeField=textView
        lastOffset=self.scrollview.contentOffset
        let device=UIScreen.main.traitCollection.userInterfaceIdiom
        let screenWidth=UIScreen.main.bounds.width
        switch (device) {
        case .phone:
            switch UIDevice.current.orientation{
            case .landscapeRight:
                if screenWidth >= 800 {
                    scrollview.contentSize = CGSize(width: 375, height: 1100)
                } else{
                    scrollview.contentSize = CGSize(width: 375, height: 1100)
                }
            case .landscapeLeft:
                if screenWidth >= 800 {
                    scrollview.contentSize = CGSize(width: 375, height: 1100)
                } else{
                    scrollview.contentSize = CGSize(width: 375, height: 1100)
                }
            default:
                print("portrait inside shouldend")
                scrollview.contentSize = CGSize(width: screenWidth, height: UIScreen.main.bounds.height)
            }
        default: print("portait")
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textBox.textColor==UIColor.lightGray{
            textBox.text=nil
            textBox.textColor=UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textBox.text.isEmpty{
            textView.text="Notes"
            textView.textColor=UIColor.lightGray
        }
        textView.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any){
        print("done typing")
        textBox.resignFirstResponder()
        activeField=nil

    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if keyboardHeight != nil{
            return
        }
        
        if let keyboardsize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboardHeight=keyboardsize.height
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollHeightConstraint.constant += (self.keyboardHeight+400)
                })
//            let distanceToBottom = self.scrollview.frame.size.height - (activeField?.frame.origin.y)!
            let collapseSpace = keyboardHeight as CGFloat
            if collapseSpace < 0 {
                return
            }
            UIView.animate(withDuration: 0.3, animations: {
                print("moving scroll view")
                self.scrollview.contentOffset = CGPoint(x:0, y:collapseSpace)
            })
            
        }
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        UIView.animate(withDuration: 0.3){
            self.scrollHeightConstraint.constant -= 0
            self.scrollview.contentOffset=CGPoint(x:0,y:0)
        }
        keyboardHeight=nil
    }
    
    @IBAction func oilBtnPushed(_ sender: UIButton) {
        
        oil = !oil
        if oil{
            oilBtn.setImage(UIImage(named:"oil-s"), for: .normal)
            oilLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        } else{
            oilBtn.setImage(UIImage(named:"oil"), for: .normal)
            oilLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    @IBAction func cleanserbtnPushed(_ sender: UIButton) {
        cleanser = !cleanser
        if cleanser{
            waterBtn.setImage(UIImage(named:"water-s"), for: .normal)
            cleanserLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        }else{
            waterBtn.setImage(UIImage(named:"water"), for: .normal)
            cleanserLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
        
    }
    @IBAction func exfoliatorbtnPushed(_ sender: UIButton) {
        exfoliator = !exfoliator
        if exfoliator{
            exfoliatorBtn.setImage(UIImage(named:"exfoliator-s"), for: .normal)
            exfoliatorLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        }else{
            exfoliatorBtn.setImage(UIImage(named:"exfoliator"), for: .normal)
            exfoliatorLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    @IBAction func tonerbtnPushed(_ sender: UIButton) {
        toner = !toner
        if toner{
            tonerBtn.setImage(UIImage(named:"toner-s"), for: .normal)
            tonerLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        } else{
            tonerBtn.setImage(UIImage(named:"toner"), for: .normal)
            tonerLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    @IBAction func essencebtnPushed(_ sender: UIButton) {
        essence = !essence
        if essence{
            essenceBtn.setImage(UIImage(named:"essence-s"), for: .normal)
            essenceLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        } else{
            essenceBtn.setImage(UIImage(named:"essence"), for: .normal)
            essenceLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    @IBAction func treatmentbtnPushed(_ sender: UIButton) {
        treatment = !treatment
        if treatment{
            treatmentBtn.setImage(UIImage(named:"treatment-s"), for: .normal)
            treatmentLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        }else{
            treatmentBtn.setImage(UIImage(named:"treatment"), for: .normal)
            treatmentLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    @IBAction func maskbtnPushed(_ sender: UIButton) {
        mask = !mask
        if mask{
            maskBtn.setImage(UIImage(named:"mask-s"), for: .normal)
            maskLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        }else{
            maskBtn.setImage(UIImage(named:"mask"), for: .normal)
            maskLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    @IBAction func eyebtnPushed(_ sender: UIButton) {
        eye = !eye
        if eye{
            eyeBtn.setImage(UIImage(named:"eye-s"), for: .normal)
            eyeLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        } else{
            eyeBtn.setImage(UIImage(named:"eye"), for: .normal)
            eyeLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    @IBAction func moisturizerbtnPushed(_ sender: UIButton) {
        moisturizer = !moisturizer
        if moisturizer{
            moisturizerBtn.setImage(UIImage(named: "moisturizer-s"), for: .normal)
            moisturizerLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        }else{
            moisturizerBtn.setImage(UIImage(named: "moisturizer"), for: .normal)
            moisturizerLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    @IBAction func sunbtnPushed(_ sender: UIButton) {
        sun = !sun
        if sun{
            sunBtn.setImage(UIImage(named:"sun-s"), for: .normal)
            sunLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        }else{
            sunBtn.setImage(UIImage(named:"sun"), for: .normal)
            sunLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    @IBAction func otherbtnPushed(_ sender: UIButton) {
        other = !other
        if other{
            otherBtn.setImage(UIImage(named:"other-s"), for: .normal)
            otherLabel.textColor=UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        }else{
            otherBtn.setImage(UIImage(named:"other"), for: .normal)
            otherLabel.textColor=UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        }
    }
    
    
    @IBAction func greatbtnPushed(_ sender: UIButton) {
        conditionChange(condition: 0)
    }
    @IBAction func goodBtnPushed(_ sender: UIButton) {
        conditionChange(condition: 1)
    }
    @IBAction func okbtnPushed(_ sender: UIButton) {
        conditionChange(condition: 2)
    }
    @IBAction func badbtnPushed(_ sender: UIButton) {
        conditionChange(condition:3)
    }
    @IBAction func terriblebtnPushed(_ sender: UIButton) {
        conditionChange(condition: 4)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier=="savesegue"{
            if selectedCond == nil{
                let alertAddCond=UIAlertController(title: "How is your skin?", message: "Select your skin's condition", preferredStyle: UIAlertControllerStyle.alert)
                let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                    
                })
                alertAddCond.addAction(okAction)
                //present alert
                present(alertAddCond, animated: true, completion: nil)
                
                return false
            }else{
                return true
            }
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="savesegue"{
            print("going back")
            if oil{
                newDay.steps.append("Oil Cleanser")
            }
            if cleanser{
                newDay.steps.append("Water Based Cleanser")
            }
            if exfoliator{
                newDay.steps.append("Exfoliator")
            }
            if toner{
                newDay.steps.append("Toner")
            }
            if essence{
                newDay.steps.append("Essence")
            }
            if treatment{
                newDay.steps.append("Treatments")
            }
            if eye{
                newDay.steps.append("Eye Cream")
            }
            if moisturizer{
                newDay.steps.append("Moisturizer")
            }
            if mask{
                newDay.steps.append("Sheet Mask")
            }
            if sun{
                newDay.steps.append("Sunscreen")
            }
            if other{
                newDay.steps.append("Other")
            }
            
            switch timeControl.selectedSegmentIndex {
            case 0:
                newDay.timeofday=0
            case 1:
                newDay.timeofday=1
            default:
                newDay.timeofday = -1
            }
            
            if textBox.text != "Notes"{
                newDay.notes=textBox.text
            }
            
            
            
            
            
            
        } else if segue.identifier=="cancelSegue"{
//            print("yay in add entry")
        }
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func conditionChange(condition:Int){
        switch condition {
        case 0:
            greatBtn.setImage(UIImage(named:"great-s"), for: .normal)
            goodBtn.setImage(UIImage(named:"good"), for: .normal)
            okBtn.setImage(UIImage(named:"fine"), for: .normal)
            badBtn.setImage(UIImage(named:"bad"), for: .normal)
            terribleBtn.setImage(UIImage(named:"terrible"), for: .normal)
            selectedCond=0
        case 1:
            greatBtn.setImage(UIImage(named:"great"), for: .normal)
            goodBtn.setImage(UIImage(named:"good-s"), for: .normal)
            okBtn.setImage(UIImage(named:"fine"), for: .normal)
            badBtn.setImage(UIImage(named:"bad"), for: .normal)
            terribleBtn.setImage(UIImage(named:"terrible"), for: .normal)
            selectedCond=1
        case 2:
            greatBtn.setImage(UIImage(named:"great"), for: .normal)
            goodBtn.setImage(UIImage(named:"good"), for: .normal)
            okBtn.setImage(UIImage(named:"fine-s"), for: .normal)
            badBtn.setImage(UIImage(named:"bad"), for: .normal)
            terribleBtn.setImage(UIImage(named:"terrible"), for: .normal)
            selectedCond=2
        case 3:
            greatBtn.setImage(UIImage(named:"great"), for: .normal)
            goodBtn.setImage(UIImage(named:"good"), for: .normal)
            okBtn.setImage(UIImage(named:"fine"), for: .normal)
            badBtn.setImage(UIImage(named:"bad-s"), for: .normal)
            terribleBtn.setImage(UIImage(named:"terrible"), for: .normal)
            selectedCond=3
        case 4:
            greatBtn.setImage(UIImage(named:"great"), for: .normal)
            goodBtn.setImage(UIImage(named:"good"), for: .normal)
            okBtn.setImage(UIImage(named:"fine"), for: .normal)
            badBtn.setImage(UIImage(named:"bad"), for: .normal)
            terribleBtn.setImage(UIImage(named:"terrible-s"), for: .normal)
            selectedCond=4
        default:
            greatBtn.setImage(UIImage(named:"great"), for: .normal)
            goodBtn.setImage(UIImage(named:"good"), for: .normal)
            okBtn.setImage(UIImage(named:"fine"), for: .normal)
            badBtn.setImage(UIImage(named:"bad"), for: .normal)
            terribleBtn.setImage(UIImage(named:"terrible"), for: .normal)
        }
    }
    
    
    
    @IBAction func unwindfromreload(_ sender: UIButton){
//        performSegue(withIdentifier: "cancelSegue", sender: self)
        sendUpdatedEntry=true
        performSegue(withIdentifier: "savesegue", sender: self)
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
