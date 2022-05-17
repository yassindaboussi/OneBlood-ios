//
//  Forget1ViewController.swift
//  OneBlood
//
//  Created by Mac-Mini_2021 on 26/04/2022.
//

import UIKit

class Forget1ViewController: UIViewController {

    @IBOutlet weak var emailforget: UITextField!
    @IBOutlet weak var mygif: UIImageView!
    fileprivate let baseURLRender = "https://onebloodios.onrender.com/"
    public var codecode:code = code( code: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        let setGif = UIImage.gifImageWithName("forgetpass");
        mygif.image = setGif
    }
    


    @IBAction func gotoforget2(_ sender: Any) {
        if(emailforget.text == "")
        {
            let alert = UIAlertController(title: " field is empty", message: "please fill your inputs", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        else
        {
            let parameters = ["email" : emailforget.text! ] as [String:Any]
         
            guard let url = URL(string: baseURLRender+"forgetPassword") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            var status = 0
            URLSession.shared.dataTask(with: request) { (data,response,error) in
                if error == nil{
                    do {
                        self.codecode = try JSONDecoder().decode(code.self, from: data!)
                        let httpResponse = response as? HTTPURLResponse
                        status = httpResponse!.statusCode
                    } catch {
                        print("parse json error")
                    }
                    DispatchQueue.main.async {
                    //   if status == 200 {
                        print("aaaaaaaaaaaa")
                        print("waaaaaaaaa" , self.codecode.code )
                           self.performSegue(withIdentifier: "forget2", sender: sender)
                           
                           let pref = UserDefaults.standard
                           let currentLevel = self.codecode.code
                           let currentLevelKey = "currentLevel"
                           pref.set(currentLevel,forKey: currentLevelKey)
                       // }
                    }
                }
            }.resume()
            self.performSegue(withIdentifier: "forget2", sender: sender)

        }
        

        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forget2" {
          let des = segue.destination as! Forget2ViewController
       
          des.Email = emailforget.text
    }

}
}


