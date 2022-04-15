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

    var name :String?
    var Email :String?
    var Password :String?
    var Phone : String?
    var location : String?
    ///
    var bloodType="O"
    var bloodGroupResult="";
    var bloodSigne="+";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckBoxDontknow.setOn(false, animated: false)
        BloodGroupSelected.addTarget(self, action: #selector(SignUp2ViewController.GetvalueBloodGroup(_:)), for: .valueChanged)
        BloodSignSelected.addTarget(self, action: #selector(SignUp2ViewController.GetvalueBloodSigne(_:)), for: .valueChanged)
        //
        CheckBoxDontknow.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)

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
    }
    
    
    
    

    @objc func switchChanged(mySwitch: UISwitch) {
        if CheckBoxDontknow.isOn {
            bloodSigne="";
            bloodType="";
            bloodGroupResult="";
            BloodGroupSelected.selectedSegmentIndex = UISegmentedControl.noSegment
            BloodSignSelected.selectedSegmentIndex = UISegmentedControl.noSegment
            bloodGroupResult="IDK";
            
        }
    }

    @IBAction func FinishSignUp(_ sender: Any) {

       //performSegue(withIdentifier: "Login", sender: sender)
        bloodGroupResult = bloodType + bloodSigne
        if(bloodGroupResult.isEmpty)
        {
            bloodGroupResult="IDK";
        }
        print("Result ===>>>>> "+bloodGroupResult)
        
        // To Fix sa3et tjy valuer keen bloodd maghyr + wela -
        
        
    }
    
    


    
}
