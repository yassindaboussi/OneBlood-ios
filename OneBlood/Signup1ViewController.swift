//
//  Signup1ViewController.swift
//  OneBlood
//
//  Created by Apple Esprit on 8/4/2022.
//

import UIKit

class Signup1ViewController: UIViewController {

    @IBOutlet weak var gifimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let setGif = UIImage.gifImageWithName("userlogin")
        gifimage.image = setGif
    }
    

    @IBAction func GoToSignUp2(_ sender: Any) {
        performSegue(withIdentifier: "SignUp2", sender: sender)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
