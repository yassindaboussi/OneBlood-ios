//
//  HomeViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 08/04/2022.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var bloodtype: UILabel!
    @IBOutlet weak var usertypetxt: UILabel!
    var connectedUser:User = User(id: "notyet", name: "", email: "", blood: "", age: 0, weight: "" , adress: "", phone: 0, usertype: "", avatar: "", token: "")
    fileprivate let baseURL = "https://server-oneblood.herokuapp.com"
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

        imageProfile.layer.cornerRadius = imageProfile.frame.size.height/2
        imageProfile.layer.borderWidth = 1
        imageProfile.clipsToBounds = true
         self.view.addSubview(imageProfile)
        self.view.layoutIfNeeded()
        ///
        getConnectedUser()
       setupUser()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        getConnectedUser()
        bloodtype.text = connectedUser.blood
        usertypetxt.text = connectedUser.usertype
        print("yyyyyyyy")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
    }
    func setupUser() {
        /*
        //let avatarUrl = baseURL + "uploads/users/" + connectedUser.avatar
        ProfilePic.sd_setImage(with: URL(string: avatarUrl), placeholderImage: UIImage(named: "nikeair"), options: [.continueInBackground, .progressiveLoad])*/
        bloodtype.text = connectedUser.blood
        usertypetxt.text = connectedUser.usertype
        print("yyyyyyyy")
        self.view.layoutIfNeeded()

    }
    
    
    
    func getConnectedUser() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Connected")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for obj in result {
                self.connectedUser.id =  (obj.value(forKey: "id") as! String)
                self.connectedUser.name=(obj.value(forKey: "name") as! String)
                self.connectedUser.phone=(obj.value(forKey: "phone") as! Int)
                self.connectedUser.email=(obj.value(forKey: "email") as! String)
                self.connectedUser.age=(obj.value(forKey: "age") as! Int)
                self.connectedUser.usertype=(obj.value(forKey: "usertype") as! String)
                self.connectedUser.blood=(obj.value(forKey: "bloodtype") as! String)
                self.connectedUser.avatar=(obj.value(forKey: "avatar") as! String)
                self.connectedUser.adress=(obj.value(forKey: "adress") as! String)
                self.connectedUser.token=(obj.value(forKey: "token") as! String)
                
            }
            
         
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    


}
