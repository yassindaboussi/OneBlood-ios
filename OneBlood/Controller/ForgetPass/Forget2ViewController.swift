//
//  Forget2ViewController.swift
//  OneBlood
//
//  Created by Mac-Mini_2021 on 26/04/2022.
//

import UIKit

class Forget2ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var code4: UITextField!
    @IBOutlet weak var code3: UITextField!
    @IBOutlet weak var code2: UITextField!
    @IBOutlet weak var code1: UITextField!
    var maxLen:Int = 1;
  
    var codetyped : String = ""
    var code :Int?
    var Lastcode :String?
    var Email :String?
    fileprivate let baseURLRender = "https://onebloodios.onrender.com/"

    override func viewDidLoad() {
        super.viewDidLoad()
        code1.delegate = self
        code2.delegate = self
        code3.delegate = self
        code4.delegate = self
        
        
        let preferences = UserDefaults.standard

        let currentLevelKey = "currentLevel"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)
            print("rrrrrrrrrrrr " , currentLevel)
            Lastcode =  currentLevel
            print(Email)
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if(textField == code1){
           let currentText = textField.text! + string
           return currentText.count <= maxLen
        }
        if(textField == code2){
           let currentText = textField.text! + string
           return currentText.count <= maxLen
        }
        if(textField == code3){
           let currentText = textField.text! + string
           return currentText.count <= maxLen
        }
        if(textField == code4){
           let currentText = textField.text! + string
           return currentText.count <= maxLen
        }
        return true;
      }
    

    @IBAction func resendCode(_ sender: Any) {

        
    }

    
    @IBAction func gotoForget3(_ sender: Any) {
        
        var codeee1 : String = ""
        var codeee2 : String = ""
        var codeee3 : String = ""
        var codeee4 : String = ""
        
         codeee1 = code1.text!
         codeee2 = code2.text!
         codeee3 = code3.text!
         codeee4 = code4.text!
        

        codetyped = codeee1 + codeee2 + codeee3 + codeee4 
        print("codetyped" , codetyped + "Lastcode"  , Lastcode)
        
     
       // print("codetyped "+ codetyped! )
        if(codetyped  == "")
        {
            let alert = UIAlertController(title: " field is empty", message: "please fill your inputs", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
 else if (Lastcode == codetyped)
 {
     print("waaaaaaaa")
     performSegue(withIdentifier: "forget3", sender: sender)

 }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forget3" {
          let des = segue.destination as! Forget3ViewController
       
          des.Email = Email
    }
    
    
}
}
