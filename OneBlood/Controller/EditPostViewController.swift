//
//  EditPostViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 13/05/2022.
//

import UIKit
import DropDown

class EditPostViewController: UIViewController {
    let ID_TABBAR = "TabBarViewController"
    @IBOutlet weak var ViewBloodType: UIView!
    @IBOutlet weak var LblBlood: UILabel!
    
    @IBOutlet weak var txtHospital: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    var showingDanger = true
    var showingNormal = true
    var Blood :String?
    var name :String?
    var hospital : String?
    var phone : String?
    var Id_post : String?
    var Situation :String?
    let dropDown = DropDown()
    let list = ["A+", "A-", "B+","B-","AB+","AB-","O+","O-","IDK"]
    fileprivate let baseURL = "https://server-oneblood.herokuapp.com/"
    @IBOutlet weak var lblNormal: UILabel!
    @IBOutlet weak var LblDanger: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUser()
        dropDown.anchorView = ViewBloodType
        dropDown.dataSource = list
        
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.LblBlood.text = list[index]
        }
    }
        
        

        
        
    @IBAction func clicknormal(_ sender: Any) {
        if(showingNormal == true)
        {
            lblNormal.textColor = UIColor(red: 25, green: 0, blue: 0, alpha: 1.0)
            showingDanger = false
            ///
            LblDanger.textColor = UIColor.black
            showingDanger = true
            Situation = "Normal"
            ///
           
        }else{
            lblNormal.textColor = UIColor.black
            showingDanger = true
            Situation = ""
            //
        
        }
    }
    

        // Do any additional setup after loading the view.
    
    func setupUser() {
        LblBlood.text = Blood
        txtName.text = name
        txtHospital.text = hospital
        txtPhone.text = phone
        if (Situation == "Danger")
        {
            LblDanger.textColor = UIColor(red: 25, green: 0, blue: 0, alpha: 1.0)
        }
        if (Situation == "Normal")
        {
            lblNormal.textColor = UIColor(red: 25, green: 0, blue: 0, alpha: 1.0)
        }
        
    }
    
    @IBAction func showblood(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func clickdanger(_ sender: Any) {
    
        if(showingDanger == true)
        {
            LblDanger.textColor = UIColor(red: 25, green: 0, blue: 0, alpha: 1.0)
            showingDanger = false
            ///
            lblNormal.textColor = UIColor.black
            showingDanger = true
            Situation = "Danger"
            ///
           
        }else{
            LblDanger.textColor = UIColor.black
            showingDanger = true
            Situation = ""
            //
        
        }

    
    }
        
  
    @IBAction func UpdateClicked(_ sender: Any) {
        
        let parameters = ["_id" : Id_post ,"nom" : txtName.text! , "location" : txtHospital.text!, "blood" : LblBlood.text , "phone" :  txtPhone.text! , "situation": Situation ] as [String:Any]
     
        guard let url = URL(string: baseURL+"UpdatePost") else { return }
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
                    print("test-------------")
                    let tabBarController = self.storyboard?.instantiateViewController(identifier: self.ID_TABBAR) as! UITabBarController
                       self.navigationController?.pushViewController(tabBarController, animated:true)
                    self.dismiss(animated:true, completion:nil);
                    self.navigationController?.popViewController(animated:true);
                }
            }
        }.resume()
        
        
    }
    

    }

