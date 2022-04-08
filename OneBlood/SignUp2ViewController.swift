//
//  SignUp2ViewController.swift
//  OneBlood
//
//  Created by Apple Esprit on 8/4/2022.
//

import UIKit

class SignUp2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func FinishSignUp(_ sender: Any) {
        performSegue(withIdentifier: "Login", sender: sender)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
