//
//  HomeViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 08/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
    

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var CadreHistorique: UIView!
    @IBOutlet weak var cadreinfoUser: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cadreinfoUser.layer.shadowColor = UIColor.black.cgColor
        cadreinfoUser.layer.shadowOpacity = 1
        cadreinfoUser.layer.shadowOffset = .zero
        cadreinfoUser.layer.shadowRadius = 1
        cadreinfoUser.layer.shadowPath = UIBezierPath(rect: cadreinfoUser.bounds).cgPath
        cadreinfoUser.layer.shouldRasterize = true
        cadreinfoUser.layer.rasterizationScale = UIScreen.main.scale
////////////////////
        CadreHistorique.layer.shadowColor = UIColor.black.cgColor
        CadreHistorique.layer.shadowOpacity = 1
        CadreHistorique.layer.shadowOffset = .zero
        CadreHistorique.layer.shadowRadius = 1
        CadreHistorique.layer.shadowPath = UIBezierPath(rect: cadreinfoUser.bounds).cgPath
        CadreHistorique.layer.shouldRasterize = true
        CadreHistorique.layer.rasterizationScale = UIScreen.main.scale
/////////////////

        ////

        imageProfile.layer.cornerRadius = imageProfile.frame.size.height/2
        imageProfile.layer.borderWidth = 1
        imageProfile.clipsToBounds = true
         self.view.addSubview(imageProfile)
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
