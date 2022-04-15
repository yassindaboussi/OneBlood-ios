//
//  ViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
   
    fileprivate let baseURL = "https://server-oneblood.herokuapp.com"
    public var connectedUser:User = User(id: "", name: "", email: "", blood: "", age: 0, weight: "" , adress: "", phone: 0, usertype: "", avatar: "", token: "")
    public var response:AuthResponse = AuthResponse( error: "")
    
    @IBOutlet weak var eyeicon: UIButton!
    @IBOutlet weak var eyePassword: UIImageView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    var showingFirst = true
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var GifLogin: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        let setGif = UIImage.gifImageWithName("lottieblood");
        GifLogin.image = setGif
        ///
        btnLogin.layer.cornerRadius = 10

    }

    @IBAction func BtnLoginClicked(_ sender: Any) {
        
        print("BtnLoginClicked")
        let emailValue = txtEmail.text
        let passwordValue = txtPassword.text
        
        if emailValue == "" {
            print("email empty")
            let alert = UIAlertController(title: "email field is empty", message: "please fill your inputs", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if passwordValue == "" {
            print("password empty")
            let alert = UIAlertController(title: "password field is empty", message: "please fill your inputs", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            print("try to connect")
            let parameters = ["email" : emailValue, "password" : passwordValue]
            guard let url = URL(string: baseURL+"/signin") else { return }
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
                        if !( status == 200) {

                            print("serialize backendresponse")
                            self.response = try JSONDecoder().decode(AuthResponse.self, from: data!)
                            print(self.response)
                        }else {
                            self.connectedUser = try JSONDecoder().decode(User.self, from: data!)
                            print(self.connectedUser)
                            print("serialize user")
                        }
                        
                    } catch {
                        print("parse json error")
                    }
            
                    DispatchQueue.main.async {
                        
                      if status == 422 {
                        print("error=======")
                            let alert = UIAlertController(title: "Incorrect password", message: "check your inputs", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }else if status == 200 {
                            
                            print("++++++++++++++++++++++name++++++++++++++++++"+self.connectedUser.name)
                            print(self.connectedUser)
                           self.saveConnectedUser()
                            self.performSegue(withIdentifier: "Home", sender:sender)
                        }
                        
                    }
                }
            }.resume()
    }
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
        
    
    
    @IBAction func eyeClicked(_ sender: Any) {
       
        if(showingFirst == true)
        {
            txtPassword.isSecureTextEntry = false
            showingFirst = false
        }else{
            txtPassword.isSecureTextEntry = true
            showingFirst = true
        }
    }
    
    @IBAction func GoToSignUp(_ sender: Any) {
        performSegue(withIdentifier: "Condition", sender: sender)
    }
    
}

