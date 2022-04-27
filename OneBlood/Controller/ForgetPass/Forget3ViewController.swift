//
//  Forget3ViewController.swift
//  OneBlood
//
//  Created by Mac-Mini_2021 on 26/04/2022.
//

import UIKit

class Forget3ViewController: UIViewController {

    @IBOutlet weak var iconeyeconfirmpass: UIButton!
    @IBOutlet weak var iconeyenewpass: UIButton!
    @IBOutlet weak var confirmpass: UITextField!
    @IBOutlet weak var newpass: UITextField!
    var Email :String?
    var Lastcode :String?
    fileprivate let baseURLRender = "https://onebloodios.onrender.com/"
    public var backResponse:backendResponse = backendResponse(message: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferences = UserDefaults.standard

        let currentLevelKey = "currentLevel"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
        } else {
            let currentLevel = preferences.integer(forKey: currentLevelKey)
            print("rrrrrrrrrrrr " , currentLevel)
            Lastcode =  "\(currentLevel)"
        }
    }
    

    @IBAction func GotoLogin(_ sender: Any) {
        if(newpass.text != confirmpass.text)
        {
            let alert = UIAlertController(title: "Incorrect", message: "Password is not the same", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else
        {
       // performSegue(withIdentifier: "GoHome", sender: sender)
        let parameters = ["email" :  Email , "code" :  Lastcode , "password" :  newpass.text] as [String:Any]
     
        guard let url = URL(string: baseURLRender+"changePassword") else { return }
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

                    if(self.backResponse.message == "password changed")
                    {

                        
                        self.performSegue(withIdentifier: "GoHome", sender: sender)

                        
                    }
                }
            }
        }.resume()
        }
    }
}
