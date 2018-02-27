//
//  DetailViewController.swift
//  Lab3
//
//  Created by Kaylin Shioshita on 2/26/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func share(_ sender: UIBarButtonItem) {
        var imageArray=[UIImage]()
        imageArray.append(imageView.image!)
        let shareScreen = UIActivityViewController(activityItems:imageArray, applicationActivities: nil)
        shareScreen.modalPresentationStyle = .popover
        shareScreen.popoverPresentationController?.barButtonItem = sender
        present(shareScreen, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let name = imageName{
            imageView.image=UIImage(named:name)
        }
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
