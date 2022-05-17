//
//  DetailViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 17/05/2022.
//

import UIKit

class DetailViewController: UIViewController {

   
   
    @IBOutlet weak var view1: UIView!
    let ID_TABBAR = "TabBarViewController"
    @IBOutlet var viewd: UIView!
    var Blood :String?
    var name :String?
    var hospital : String?
    var phone : String?
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBlood: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBlood.text = "Blood : " + Blood!
        lblLocation.text = "Hospital : " + hospital!
        lblName.text = "Name : " + name!
        lblphone.text = "Phone : " + phone!
        self.view1.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
            if touch.view == self.viewd {
                let tabBarController = self.storyboard?.instantiateViewController(identifier:ID_TABBAR) as! UITabBarController
                   self.navigationController?.pushViewController(tabBarController, animated:true)
                self.dismiss(animated:true, completion:nil);
                self.navigationController?.popViewController(animated:true);
            }
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
