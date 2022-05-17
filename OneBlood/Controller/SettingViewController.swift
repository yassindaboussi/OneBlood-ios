//
//  SettingViewController.swift
//  OneBlood
//
//  Created by Mac-Mini_2021 on 26/04/2022.
//

import UIKit
import DropDown
import CoreData

class SettingViewController: UIViewController {
    let ID_TABBAR = "TabBarViewController"

    @IBOutlet weak var txtlocation: UITextField!
    @IBOutlet weak var txtage: UITextField!
    @IBOutlet weak var txtphone: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtname: UITextField!
    //
    @IBOutlet weak var ViewDropDown: UIView!
    @IBOutlet weak var LabelBlood: UILabel!
    
    @IBOutlet weak var ViewDropUserType: UIView!
    @IBOutlet weak var LabelUserType: UILabel!
    let dropDown = DropDown()
    let dropDownUserType = DropDown()
    fileprivate let baseURLRender = "https://onebloodios.onrender.com"

    // The view to which the drop down will appear on
   // dropDown.anchorView = view // UIView or UIBarButtonItem

    // The list of items to display. Can be changed dynamically
   // dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
    let list = ["A+", "A-", "B+","B-","AB+","AB-","O+","O-","IDK"]
    let listUserType = ["Donor","Needy"]
    var connectedUser:User = User(id: "notyet", name: "", email: "", blood: "", age: 0, weight: "" , adress: "", phone: 0, usertype: "", avatar: "", token: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        getConnectedUser()
        setupUser()
        dropDown.anchorView = ViewDropDown
        dropDown.dataSource = list
        
        
        dropDownUserType.anchorView = ViewDropUserType
        dropDownUserType.dataSource = listUserType

        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        
        
        dropDownUserType.bottomOffset = CGPoint(x: 0, y:(dropDownUserType.anchorView?.plainView.bounds.height)!)
        dropDownUserType.topOffset = CGPoint(x: 0, y:-(dropDownUserType.anchorView?.plainView.bounds.height)!)
        dropDownUserType.direction = .bottom
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.LabelBlood.text = list[index]
        }

        
        dropDownUserType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.LabelUserType.text = listUserType[index]
        }
        
        //
        getConnectedUser()
        setupUser()
      

    }

    
    @IBAction func ShowDropDown(_ sender: Any) {
        dropDown.show()
    }
    @IBAction func ShowdropUserType(_ sender: Any) {
        dropDownUserType.show()
    }
    
    
    func setupUser() {
        txtname.text = connectedUser.name
        txtemail.text = connectedUser.email
        txtphone.text = String (connectedUser.phone)
        txtage.text = String (connectedUser.age)
        txtlocation.text = connectedUser.adress
        LabelBlood.text = connectedUser.blood
        LabelUserType.text = connectedUser.usertype
    }
    @IBAction func SaveAction(_ sender: Any) {
        let parameters = ["id" : connectedUser.id,"name" : txtname.text! , "email" : txtemail.text! , "blood" : LabelBlood.text! , "age" : txtage.text! , "adress" : txtlocation.text! , "phone" :  txtphone.text! , "usertype" : LabelUserType.text! , "avatar" : txtname.text!] as [String : Any]
     
        guard let url = URL(string: self.baseURLRender+"/UpdateUser") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        var status = 0
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if error == nil{
                do {
                    
                    let httpResponse = response as? HTTPURLResponse
                    status = httpResponse!.statusCode
    
                        self.connectedUser = try JSONDecoder().decode(User.self, from: data!)
                        print(self.connectedUser)
                        print("serialize user")
                    
                        
                } catch {
                    print("parse json error")
                }
        
                DispatchQueue.main.async {
                    
                    if(status == 202)
                    {
                        let tabBarController = self.storyboard?.instantiateViewController(identifier:self.ID_TABBAR) as! UITabBarController
                           self.navigationController?.pushViewController(tabBarController, animated:true)
                        self.dismiss(animated:true, completion:nil);
                        self.navigationController?.popViewController(animated:true);
                        
                       self.updateData(id: self.connectedUser.id)

                       //self.saveConnectedUser()
                       // self.getConnectedUser()
                       // self.setupUser()
                    }
                    //self.performSegue(withIdentifier: "Home", sender: sender)
                    
                 
                    
                }
            }
        }.resume()
    }
    func updateData(id : String) {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Connected", in : managedContext)
        let request = NSFetchRequest < NSFetchRequestResult > ()
        request.entity = entity
        let predicate = NSPredicate(format:"id = %@", id as String)
        request.predicate = predicate
        do {
            let results =
                try managedContext.fetch(request)
            let object = results[0] as!NSManagedObject

            //
            object.setValue(txtname.text!, forKey: "name")
            object.setValue(txtlocation.text!, forKey: "adress")
            object.setValue( txtemail.text!, forKey: "email")
            object.setValue(LabelBlood.text!, forKey: "bloodtype")
            object.setValue(Int32(txtphone.text!), forKey: "phone")

            object.setValue(LabelUserType.text!, forKey: "usertype")
            //object.setValue(self.connectedUser.avatar, forKey: "avatar")
            object.setValue(Int32(txtage.text!), forKey: "age")
            
            do {
                try managedContext.save()
                print("Record Updated!")
                let tabBarController = self.storyboard?.instantiateViewController(identifier:ID_TABBAR) as! UITabBarController
                   self.navigationController?.pushViewController(tabBarController, animated:true)
                self.dismiss(animated:true, completion:nil);
                self.navigationController?.popViewController(animated:true);
            } catch
            let error as NSError {}
        } catch
        let error as NSError {}
    }  
    
    func saveConnectedUser() -> Void {
        
        let appD = UIApplication.shared.delegate as! AppDelegate
        let PC = appD.persistentContainer
        let managedContext = PC.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Connected",in: managedContext)!
        let object = NSManagedObject(entity: entity,insertInto: managedContext)
        
        object.setValue(self.connectedUser.id, forKey: "id")
        object.setValue(self.connectedUser.name, forKey: "name")
        object.setValue(self.connectedUser.adress, forKey: "adress")
        object.setValue(self.connectedUser.email, forKey: "email")
        object.setValue(self.connectedUser.blood, forKey: "bloodtype")
        object.setValue(self.connectedUser.phone, forKey: "phone")
        object.setValue(self.connectedUser.usertype, forKey: "usertype")
        object.setValue(self.connectedUser.avatar, forKey: "avatar")
        object.setValue(self.connectedUser.age, forKey: "age")
        object.setValue(self.connectedUser.token, forKey: "token")
                
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
