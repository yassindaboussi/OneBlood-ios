//
//  PopMapViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 11/05/2022.
//

import UIKit

class PopMapViewController: UIViewController {
    let ID_TABBAR = "TabBarViewController"
    var name :String?
    var Location :String?
    var Phone :String?

    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = name
        lblLocation.text = Location
        lblPhone.text = Phone

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
            if touch.view == self.view1 {
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

    @IBAction func Callclicked(_ sender: Any) {
        let phonenumber = "076938483"
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "tel://" + phonenumber)!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: "tel://" + phonenumber)!)
        }
    }
}
