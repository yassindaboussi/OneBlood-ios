//
//  PopMapViewController.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 11/05/2022.
//
import MapKit
import CoreLocation
import UIKit


class PopMapViewController: UIViewController ,MKMapViewDelegate {
    let ID_TABBAR = "TabBarViewController"
    var name :String?
    var Location :String?
    var Phone :String?
    var Latitude : String?
    var Longitude : String?
    
    let geocoder = CLGeocoder()


    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = name
        lblLocation.text = Location
        lblPhone.text = Phone
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
            if touch.view == self.view1 {
                let tabBarController = self.storyboard?.instantiateViewController(identifier:ID_TABBAR) as! UITabBarController
                   self.navigationController?.pushViewController(tabBarController, animated:true)
                self.dismiss(animated:true, completion:nil);
                self.navigationController?.popViewController(animated:true);
            }
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    


    @IBAction func Callclicked(_ sender: Any) {
        guard let url = URL(string: "telprompt://\( Phone)"),
             UIApplication.shared.canOpenURL(url) else {
             return
         }
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    
    
    @IBAction func OpenMapClicked(_ sender: Any) {
 
        
        guard let lat = Latitude, let latDouble =  Double(lat) else {return }
                guard let long = Longitude, let longDouble =  Double(long) else {return }
        /*
                        
                        let coordinate = CLLocationCoordinate2DMake(latDouble,longDouble)
        
                                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
                                    mapItem.name = name
                                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
              
       
        */
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
                        
                        if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(latDouble),\(longDouble)&directionsmode=driving") {
                            UIApplication.shared.open(url, options: [:])
                        }}
                    else {
                        //Open in browser
                        if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latDouble),\(longDouble)&directionsmode=driving") {
                            UIApplication.shared.open(urlDestination)
                        }
                    }
        //////////////
 

      
    }
    


}
