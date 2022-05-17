//
//  HomeViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 08/04/2022.
//

import UIKit
import CoreData

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
  
    @IBOutlet weak var tablepost: UITableView!
   
    
    
    @IBOutlet weak var bloodtype: UILabel!
    @IBOutlet weak var usertypetxt: UILabel!
    var connectedUser:User = User(id: "notyet", name: "", email: "", blood: "", age: 0, weight: "" , adress: "", phone: 0, usertype: "", avatar: "", token: "")
    fileprivate let baseURL = "https://server-oneblood.herokuapp.com/"
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var CadreHistorique: UIView!
    @IBOutlet weak var cadreinfoUser: UIView!
    var filteredPatients : [Needy] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPatients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mcell", for: indexPath)
          //  cell.layer.cornerRadius = 10
            let contentView = cell.contentView
            
            let Date = contentView.viewWithTag(2) as! UILabel
            let Situation = contentView.viewWithTag(3) as! UILabel

            let Blood = contentView.viewWithTag(1) as! UIImageView
            

        cell.contentView.backgroundColor = UIColor(red: 24, green: 24, blue: 56 )

            Date.text = "Date Post : " + filteredPatients[indexPath.row].datepost
            Situation.text = "Situation : " + filteredPatients[indexPath.row].situation
        Blood.image = UIImage(named: filteredPatients[indexPath.row].blood)
        
        
        if(Situation.text!.contains( "Danger"))
        {
            Situation.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
            
        }
        if(Situation.text!.contains( "Normal"))
        {
            Situation.textColor = UIColor(red: 0, green:153, blue: 0, alpha: 1.0)
            
        }
        if(Situation.text!.contains( "Closed"))
        {
            Situation.textColor = UIColor.gray
            
        }
        return cell
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cadreinfoUser.layer.shadowColor = UIColor.black.cgColor
        cadreinfoUser.layer.shadowOpacity = 1
        cadreinfoUser.layer.shadowOffset = .zero
        cadreinfoUser.layer.shadowRadius = 1
        cadreinfoUser.layer.shadowPath = UIBezierPath(rect: cadreinfoUser.bounds).cgPath
        cadreinfoUser.layer.shouldRasterize = true
        cadreinfoUser.layer.rasterizationScale = UIScreen.main.scale
////////////////////
        CadreHistorique.layer.shadowColor = UIColor.black.cgColor
        CadreHistorique.layer.shadowOpacity = 1
        CadreHistorique.layer.shadowOffset = .zero
        CadreHistorique.layer.shadowRadius = 1
        CadreHistorique.layer.shadowPath = UIBezierPath(rect: cadreinfoUser.bounds).cgPath
        CadreHistorique.layer.shouldRasterize = true
        CadreHistorique.layer.rasterizationScale = UIScreen.main.scale
/////////////////

        imageProfile.layer.cornerRadius = imageProfile.frame.size.height/2
        imageProfile.layer.borderWidth = 1
        imageProfile.clipsToBounds = true
         self.view.addSubview(imageProfile)
        self.view.layoutIfNeeded()
        
        getConnectedUser()
       setupUser()
        
        guard let url = URL(string: baseURL+"GetAllMyPost") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
       var iduser = connectedUser.id
        request.setValue(  iduser ,forHTTPHeaderField: "postedby")
 
        var status = 0
        
       
    URLSession.shared.dataTask(with: request) { (data,response,error) in
            if error == nil{
                do {
                    self.filteredPatients = try JSONDecoder().decode([Needy].self, from: data!)
                } catch {
                    print("parse json error")
                }
                
                DispatchQueue.main.async {
                   
            self.tablepost.performBatchUpdates(
                
                      {
                        
                        self.tablepost.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
                      }, completion: { (finished:Bool) -> Void in
                    })
                    
                    //self.filterProducts.reloadData()
                    //self.Products.reloadData()
                }
            }
        }.resume()
        ///

        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        getConnectedUser()
        bloodtype.text = connectedUser.blood
        usertypetxt.text = connectedUser.usertype
        print("yyyyyyyy")
        
        
        
        
        
        
        guard let url = URL(string: baseURL+"GetAllMyPost") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
       var iduser = connectedUser.id
        request.setValue(  iduser ,forHTTPHeaderField: "postedby")
 
        var status = 0
        
       
    URLSession.shared.dataTask(with: request) { (data,response,error) in
            if error == nil{
                do {
                    self.filteredPatients = try JSONDecoder().decode([Needy].self, from: data!)
                } catch {
                    print("parse json error")
                }
                
                DispatchQueue.main.async {
                   
            self.tablepost.performBatchUpdates(
                
                      {
                        
                        self.tablepost.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
                      }, completion: { (finished:Bool) -> Void in
                    })
                    
                    //self.filterProducts.reloadData()
                    //self.Products.reloadData()
                }
            }
        }.resume()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
    }
    func setupUser() {
        /*
        //let avatarUrl = baseURL + "uploads/users/" + connectedUser.avatar
        ProfilePic.sd_setImage(with: URL(string: avatarUrl), placeholderImage: UIImage(named: "nikeair"), options: [.continueInBackground, .progressiveLoad])*/
        bloodtype.text = connectedUser.blood
        usertypetxt.text = connectedUser.usertype
        print("yyyyyyyy")
        self.view.layoutIfNeeded()

    }
    
    
    
    func getConnectedUser() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Connected")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for obj in result {
                self.connectedUser.id =  (obj.value(forKey: "id") as! String)
                self.connectedUser.name=(obj.value(forKey: "name") as! String)
                self.connectedUser.phone=(obj.value(forKey: "phone") as! Int)
                self.connectedUser.email=(obj.value(forKey: "email") as! String)
                self.connectedUser.age=(obj.value(forKey: "age") as! Int)
                self.connectedUser.usertype=(obj.value(forKey: "usertype") as! String)
                self.connectedUser.blood=(obj.value(forKey: "bloodtype") as! String)
                self.connectedUser.avatar=(obj.value(forKey: "avatar") as! String)
                self.connectedUser.adress=(obj.value(forKey: "adress") as! String)
                self.connectedUser.token=(obj.value(forKey: "token") as! String)
                
            }
            
         
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    


}
