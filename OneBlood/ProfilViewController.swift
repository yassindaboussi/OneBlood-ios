//
//  ProfilViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 13/04/2022.
//

import UIKit

class ProfilViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func ClickEdit(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: sender)
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
