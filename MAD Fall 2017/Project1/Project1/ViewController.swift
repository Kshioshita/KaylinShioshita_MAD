//
//  ViewController.swift
//  Project1
//
//  Created by Kaylin Shioshita on 10/1/17.
//  Copyright © 2017 Kaylin Shioshita. All rights reserved.
//
/* Sources
    https://stackoverflow.com/questions/5712937/how-to-make-uibuttons-text-alignment-center-using-ib
    https://makeapppie.com/2014/10/21/swift-swift-formatting-a-uipickerview/
    https://stackoverflow.com/questions/40982940/uipickerview-default-row
    https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f
    https://medium.com/@nrewik/easy-line-drawing-animation-b56958bc2bee
 */
import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var minPickerLabel: UILabel!
    @IBOutlet weak var hrPickerLabel: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var timePicker: UIPickerView!
    private let minComponents = 0
    private let secComponents = 1
    private let minutesPicker = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    private let secPicker = ["0", "15", "30", "45"]
    private let steps = ["Step 1:\nOil Cleanser", "Step 2:\nCleanser", "Step 3:\nExfoliator", "Step 4:\nToner", "Step 5:\nEssence", "Step 6:\nTreatments", "Step 7:\nSheet Mask", "Step 8:\nEye Cream", "Step 9:\nMoisturizer", "Step 10:\nSunscreen"]
    private let defaultTime = [1, 2, 2, 1, 1, 1, 20, 1, 1, 1]
    var stepCounter = 0
    var hidePicker=false
    var seconds=0
    var originalSeconds=0
    var timer=Timer()
    var isTimerRunning = false //used to make sure only one timer is created at a time
    var resumeTapped=false
    var startingTime:Double = 0
    
    let circlePath = CAShapeLayer()
    let circlePathBackground = CAShapeLayer()
    var endPoint:Float=0
    
    @IBOutlet weak var pathView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseButton.isEnabled=false
        resetButton.isEnabled=false
        circlePathBackground.path=ringPath.cgPath
        circlePathBackground.fillColor=UIColor.clear.cgColor
        circlePathBackground.strokeColor=UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha:0.8).cgColor
        circlePathBackground.lineWidth = 4.0
        pathView.layer.addSublayer(circlePathBackground)
        circlePath.strokeEnd=CGFloat(0)
        circlePath.path=ringPath.cgPath
        circlePath.fillColor=UIColor.clear.cgColor
        circlePath.strokeColor=UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        circlePath.lineWidth = 4.0
        pathView.layer.addSublayer(circlePath)
        
        self.timePicker.selectRow(1, inComponent: 0, animated: false)
        self.timePicker.selectRow(0, inComponent: 1, animated: false)
        
        nextButton.setAttributedTitle(NSAttributedString(string: steps[stepCounter+1]), for: .normal)
        nextButton.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        let minP = timePicker.selectedRow(inComponent: 0)
        let secP = timePicker.selectedRow(inComponent: 1)
        if (minP == 0 && secP == 0){
            let alertAddTime=UIAlertController(title: "Warning", message: "Add time to start", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction=UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            alertAddTime.addAction(cancelAction)
            let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                self.timePicker.selectRow(self.defaultTime[self.stepCounter], inComponent: 0, animated: false)
                self.timePicker.selectRow(0, inComponent: 1, animated: false)
            })
            alertAddTime.addAction(okAction)
            //present alert
            present(alertAddTime, animated: true, completion: nil)
            
        } else {
            if isTimerRunning==false {
                runTimer()
                self.startButton.isEnabled=false
                resetButton.isEnabled=true
            }
            
            
            seconds=(minP)*60
            seconds+=(secP*15)
            originalSeconds=seconds
            timePicker.isHidden=true
            minPickerLabel.text=""
            hrPickerLabel.text=""
            timeLabel.text=timeString(time: TimeInterval(seconds))
        }
        
        
    }
    
    @IBAction func pauseTimer(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.pauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func resetTimer(_ sender: UIButton) {
        reset()
    }
    
    func reset(){
        timer.invalidate()
        timePicker.isHidden=false
        minPickerLabel.text="m"
        hrPickerLabel.text="s"
        timeLabel.text=""
        let minP = timePicker.selectedRow(inComponent: 0)
        let secP = timePicker.selectedRow(inComponent: 1)
        seconds=(minP)*60
        seconds+=(secP*15)
//        timeLabel.text=timeString(time: TimeInterval(seconds))
        isTimerRunning=false
        resumeTapped=false
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        self.resetButton.isEnabled = false
        circlePath.strokeEnd=CGFloat(0)
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    
    func updateTimer() {
        if seconds<1 {
            timer.invalidate()
            reset()
            if (stepCounter==9){
                let alert=UIAlertController(title: "Time's Up!", message: "You've completed your 10 Step Korean Skin Care Routine!", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction=UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(cancelAction)
                let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                    if(self.stepCounter<9){
                        self.stepCounter+=1
                        self.displayNext()
                    } else{
                        self.stepCounter=0
                        self.displayNext()
                    }
                })
                alert.addAction(okAction)
                //present alert
                present(alert, animated: true, completion: nil)
            } else {
                let alert=UIAlertController(title: "Time's Up!", message: "Move on to the next step", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction=UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(cancelAction)
                let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                    if(self.stepCounter<9){
                        self.stepCounter+=1
                        self.displayNext()
                    } else{
                        self.stepCounter=0
                        self.displayNext()
                    }
                })
                alert.addAction(okAction)
                //present alert
                present(alert, animated: true, completion: nil)
            }

            
        } else {
            seconds-=1
            timeLabel.text=timeString(time: TimeInterval(seconds))
//            redraw end point
            circlePath.removeAllAnimations()
            circlePath.strokeEnd=CGFloat(1-Float(Float(seconds)/Float(originalSeconds)))
        }
        
    }
    
    func timeString(time:TimeInterval)->String{
//        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    var ringPath: UIBezierPath{
        let bezierPath = UIBezierPath()
        let arcCenter = CGPoint(x: 125, y: 125)
        bezierPath.addArc(withCenter: arcCenter, radius: 125.0, startAngle:.pi*3/2, endAngle: CGFloat(Double.pi*7/2), clockwise: true)
        return bezierPath
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == minComponents{
            return minutesPicker.count
        } else {
            return secPicker.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component==minComponents{
            return minutesPicker[row]
        } else {
            return secPicker[row]
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        if component==minComponents{
//            let rawTextLabel=minutesPicker[row]
//            let formatedTitle=NSAttributedString(string: rawTextLabel, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 0.5, weight: 17.0)])
//            return formatedTitle
//        } else {
//            let rawTextLabel=secPicker[row]
//            let formatedTitle=NSAttributedString(string: rawTextLabel, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 20.0, weight: 10.0)])
//            return formatedTitle
//        }
//        
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component==minComponents{
            let pickerTitle=UILabel()
            let rawTextLabel=minutesPicker[row]
            let formatedTitle=NSAttributedString(string: rawTextLabel, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 40.0, weight: UIFontWeightUltraLight)])
            pickerTitle.attributedText=formatedTitle
            pickerTitle.textAlignment = .right
            return pickerTitle
        } else {
            let pickerTitle=UILabel()
            let rawTextLabel=secPicker[row]
            let formatedTitle=NSAttributedString(string: rawTextLabel, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 40.0, weight: UIFontWeightUltraLight)])
            pickerTitle.attributedText=formatedTitle
            pickerTitle.textAlignment = .right
            return pickerTitle
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(50)
    }
    @IBOutlet weak var stepTitleLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startOver: UIButton!
    
    @IBAction func prevPushed(_ sender: UIButton) {
        reset()
        if(stepCounter>0){
            stepCounter-=1
        }
        displayNext()
    }
    
    @IBAction func startOverPushed(_ sender: UIButton) {
        reset()
        stepCounter=0
//        displayPrev()
        displayNext()
    }
    
    @IBAction func nextPushed(_ sender: UIButton) {
        reset()
//        displayPrev()
        if (stepCounter<9){
            stepCounter+=1
        }
        displayNext()
    }
    
    func displayNext(){
        print(stepCounter)
        if(stepCounter==9){
            nextButton.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
            stepTitleLabel.text=steps[stepCounter]
            startOver.setTitle("Start Over", for: .normal)
            let backImgString="background"+String(stepCounter)
            backgroundImg.image=UIImage(named: backImgString)
            nextButton.titleLabel?.textAlignment = NSTextAlignment.center
            self.timePicker.selectRow(defaultTime[stepCounter], inComponent: 0, animated: false)
            self.timePicker.selectRow(0, inComponent: 1, animated: false)

        } else if (stepCounter==0){
            startOver.setTitle("", for: .normal)
            let backImgString="background"+String(stepCounter)
            startOver.setTitle("Start Over", for: .normal)
            backgroundImg.image=UIImage(named: backImgString)
            prevButton.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
            nextButton.setAttributedTitle(NSAttributedString(string: steps[stepCounter+1]), for: .normal)
            stepTitleLabel.text=steps[stepCounter]
            nextButton.titleLabel?.textAlignment = NSTextAlignment.center
            self.timePicker.selectRow(defaultTime[stepCounter], inComponent: 0, animated: false)
            self.timePicker.selectRow(0, inComponent: 1, animated: false)

        } else{
            let backImgString="background"+String(stepCounter)
            backgroundImg.image=UIImage(named: backImgString)
            startOver.setTitle("Start Over", for: .normal)
            prevButton.setAttributedTitle(NSAttributedString(string: steps[stepCounter-1]), for: .normal)
            nextButton.setAttributedTitle(NSAttributedString(string: steps[stepCounter+1]), for: .normal)
            nextButton.titleLabel?.textAlignment = NSTextAlignment.center
            prevButton.titleLabel?.textAlignment = NSTextAlignment.center
            stepTitleLabel.text=steps[stepCounter]
            self.timePicker.selectRow(defaultTime[stepCounter], inComponent: 0, animated: false)
            self.timePicker.selectRow(0, inComponent: 1, animated: false)
            
        }
    }
    
//    func displayPrev(){
//        if(stepCounter==0){
//            prevButton.setTitle("", for: .normal)
//        } else {
//            nextButton.setTitle(steps[stepCounter], for: .normal)
////            stepTitleLabel.text=steps[stepCounter-1]
////            stepCounter-=1
//        }
//    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == minComponents{
            return CGFloat (50.0)
        }else {
            return CGFloat(70.0)
        }
//        return CGFloat(60)
    }
    
    
   
    

}

