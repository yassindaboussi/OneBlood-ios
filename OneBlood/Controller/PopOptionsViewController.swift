//
//  PopOptionsViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 10/05/2022.
//

import UIKit

class PopOptionsViewController: UIViewController {
    let ID_TABBAR = "TabBarViewController"
    fileprivate let baseURL = "https://server-oneblood.herokuapp.com/"

 
    var Blood :String?
    var Situation :String?
    var name :String?
    var hospital : String?
    var phone : String?
    var Id_post : String?
    @IBOutlet var veiw1: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Id_post)

        
        
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
            if touch.view == self.veiw1 {
                let tabBarController = self.storyboard?.instantiateViewController(identifier:ID_TABBAR) as! UITabBarController
                   self.navigationController?.pushViewController(tabBarController, animated:true)
                self.dismiss(animated:true, completion:nil);
                self.navigationController?.popViewController(animated:true);
            }
        }

    }
    @IBAction func EditClicked(_ sender: Any) {

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func closePost(_ sender: Any) {
        let parameters = [ "_id" : Id_post! , "situation" : "Closed"] as [String:Any]
     
        guard let url = URL(string: baseURL+"CloseCase") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        var status = 0
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if error == nil{
                /*do {
                    self.backResponse = try JSONDecoder().decode(backendResponse.self, from: data!)
                    let httpResponse = response as? HTTPURLResponse
                    status = httpResponse!.statusCode
                } catch {
                    print("parse json error")
                }*/
                DispatchQueue.main.async {
                 /*  if status == 200 {
                   self.performSegue(withIdentifier: "Login", sender: sender)/

                        
                    }*/
                    print("test-------------")
                    print(self.Id_post!)
                }
            }
        }.resume()
        
        
    }
    
    @IBAction func DeletePost(_ sender: Any) {
        let parameters = [ "_id" : Id_post! ] as [String:Any]
     
        guard let url = URL(string: baseURL+"deletPost") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "delete"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        var status = 0
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if error == nil{
                /*do {
                    self.backResponse = try JSONDecoder().decode(backendResponse.self, from: data!)
                    let httpResponse = response as? HTTPURLResponse
                    status = httpResponse!.statusCode
                } catch {
                    print("parse json error")
                }*/
                DispatchQueue.main.async {
                 /*  if status == 200 {
                   self.performSegue(withIdentifier: "Login", sender: sender)/

                        
                    }*/
                    print("test-------------")
                    print(self.Id_post!)
                }
            }
        }.resume()
        
    }
    
    @IBAction func Editpost(_ sender: Any) {
        performSegue(withIdentifier: "EditPost", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditPost" {
          let des = segue.destination as! EditPostViewController
            des.Id_post = Id_post
          des.name = name
            des.hospital = hospital
          des.Blood = Blood
          des.phone = phone
            des.Situation = Situation
        
    }
    
}
}
