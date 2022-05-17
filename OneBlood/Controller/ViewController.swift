//
//  ViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit
class ViewController: UIViewController{

    
    let ID_TABBAR = "TabBarViewController"
    @IBOutlet weak var rememberSwitch: UISwitch!
    
    @IBOutlet weak var facebookLoginBtn: UIButton!
    
    fileprivate let baseURL = "https://server-oneblood.herokuapp.com"
    public var connectedUser:User = User(id: "", name: "", email: "", blood: "", age: 0, weight: "" , adress: "", phone: 0, usertype: "", avatar: "", token: "")
    public var response:AuthResponse = AuthResponse( error: "")
    fileprivate let baseURLRender = "https://onebloodios.onrender.com"
 
    var facebookId = ""
    var facebookFirstName = ""
    var facebookMiddleName = ""
    var facebookLastName = ""
    var facebookName = ""
    var facebookProfilePicURL = ""
    var facebookEmail = ""
    var facebookAccessToken = ""
    
    
    @IBOutlet weak var eyeicon: UIButton!
    @IBOutlet weak var eyePassword: UIImageView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    var showingFirst = true
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var GifLogin: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.facebookLoginBtn.layer.cornerRadius = 10.0
        
//        // Login Button made by Facebook
//        let loginButton = FBLoginButton()
//        // Optional: Place the button in the center of your view.
//        loginButton.permissions = ["public_profile", "email"]
//        loginButton.delegate = self
//        loginButton.center = view.center
//        view.addSubview(loginButton)
        
        rememberSwitch.addTarget(self, action: #selector(self.stateChanged), for: .valueChanged)
               let defaults: UserDefaults? = UserDefaults.standard

       // check if defaults already saved the details

        if (((defaults?.bool(forKey: "ISRemember")) != nil)  && defaults?.string(forKey: "SavedEmail") != "" && defaults?.string(forKey: "SavedPassword") != "") {
            
            rememberSwitch.setOn(true, animated: false)
            let tabBarController = self.storyboard?.instantiateViewController(identifier:ID_TABBAR) as! UITabBarController
            self.navigationController?.pushViewController(tabBarController, animated:true)
            self.dismiss(animated:true, completion:nil);
            self.navigationController?.popViewController(animated:true);
            
            
            ////
            
            
            let parameters = ["email" : defaults?.string(forKey: "SavedEmail"), "password" : defaults?.string(forKey: "SavedPassword")]
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
                            self.performSegue(withIdentifier: "Home", sender:nil)
                        }
                        
                    }
                }
            }.resume()
            
            
            /////
               }
               else {
                   rememberSwitch.setOn(false, animated: false)
               }
        
        if isLoggedIn() { // mte lfacebook
            // Show the ViewController with the logged in user
        }else{
            // Show the Home ViewController
        }
        
        //Logout
//        LoginManager().logOut()
        // Do any additional setup after loading the view.
        
        let setGif = UIImage.gifImageWithName("lottieblood");
        GifLogin.image = setGif
        ///
        btnLogin.layer.cornerRadius = 10
        self.navigationItem .setHidesBackButton(true, animated: false)
        self.navigationItem.backBarButtonItem?.title=""

    }
    @objc func stateChanged(_ switchState: UISwitch) {

            let defaults: UserDefaults? = UserDefaults.standard
        if switchState.isOn {
                defaults?.set(true, forKey: "ISRemember")
            defaults?.set(txtEmail.text, forKey: "SavedEmail")
            defaults?.set(txtPassword.text, forKey: "SavedPassword")
            }
            else {
                defaults?.set(false, forKey: "ISRemember")
                }
                }
    func isLoggedIn() -> Bool {
        let accessToken = AccessToken.current
        let isLoggedIn = accessToken != nil && !(accessToken?.isExpired ?? false)
        return isLoggedIn
    }

    
    func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in
            if error != nil {
                print("ERROR: Trying to get login results")
            } else if result?.isCancelled != nil {
                print("The token is \(result?.token?.tokenString ?? "")")
                if result?.token?.tokenString != nil {
                    print("Logged in")
                    self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                } else {
                    print("Cancelled")
                }
            }
        })
    }
    
    func getUserProfile(token: AccessToken?, userId: String?) {
        let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, middle_name, last_name, name, picture, email"])
        graphRequest.start { _, result, error in
            if error == nil {
                let data: [String: AnyObject] = result as! [String: AnyObject]
                
                // Facebook Id
                if let facebookId = data["id"] as? String {
                    print("Facebook Id: \(facebookId)")
                    self.facebookId = facebookId
                } else {
                    print("Facebook Id: Not exists")
                    self.facebookId = "Not exists"
                }
                
                // Facebook First Name
                if let facebookFirstName = data["first_name"] as? String {
                    print("Facebook First Name: \(facebookFirstName)")
                    self.facebookFirstName = facebookFirstName
                } else {
                    print("Facebook First Name: Not exists")
                    self.facebookFirstName = "Not exists"
                }
                
                // Facebook Middle Name
                if let facebookMiddleName = data["middle_name"] as? String {
                    print("Facebook Middle Name: \(facebookMiddleName)")
                    self.facebookMiddleName = facebookMiddleName
                } else {
                    print("Facebook Middle Name: Not exists")
                    self.facebookMiddleName = "Not exists"
                }
                
                // Facebook Last Name
                if let facebookLastName = data["last_name"] as? String {
                    print("Facebook Last Name: \(facebookLastName)")
                    self.facebookLastName = facebookLastName
                } else {
                    print("Facebook Last Name: Not exists")
                    self.facebookLastName = "Not exists"
                }
                
                // Facebook Name
                if let facebookName = data["name"] as? String {
                    print("Facebook Name: \(facebookName)")
                    self.facebookName = facebookName
                } else {
                    print("Facebook Name: Not exists")
                    self.facebookName = "Not exists"
                }
                
                // Facebook Profile Pic URL
                let facebookProfilePicURL = "https://graph.facebook.com/\(userId ?? "")/picture?type=large"
                print("Facebook Profile Pic URL: \(facebookProfilePicURL)")
                self.facebookProfilePicURL = facebookProfilePicURL
                
                // Facebook Email
                if let facebookEmail = data["email"] as? String {
                    print("Facebook Email: \(facebookEmail)")
                    self.facebookEmail = facebookEmail
                } else {
                    print("Facebook Email: Not exists")
                    self.facebookEmail = "Not exists"
                }
                
                print("Facebook Access Token: \(token?.tokenString ?? "")")
                self.facebookAccessToken = token?.tokenString ?? ""
                
                DispatchQueue.main.async {
                   // self.performSegue(withIdentifier: "Home", sender: self)
                    let parameters = ["name" : self.facebookName , "email" : self.facebookEmail] as [String:Any]
                    print("aaaaaaaaaaa"+self.facebookEmail + self.facebookName);
                    guard let url = URL(string: self.baseURLRender+"/ByFacebook") else { return }
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
                                

                                    
                                    print("++++++++++++++++++++++name++++++++++++++++++"+self.connectedUser.name)
                                    print(self.connectedUser)
                                   self.saveConnectedUser()
                                 //   performSegue(withIdentifier: "Home", sender: sender)
                                
                                if status == 200 {
                                  print("Login Facebook")
                                    self.saveConnectedUser()
                                    self.performSegue(withIdentifier: "Home", sender: nil)
                                  }else if status == 202 {
                                      
                                      print("Inscription Facebook")

                                  }
                                
                            }
                        }
                    }.resume()
                }
                
            } else {
                print("Error: Trying to get user's info")
            }
        }
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
    
    @IBAction func ClickFacebook(_ sender: Any) {
        self.loginButtonClicked()
        
    }
    
    @IBAction func GotoForgetPass(_ sender: Any) {
       performSegue(withIdentifier: "Forget1", sender: sender)


    }
    
}

