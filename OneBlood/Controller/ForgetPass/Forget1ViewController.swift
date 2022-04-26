//
//  Forget1ViewController.swift
//  OneBlood
//
//  Created by Mac-Mini_2021 on 26/04/2022.
//

import UIKit

class Forget1ViewController: UIViewController {

    @IBOutlet weak var mygif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let setGif = UIImage.gifImageWithName("forgetpass");
        mygif.image = setGif
    }
    


    @IBAction func gotoforget2(_ sender: Any) {
        
        performSegue(withIdentifier: "forget2", sender: sender)    }
}
