//
//  ViewController.swift
//  lab1
//
//  Created by Kaylin Shioshita on 9/13/17.
//  Copyright © 2017 Kaylin Shioshita. All rights reserved.
//
/* Image sources
 http://3.bp.blogspot.com/_WzC9ND5G0Ps/SYc3IZAgcnI/AAAAAAAABds/TNkT__pAzCQ/s400/fists.jpg
 https://en.wikipedia.org/wiki/File:Hand3.png
 http://www.clipartpanda.com/categories/rock-clip-art
*/

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


    @IBOutlet weak var msgLabel: UILabel!
    
    var ranNum:UInt32 = arc4random_uniform(2) //Used to randomly select a scenario (whether to rock is in the left or right hand)
    
    @IBAction func chooseHand(_ sender: UIButton) {
        if ranNum == 0{ //rock is in right hand
            if sender.tag == 1 {
                handImage.image=UIImage(named: "empty") //Display empty hand and try again
                msgLabel.text="Try Again!"
            }
            else if sender.tag == 2 {
                handImage.image=UIImage(named: "rock") //Display rock in hand and congrats
                msgLabel.text="You found it!"
            }
        }
        else if ranNum == 1{ //rock is in the left hand
            if sender.tag == 1 {
                handImage.image=UIImage(named: "rock2")
                msgLabel.text="You found it!"
            }
            else if sender.tag == 2 {
                handImage.image=UIImage(named: "empty2")
                msgLabel.text="Try Again!"
            }
        }
        
    }

    @IBOutlet weak var againText: UIButton!
    
    @IBAction func playAgain(_ sender: UIButton) { //user wants to play again
        ranNum = arc4random_uniform(2) //Scenario is randomly chosen
        handImage.image=UIImage(named: "fists") //Show two fists again
        msgLabel.text="Pick a hand" //Reset instructions
    }
    @IBOutlet weak var handImage: UIImageView!
}

