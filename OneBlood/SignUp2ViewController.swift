//
//  SignUp2ViewController.swift
//  OneBlood
//
//  Created by Apple Esprit on 8/4/2022.
//

import UIKit

class SignUp2ViewController: UIViewController {
    @IBOutlet weak var BloodGroupSelected: UISegmentedControl!
    @IBOutlet weak var BloodSignSelected: UISegmentedControl!
    @IBOutlet weak var CheckBoxDontknow: UISwitch!
    @IBOutlet weak var MoreLabel: UILabel!
    
    @IBOutlet weak var AgeLabel: UITextField!
    @IBOutlet weak var LessLabel: UILabel!
    var showingMore = true
    var showingless = true
    var name :String?
    var Email :String?
    var Password :String?
    var Phone : String?
    var location : String?
    ///
    @IBOutlet weak var MyBlood: UILabel!
    ///
    var bloodType="O"
    var bloodGroupResult="";
    var bloodSigne="+";
    //
    var Poids = "";
    ///
    fileprivate let baseURL = "https://server-oneblood.herokuapp.com/"
    public var backResponse:backendResponse = backendResponse(message: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckBoxDontknow.setOn(false, animated: false)
        BloodGroupSelected.addTarget(self, action: #selector(SignUp2ViewController.GetvalueBloodGroup(_:)), for: .valueChanged)
        BloodSignSelected.addTarget(self, action: #selector(SignUp2ViewController.GetvalueBloodSigne(_:)), for: .valueChanged)
        CheckBoxDontknow.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        //


    }
    
    @objc func GetvalueBloodGroup(_ sender: UISegmentedControl) {
        if BloodGroupSelected.selectedSegmentIndex == 0 {
            bloodType="";
            bloodType = "O";
        } else if BloodGroupSelected.selectedSegmentIndex == 1 {
            bloodType="";
            bloodType = "B";
        } else if BloodGroupSelected.selectedSegmentIndex == 2 {
            bloodType="";
            bloodType = "AB";
        }
        else if BloodGroupSelected.selectedSegmentIndex == 3 {
            bloodType="";
            bloodType = "A";
        }
        print("Select ===>>>>> "+bloodType)
        MyBlood.text = bloodType + bloodSigne
    }
    
    @objc func GetvalueBloodSigne(_ sender: UISegmentedControl) {
        if BloodSignSelected.selectedSegmentIndex == 0 {
            bloodSigne="";
            bloodSigne = "+";
        } else if BloodSignSelected.selectedSegmentIndex == 1 {
            bloodSigne="";
            bloodSigne = "-";
        }
        print("Select ===>>>>> "+bloodSigne)
        MyBlood.text = bloodType + bloodSigne
    }
    
    
    
    

    @objc func switchChanged(mySwitch: UISwitch) {
        if CheckBoxDontknow.isOn {
            bloodSigne="";
            bloodType="";
            bloodGroupResult="";
            BloodGroupSelected.selectedSegmentIndex = UISegmentedControl.noSegment
            BloodSignSelected.selectedSegmentIndex = UISegmentedControl.noSegment
            bloodGroupResult="IDK";
            MyBlood.text = bloodGroupResult
            
        }
    }
    @IBAction func ClickMore(_ sender: Any) {
        if(showingMore == true)
        {
            MoreLabel.textColor = UIColor(red: 25, green: 0, blue: 0, alpha: 1.0)
            showingMore = false
            ///
            LessLabel.textColor = UIColor.black
            showingless = true
            ///
            Poids="MoreThen50KG"
        }else{
            MoreLabel.textColor = UIColor.black
            showingMore = true
            //
            Poids=""
        }
    }

    @IBAction func ClickLess(_ sender: Any) {
        if(showingless == true)
        {
            LessLabel.textColor = UIColor(red: 25, green: 0, blue: 0, alpha: 1.0)
            showingless = false
            //
            MoreLabel.textColor = UIColor.black
            showingMore = true
            //
            Poids="LessThen50KG"
        }else{
            LessLabel.textColor = UIColor.black
            showingless = true
            //
            Poids=""

        }
    }
    
    @IBAction func FinishSignUp(_ sender: Any) {

        bloodGroupResult = bloodType + bloodSigne
        if(bloodGroupResult.isEmpty)
        {
            bloodGroupResult="IDK";
        }
        if(!bloodGroupResult.isEmpty && !Poids.isEmpty && AgeLabel.text != "" )
        {
            let parameters = ["name" : name! , "email" : Email! , "password" : Password! , "blood" : bloodGroupResult , "age" : AgeLabel.text! , "weight" : Poids , "adress" : location! , "phone" :  Phone! , "usertype": "Donor" , "avatar" : name!] as [String:Any]
         
            guard let url = URL(string: baseURL+"signup") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            var status = 0
            URLSession.shared.dataTask(with: request) { (data,response,error) in
                if error == nil{
                    do {
                        self.backResponse = try JSONDecoder().decode(backendResponse.self, from: data!)
                        let httpResponse = response as? HTTPURLResponse
                        status = httpResponse!.statusCode
                    } catch {
                        print("parse json error")
                    }
                    DispatchQueue.main.async {
                       if status == 200 {
                       self.performSegue(withIdentifier: "Login", sender: sender)

                            
                        }
                    }
                }
            }.resume()

        }
    

        
        
    }
    



    
}
