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

    override func viewDidLoad() {
        super.viewDidLoad()
        code1.delegate = self
        code2.delegate = self
        code3.delegate = self
        code4.delegate = self

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
 
        performSegue(withIdentifier: "forget3", sender: sender)
        
    }
    
    
}
