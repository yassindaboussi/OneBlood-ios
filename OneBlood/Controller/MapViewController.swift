//
//  MapViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 11/05/2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController , CLLocationManagerDelegate , UITableViewDelegate ,UITableViewDataSource, UISearchBarDelegate

{
    var filteredData: [Information]!
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var showmylocation: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listhospi.MapAll.count
    }
    

    
    
    //   public var Maptunis:Information = Information(Nom: "String", Location: "String", Numero: "String", Longitude: "String", Latitude: "String")
   
   // var Maptunis = [Information]()
    
    var listhospi = listmap()
    
    let manger = CLLocationManager()
    
    var areaname = ""
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01 , longitudeDelta: 0.01 )
        let mylocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude,longitude: location.coordinate.longitude )
        let region:MKCoordinateRegion = MKCoordinateRegion(center: mylocation,span: span)
        print(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location){ (MKPlacemark , Error) in
            if Error != nil
            {
                print("there was an error")
            }
            else{
                if let place = MKPlacemark?[0]{
                    print("+++++++++place+++++")
                    print( place.country)
                    self.areaname = place.country!
                    
                    self.showmylocation.text = place.country!
                    
      
                }
            }
            
            
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mcell", for: indexPath)
            
            let contentView = cell.contentView
            
            let Name = contentView.viewWithTag(1) as! UILabel
            let Location = contentView.viewWithTag(2) as! UILabel
            let Phone = contentView.viewWithTag(3) as! UILabel
        /*
           // let Hospital = contentView.viewWithTag(5) as! UILabel
        Name.text = filteredData[indexPath.row].Nom
        Location.text = filteredData[indexPath.row].Location
        Phone.text = filteredData[indexPath.row].Numero
         */
        
 if(self.showmylocation.text == listhospi.MapAll[indexPath.row].city || self.showmylocation.text == "ben arous" || self.showmylocation.text == "manouba")
        {
  var list = listhospi.MapAll.filter({ $0.city.hasPrefix(self.showmylocation.text!)})
            print( "tunnnniiiiisss")
           // var list = listhospi.Maptunis[indexPath.row]
    Name.text = listhospi.Maptunis[indexPath.row].Nom
            Location.text = listhospi.Maptunis[indexPath.row].Location
            Phone.text = listhospi.Maptunis[indexPath.row].Numero

            
        }else{
            Name.text = listhospi.MapAll[indexPath.row].Nom
                    Location.text = listhospi.MapAll[indexPath.row].Location
                    Phone.text = listhospi.MapAll[indexPath.row].Numero
            
        }
 
/*
        let namesWithL = listhospi.MapAll.filter{ $0.Nom.contains(self.showmylocation.text!) }
        for student in namesWithL {
            listhospi.MapAll = [student]
            //print(student)
            
            Name.text = listhospi.MapAll[indexPath.row].Nom
            Location.text = listhospi.MapAll[indexPath.row].Location
            Phone.text = listhospi.MapAll[indexPath.row].Numero
        }
        self.tableview.reloadData()
        

        
         */
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar,textDidChange searchText: String){
        if searchBar==searchbar {
            if searchText.isEmpty {
                print("empty search")
               // listhospi.Maptunis
                
                let namesWithL = listhospi.MapAll
                for student in namesWithL {
                    tableview.reloadData()
                    listhospi.MapAll = [student]
                  print(student)
                  
                }
               
            }else{
                let namesWithL = listhospi.MapAll.filter{ $0.Nom.contains(searchText) }
                for student in namesWithL {
                    listhospi.MapAll = [student]
                  print(student)
                    tableview.reloadData()
                }
              
            }
        }
    }
    
   /*
    func getSearchResults(searchString:String) -> Void {
        let parameters = ["searchString" : searchString]
        guard let url = URL(string: baseURL+"api/products/search") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if error == nil{
                do {
                    self.searchResult = try JSONDecoder().decode([SearchModel].self, from: data!)
                } catch {
                    print("parse search result error")
                }
        
                DispatchQueue.main.async {
                    self.searchList.reloadData()
                }
            }
        }.resume()
    }
    
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoPopMap", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="GoPopMap" {
           let indexPath = sender as! IndexPath
            let product = listhospi.MapAll[indexPath.row]
               let destination = segue.destination as! PopMapViewController
            destination.name = product.Nom
            destination.Location = product.Location
            destination.Phone = product.Numero
            destination.Latitude = product.Latitude
            destination.Longitude = product.Longitude
            
       
      
    }
    }
  
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listhospi.AddTask()
        print("list")
        tableview.dataSource = self
        searchbar.delegate = self
        filteredData = listhospi.MapAll
       // print(listhospi.Maptunis)
        
       // MapNabeul.append(Information(Nom: T##String, Location: <#T##String#>, Numero: <#T##String#>, Longitude: <#T##String#>, Latitude: <#T##String#>))
        // Do any additional setup after loading the view.
        
        
        manger.delegate = self
        manger.desiredAccuracy = kCLLocationAccuracyBest
        manger.requestWhenInUseAuthorization()
        manger.startUpdatingLocation()
        
        
        
        
        tableview.delegate = self
        tableview.dataSource = self
        searchbar.delegate = self
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
extension MapViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchbar
  
    // TODO
  }
}

