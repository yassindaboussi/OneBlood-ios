//
//  ConditionViewController.swift
//  OneBlood
//
//  Created by Apple Esprit on 8/4/2022.
//

import UIKit

class ConditionViewController: UIViewController {

    @IBOutlet weak var CheckCondition: UISwitch!
    @IBOutlet weak var BtnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnNext.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    @IBAction func GoToSignUp1(_ sender: Any) {
        if CheckCondition.isOn {
            performSegue(withIdentifier: "SignUp1", sender: sender)
        }
        else{
            CheckCondition.shake()
        }
            
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
