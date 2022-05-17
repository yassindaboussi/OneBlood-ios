//
//  AddNeedyViewController.swift
//  OneBlood
//
//  Created by Mac-Mini_2021 on 04/05/2022.
//

import UIKit
import DropDown
import CoreData

class AddNeedyViewController: UIViewController {
    
    var connectedUser:User = User(id: "notyet", name: "", email: "", blood: "", age: 0, weight: "" , adress: "", phone: 0, usertype: "", avatar: "", token: "")
    var Situation = "";
    @IBOutlet weak var ViewBloodType: UIView!
    
    @IBOutlet weak var BtnDanger: UIButton!
    var showingDanger = true
    var showingNormal = true
    @IBOutlet weak var LNormal: UILabel!
    @IBOutlet weak var LDanger: UILabel!
    @IBOutlet weak var BtnNormal: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var TxtHospital: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var LabelBlood: UILabel!
    var Datepost = "4 may 2022 10:50"
    let dropDown = DropDown()
    let list = ["A+", "A-", "B+","B-","AB+","AB-","O+","O-","IDK"]
    fileprivate let baseURL = "https://server-oneblood.herokuapp.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.anchorView = ViewBloodType
        dropDown.dataSource = list
        
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.LabelBlood.text = list[index]
        }
        getConnectedUser()
        
    }
    
    @IBAction func showDropDown(_ sender: Any) {
        dropDown.show()
        
    }
    
    @IBAction func ClickDanger(_ sender: Any) {
        if(showingDanger == true)
        {
            LDanger.textColor = UIColor(red: 25, green: 0, blue: 0, alpha: 1.0)
            showingDanger = false
            ///
            LNormal.textColor = UIColor.black
            showingDanger = true
            Situation = "Danger"
            ///
           
        }else{
            LDanger.textColor = UIColor.black
            showingDanger = true
            Situation = ""
            //
        
        }
        
    }
    
    @IBAction func ClickNormal(_ sender: Any) {
        if(showingNormal == true)
        {
            LNormal.textColor = UIColor(red: 25, green: 0, blue: 0, alpha: 1.0)
            showingNormal = false
            Situation = "Normal"
            //
            LDanger.textColor = UIColor.black
            showingDanger = true
            //
           
        }else{
            LNormal.textColor = UIColor.black
            showingNormal = true
            Situation = ""
            //
            

        }
    }
    
    
    @IBAction func ClickSave(_ sender: Any) {
        
        let parameters = ["datepost" : Datepost ,"nom" : txtName.text! , "avatar" : txtName.text! ,"location" : TxtHospital.text!, "blood" : LabelBlood.text! , "phone" :  txtPhone.text! , "situation": Situation , "postedby" : connectedUser.id] as [String:Any]
     
        guard let url = URL(string: baseURL+"Addbesion") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        var status = 0
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if error == nil{
                /*do {
                    self.backResponse = try JSONDecoder().decode(backendResponse.self, from: data!)
                    let httpResponse = response as? HTTPURLResponse
                    status = httpResponse!.statusCode
                } catch {
                    print("parse json error")
                }*/
                DispatchQueue.main.async {
                 /*  if status == 200 {
                   self.performSegue(withIdentifier: "Login", sender: sender)/

                        
                    }*/
                    let tabBarController = self.storyboard?.instantiateViewController(identifier:"TabBarViewController") as! UITabBarController
                       self.navigationController?.pushViewController(tabBarController, animated:true)
                    self.dismiss(animated:true, completion:nil);
                    self.navigationController?.popViewController(animated:true);
                    print("test-------------")
                }
            }
        }.resume()
        
        
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
