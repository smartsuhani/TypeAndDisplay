import UIKit
import MapKit

class MapViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate {

    @IBOutlet var txtLatitude: UITextField!

    @IBOutlet var mapView: MKMapView!
    
    var locManager = CLLocationManager()
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        txtLatitude.delegate = self
        mapView.mapType = MKMapType.hybridFlyover
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.requestLocation()
        
        let location = CLLocationCoordinate2DMake((locManager.location?.coordinate.latitude)!, (locManager.location?.coordinate.longitude)!)
        let annotation = MKPointAnnotation()
        mapView.removeAnnotation(annotation as MKAnnotation)
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            let span = MKCoordinateSpanMake(0.5, 0.5)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locManager.requestLocation()
        }
    }
    
    
    
    @IBAction func textEdit(_ sender: Any) {
        txtLatitude.resignFirstResponder()
        mapView.removeAnnotation(mapView.annotations as! MKAnnotation)
        self.performSearch()
    }
    @IBAction func change(_ sender: Any) {
        switch ((sender as AnyObject).selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default: // or case 2
            mapView.mapType = .hybrid
        }
    }
    
    func performSearch() {
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = txtLatitude.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name!
                    print(annotation.coordinate)
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }
    
}
