//
//  infoViewController.swift
//  OneBlood
//
//  Created by Mac-Mini_2021 on 26/04/2022.
//

import UIKit
import CoreData

class infoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func GoToSetting(_ sender: Any) {
       performSegue(withIdentifier: "EditProfil", sender: sender)
        /*  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "Setting") as! SettingViewController
        self.present(balanceViewController, animated: true, completion: nil)*/
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        
        let defaults: UserDefaults? = UserDefaults.standard
         defaults?.set(false, forKey: "ISRemember")
        defaults?.set("", forKey: "SavedEmail")
        defaults?.set("", forKey: "SavedPassword")
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
        let managedContext = appDelegate.persistentContainer.viewContext
            
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Connected")
            
        do {
            let result = try managedContext.fetch(fetchRequest)
            for obj in result {
                managedContext.delete(obj)
            }
            try managedContext.save()
            print("deleted connected user")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        performSegue(withIdentifier: "logoutSegue", sender: sender)
    }
}
