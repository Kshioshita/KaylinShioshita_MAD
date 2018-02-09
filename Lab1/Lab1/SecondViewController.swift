//
//  SecondViewController.swift
//  Lab1
//
//  Created by Kaylin Shioshita on 2/6/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var moviesDictionary = [String: [String:String]]()
    var movies = [String]()
    var characters = [String]()
    let characterComp = 1
    let movieComp = 0
    
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var actorImg: UIImageView!
    @IBOutlet weak var characterPicker: UIPickerView!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == movieComp{
            return movies.count
        } else {
            return characters.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component==movieComp{
            return movies[row]
            
        } else{
            return characters[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component==movieComp{
            let selectedMovie=movies[row]
            characters = Array(moviesDictionary[selectedMovie]!.keys)
//            print(characters)
            characterPicker.reloadComponent(characterComp)
            characterPicker.selectRow(0, inComponent: characterComp, animated: true)
            let firstCharacter = characters[0]
            let firstActor:String = moviesDictionary[selectedMovie]![firstCharacter]!
            actorLabel.text="\(firstCharacter) is played by \(firstActor)"
            let imgName = firstActor.components(separatedBy: .whitespacesAndNewlines).joined().lowercased()
            actorImg.image=UIImage(named:imgName)
        } else{
            let selectedCharacter = characters[row]
            let movieRow=movies[characterPicker.selectedRow(inComponent: 0)]
            print("Selected Character is \(selectedCharacter)")
            let actorName:String = moviesDictionary[movieRow]![selectedCharacter]!
            print(actorName)
            let imgName = actorName.components(separatedBy: .whitespacesAndNewlines).joined().lowercased()
            print(imgName)
            actorLabel.text="\(selectedCharacter) is played by \(actorName)"
            actorImg.image=UIImage(named:imgName)
        }
    }
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
        let initialMovie=movies[characterPicker.selectedRow(inComponent: movieComp)]
        characters=Array(moviesDictionary[initialMovie]!.keys)
        characterPicker.reloadComponent(characterComp)
        characterPicker.selectRow(0, inComponent: characterComp, animated: true)
        print(initialMovie)
        let firstCharacter = characters[0]
        let firstActor:String = moviesDictionary[initialMovie]![firstCharacter]!
        actorLabel.text="\(firstCharacter) is played by \(firstActor)"
        let imgName = firstActor.components(separatedBy: .whitespacesAndNewlines).joined().lowercased()
        actorImg.image=UIImage(named:imgName)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

