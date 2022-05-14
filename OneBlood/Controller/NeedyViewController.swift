//
//  NeedyViewController.swift
//  OneBlood
//
//  Created by Mac2021 on 29/4/2022.
//

import UIKit
import CoreData

class NeedyViewController: UIViewController  {

    

    


    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var btnmatchblood: UIButton!
    @IBOutlet weak var ButtonAdd: UIButton!
    var index = true
    fileprivate let baseURL = "https://server-oneblood.herokuapp.com/"
    var connectedUser:User = User(id: "notyet", name: "", email: "", blood: "", age: 0, weight: "" , adress: "", phone: 0, usertype: "", avatar: "", token: "")

 
  
    
    @IBOutlet weak var NeedyView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "mcell")
        return cv
    }()
    
    var productList = [Needy]()


    override func viewDidLoad() {
        super.viewDidLoad()

        NeedyView.delegate = self
        NeedyView.dataSource = self
        getConnectedUser()
        // Do any additional setup after loading the view.
        
        //get products
        let productsUrl = URL(string: baseURL+"GetAllBesoin")
        URLSession.shared.dataTask(with: productsUrl!) { (data,response,error) in
            if error == nil{
                do {
                    self.productList = try JSONDecoder().decode([Needy].self, from: data!)
                } catch {
                    print("parse json error")
                }
                
                DispatchQueue.main.async {
                    

   
                    
                    self.NeedyView.performBatchUpdates(
                      {
                        self.NeedyView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                      }, completion: { (finished:Bool) -> Void in
                    })
                    
                    //self.filterProducts.reloadData()
                    //self.Products.reloadData()
                }
            }
        }.resume()
        

    }
    @IBAction func Clickpost(_ sender: Any)
    
    {
        if (index == true)
        {
        guard let url = URL(string: baseURL+"GetAllMyPost") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
       var iduser = connectedUser.id
        request.setValue(  iduser ,forHTTPHeaderField: "postedby")
 
        var status = 0
        
       
    URLSession.shared.dataTask(with: request) { (data,response,error) in
            if error == nil{
                do {
                    self.productList = try JSONDecoder().decode([Needy].self, from: data!)
                } catch {
                    print("parse json error")
                }
                
                DispatchQueue.main.async {
                    self.index = false
            self.NeedyView.performBatchUpdates(
                
                      {
                        
                        self.NeedyView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                      }, completion: { (finished:Bool) -> Void in
                    })
                    
                    //self.filterProducts.reloadData()
                    //self.Products.reloadData()
                }
            }
        }.resume()
            
        }
        else{
            let productsUrl = URL(string: baseURL+"GetAllBesoin")
            URLSession.shared.dataTask(with: productsUrl!) { (data,response,error) in
                if error == nil{
                    do {
                        self.productList = try JSONDecoder().decode([Needy].self, from: data!)
                    } catch {
                        print("parse json error")
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.index = true
       
                        
                        self.NeedyView.performBatchUpdates(
                          {
                            self.NeedyView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                          }, completion: { (finished:Bool) -> Void in
                        })
                        
                        //self.filterProducts.reloadData()
                        //self.Products.reloadData()
                    }
                }
            }.resume()
            
            
            
        }
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        getConnectedUser()
        if(connectedUser.usertype == "Donor")
        {
            ButtonAdd.isHidden = true
        }
        if(connectedUser.usertype == "Needy")
        {
            ButtonAdd.isHidden = false
        }
        
        NeedyView.delegate = self
        NeedyView.dataSource = self
        // Do any additional setup after loading the view.
        
        //get products
        let productsUrl = URL(string: baseURL+"GetAllBesoin")
        URLSession.shared.dataTask(with: productsUrl!) { (data,response,error) in
            if error == nil{
                do {
                    self.productList = try JSONDecoder().decode([Needy].self, from: data!)
                } catch {
                    print("parse json error")
                }
                
                DispatchQueue.main.async {
                    
            self.NeedyView.performBatchUpdates(
                      {
                        self.NeedyView.reloadSections(NSIndexSet(index: 0) as IndexSet)
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

    /*
    @IBAction func BtnEditClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "GoPop", sender: sender)
        
    }*/
    @IBAction func ButtonAddClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "AddNeedy", sender: sender)
        
    }

    
    
    }

func updateSearchResults(for searchController: UISearchController) {
    
}

func filtrenow(searchText : String , scopeButton :String = "All")
{
  // filtredshapes = shapes
    
}


    
extension NeedyViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
            if collectionView == NeedyView {
                return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
                    // Create an action for sharing
                    let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                        // Show share sheet
                    }

                    // Create an action for copy
                    let rename = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { action in
                        // Perform copy
                    }

                    // Create an action for delete with destructive attributes (highligh in red)
                    let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                        // Perform delete
                    }

                    // Create a UIMenu with all the actions as children
                    return UIMenu(title: "", children: [share, rename, delete])
                }
            }else{
                return nil
            }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    
        return CGSize(width: (NeedyView.frame.width - 2)/2, height:235)//collection width - (item spacing)/number of items in row
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mcell", for: indexPath)
        cell.layer.cornerRadius = 10
        let contentView = cell.contentView
        
        let Date = contentView.viewWithTag(2) as! UILabel
        let Situation = contentView.viewWithTag(3) as! UILabel
        let Nom = contentView.viewWithTag(4) as! UILabel
        let Hospital = contentView.viewWithTag(5) as! UILabel
        let Phone = contentView.viewWithTag(6) as! UILabel
        let Blood = contentView.viewWithTag(7) as! UIImageView
        let Btn = contentView.viewWithTag(8) as! UIButton

        

        Date.text = productList[indexPath.row].datepost
        Situation.text = productList[indexPath.row].situation
        Nom.text = productList[indexPath.row].nom
        Hospital.text = productList[indexPath.row].location
        
        Phone.text = String (productList[indexPath.row].phone)
        
        Blood.image = UIImage(named: productList[indexPath.row].blood)
  
       // Btn.addTarget(self, action: Selector("action:"), for: UIControl.Event.touchUpInside)
      
        
        
        if(productList[indexPath.row].postedby == connectedUser.id)
        {
            Btn.isHidden = false
        }
        else {
            Btn.isHidden = true
        }
        
        if(Situation.text == "Danger")
        {
            Situation.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
            
        }
        if(Situation.text == "Normal")
        {
            Situation.textColor = UIColor(red: 0, green:153, blue: 0, alpha: 1.0)
            
        }
        if(Situation.text == "Closed")
        {
            Situation.textColor = UIColor.gray
            
        }
        if((indexPath.row % 2) != 0)
        {
            cell.contentView.backgroundColor = UIColor(red: 24, green: 24, blue: 56 )
        }else
        {
            cell.contentView.backgroundColor = UIColor(red: 24, green: 24, blue: 56 )
        }
        Btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

      

        return cell
    }
    
    @objc func buttonAction(sender: UIButton!) {
        var superview = sender.superview
            while let view = superview, !(view is UICollectionViewCell) {
                superview = view.superview
            }
            guard let cell = superview as? UICollectionViewCell else {
                print("button is not contained in a table view cell")
                return
            }
            guard let indexPath = NeedyView.indexPath(for: cell) else {
                print("failed to get index path for cell containing button")
                return
            }
        performSegue(withIdentifier: "GoPop", sender: indexPath.row)
   
        /*
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        let home = self.storyboard?.instantiateViewController(withIdentifier: "PopOptionsViewController") as! PopOptionsViewController
     
        home.Id_post = productList[indexpath1.row]._id
        //self.navigationController?.pushViewController(home, animated:true)
        self.dismiss(animated:true, completion:nil);
       // self.navigationController?.popViewController(home,animated:true);*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
     if segue.identifier=="GoPop" {
        let indexPath = sender as! Int
            let product = productList[indexPath]
            let destination = segue.destination as! PopOptionsViewController
        destination.Id_post = product._id
        destination.Blood = product.blood
        destination.name = product.nom
        destination.hospital = product.location
        destination.phone = String (product.phone)
        destination.Situation = product.situation
        
        

        
            
       // destination. = product
        }

    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    /*    if collectionView==Products {
            performSegue(withIdentifier: "prodDetailSegue", sender: indexPath.row)
        }
        if collectionView==filterProducts {
            let filter = categories[indexPath.row]
            
            let filtered = self.fetchedProducts.filter { product in
                return product.category==filter
            }
            self.productList = filtered
            
            self.Products.performBatchUpdates(
              {
                self.Products.reloadSections(NSIndexSet(index: 0) as IndexSet)
              }, completion: { (finished:Bool) -> Void in
            })
            
            //self.Products.reloadData()
        }
     */
        
    }
    
    
  

    
    
    }

