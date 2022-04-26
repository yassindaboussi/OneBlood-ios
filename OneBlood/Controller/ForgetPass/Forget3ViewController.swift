//
//  Forget3ViewController.swift
//  OneBlood
//
//  Created by Mac-Mini_2021 on 26/04/2022.
//

import UIKit

class Forget3ViewController: UIViewController {

    @IBOutlet weak var iconeyeconfirmpass: UIButton!
    @IBOutlet weak var iconeyenewpass: UIButton!
    @IBOutlet weak var confirmpass: UITextField!
    @IBOutlet weak var newpass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    

    @IBAction func GotoLogin(_ sender: Any) {
        performSegue(withIdentifier: "GoHome", sender: sender)
    }
}
