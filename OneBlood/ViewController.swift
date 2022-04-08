//
//  ViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var eyeicon: UIButton!
    @IBOutlet weak var eyePassword: UIImageView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    var showingFirst = true
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
        performSegue(withIdentifier: "Home", sender: sender)
        
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

