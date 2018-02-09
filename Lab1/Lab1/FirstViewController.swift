//
//  FirstViewController.swift
//  Lab1
//
//  Created by Kaylin Shioshita on 2/6/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    var moviesDictionary = [String: [String:String]]()
    var movies = [String]()
    var characters = [String:String]()
    let posters = ["star", "godfather", "frankenstein", "field", "jaws", "snow", "wizard" ]
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var moviePicker: UIPickerView!
    @IBAction func gotoMovie(_ sender: UIButton) {
        if(UIApplication.shared.canOpenURL(URL(string:"imdb://")!)){
            UIApplication.shared.open(URL(string:"imdb://")!, options:[:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string:"http://www.imdb.com/")!, options: [:], completionHandler: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        print(movies[row])
        return movies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentMovie=movies[row]
        if currentMovie == "Star Wars V" {
            posterImg.image=UIImage(named: "star")
        } else if currentMovie == "The Godfather" {
            posterImg.image=UIImage(named: "godfather")
        } else if currentMovie == "Frankenstein" {
            posterImg.image=UIImage(named: "frank")
        } else if currentMovie == "Field of Dreams"{
            posterImg.image=UIImage(named: "field")
        } else if currentMovie == "Jaws"{
            posterImg.image=UIImage(named: "jaws")
        } else if currentMovie == "Snow White"{
            posterImg.image=UIImage(named: "snow")
        } else if currentMovie == "Wizard of Oz"{
            posterImg.image=UIImage(named: "wizard")
        }
        
        print(movies[row])
    }
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 80
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let pathURL = Bundle.main.url(forResource: "movies", withExtension: "plist"){
            let plistdecoder=PropertyListDecoder()
            do{
                let data = try Data(contentsOf:pathURL)
                moviesDictionary = try plistdecoder.decode([String:[String:String]].self, from:data)
//                print(Array(moviesDictionary.keys))
                movies = Array(moviesDictionary.keys)
//                print(Array(moviesDictionary.values))
            } catch {
                print(error)
            }
        }
//        print(moviesDictionary["Wizard of Oz"]!)
//        print(movies)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

