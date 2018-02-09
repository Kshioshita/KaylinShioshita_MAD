//
//  ThirdViewController.swift
//  Lab1
//
//  Created by Kaylin Shioshita on 2/8/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//


//Sources
//System Sound Services
//https://cafecode.co/posts/playing-short-sounds-in-ios-with-swift-3/

import UIKit
import AudioToolbox

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var moviesDictionary = [String: [String:String]]()
    var movies = [String]()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var wrongQuote: UILabel!
    @IBOutlet weak var actualQuote: UILabel!
    @IBOutlet weak var moviePicker: UIPickerView!
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return movies[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedMovie=movies[row]
        if selectedMovie == "Star Wars V" {
            wrongQuote.text="Misquote: Luke, I am your father"
            actualQuote.text="Actual Quote: No. I am your father"
        } else if selectedMovie == "The Godfather" {
            wrongQuote.text="Misquote: I wanna make him an offer he can't refuse."
            actualQuote.text="Actual Quote: I'm gonna make him an offer he can't refuse."
        } else if selectedMovie == "Frankenstein" {
            wrongQuote.text="Misquote: He's alive!"
            actualQuote.text="Actual Quote: It's alive!"
        } else if selectedMovie == "Field of Dreams"{
            wrongQuote.text="Misquote: If you build it, they will come"
            actualQuote.text="Actual Quote: If you build it, he will come"
        } else if selectedMovie == "Jaws"{
            wrongQuote.text="Misquote: We're gonna need a bigger boat"
            actualQuote.text="Actual Quote: You're gonna need a bigger boat"
        } else if selectedMovie == "Snow White"{
            wrongQuote.text="Misquote: Mirror, mirror, on the wall - who is the fairset of them all?"
            actualQuote.text="Actual Quote: Magic mirror, on the wall - who is the fairest of them all?"
        } else if selectedMovie == "Wizard of Oz"{
            wrongQuote.text="Misquote: Toto, I don't think we're in Kansas anymore"
            actualQuote.text="Actual Quote: Toto, I've a feeling we're not in Kansas anymore"
        }
    }

    @IBAction func playMusic(_ sender: UIButton) {
        let selectedRow=moviePicker.selectedRow(inComponent: 0)
        let selectedMovie=movies[selectedRow]
        let filename = selectedMovie.components(separatedBy: .whitespacesAndNewlines).joined().lowercased()
        let ext="wav"
        if let soundurl = Bundle.main.url(forResource: filename, withExtension: ext){
            print("here")
            var soundid: SystemSoundID=0
            AudioServicesCreateSystemSoundID(soundurl as CFURL, &soundid)
            AudioServicesAddSystemSoundCompletion(soundid, nil, nil, {(soundid, clientData)->Void in AudioServicesDisposeSystemSoundID(soundid)}, nil)
            AudioServicesPlaySystemSound(soundid)
        }

        
        print(filename)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
