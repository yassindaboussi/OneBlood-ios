//
//  PopOptionsViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 10/05/2022.
//

import UIKit

class PopOptionsViewController: UIViewController {
    let ID_TABBAR = "TabBarViewController"

 
    var Blood :String?
    var name :String?
    var hospital : String?
    var phone : String?
    var Id_post : String?
    @IBOutlet var veiw1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Id_post)

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
            if touch.view == self.veiw1 {
                let tabBarController = self.storyboard?.instantiateViewController(identifier:ID_TABBAR) as! UITabBarController
                   self.navigationController?.pushViewController(tabBarController, animated:true)
                self.dismiss(animated:true, completion:nil);
                self.navigationController?.popViewController(animated:true);
            }
        }

    }
    @IBAction func EditClicked(_ sender: Any) {

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
