import UIKit
import MapKit

class MapViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet var txtLatitude: UITextField!

    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var mapView: MKMapView!
    
    static var search = 0
    
    let locManager = CLLocationManager()
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var a10: [MKAnnotation] = [MKAnnotation]()
    var routesarr: [MKOverlay] = [MKOverlay]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.requestLocation()
        print(locManager.location!)
        let a = locManager.location!.coordinate.latitude
        let b = locManager.location!.coordinate.longitude
        
        let location = CLLocationCoordinate2DMake(a,b)
        let annotation = MKPointAnnotation()
        mapView.delegate = self
        mapView.removeAnnotation(annotation as MKAnnotation)
        annotation.coordinate = location
        annotation.title = "Current Location"
        mapView.addAnnotation(annotation)
        
        txtLatitude.delegate = self
        mapView.mapType = MKMapType.hybridFlyover
        segment.selectedSegmentIndex = 2
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier){
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else{
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        if let annotationView = annotationView {
            annotationView.frame = CGRect(x:0,y:0,width:200,height:40)
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "pin")
        }
        return annotationView
        
    }
    
    @IBAction func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
        let annotation = MKPointAnnotation()
        annotation.title = "Tapped Location"
        annotation.subtitle = "\(locationCoordinate)"
        annotation.coordinate = locationCoordinate
        a10.append(annotation)
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        func getTitle() -> String{
            if ((view.annotation?.title)!) !=  nil {
                return ((view.annotation?.title)!)!
            }else{
                return " "
            }
            
        }
        func getSubTitle() -> String{
            if ((view.annotation?.subtitle)!) !=  nil {
                return ((view.annotation?.subtitle)!)!
            }else{
                return " "
            }
        }
        let alert1 = UIAlertController(title: "Location Details", message: "Name:"+getTitle()+getSubTitle(), preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        let action1 = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            var index = -1
            self.mapView.removeAnnotation(view.annotation!)
            
            for anno in self.a10{
                if(anno as! _OptionalNilComparisonType == view.annotation){
                    index += 1
                    break
                }
            }
            print(index)
            self.mapView.remove(self.routesarr[index])
            if(self.matchingItems.count != 0){
                self.matchingItems.remove(at: index)
            }
            self.a10.remove(at: index)
            self.routesarr.remove(at: index)
        }
        
        let action2 = UIAlertAction(title: "Create Route", style: .destructive) { (action) in
            self.createRoutes(location1: (self.locManager.location?.coordinate)!, location2: view.annotation as! MKPointAnnotation)
        }
        
        alert1.addAction(action1)
        
        alert1.addAction(action)
        
        alert1.addAction(action2)
        
        self.present(alert1, animated: true, completion: nil)
    }
    
    func createRoutes(location1: CLLocationCoordinate2D,location2: MKPointAnnotation){
        let sourcePlace = MKPlacemark(coordinate: location1, addressDictionary: nil)
        let destinationPlace = MKPlacemark(coordinate: location2.coordinate, addressDictionary: nil)
        
//        let distance = MKDis
        
        let sourceMapItem = MKMapItem(placemark: sourcePlace)
        let destinationMapItem = MKMapItem(placemark: destinationPlace)
        
        let directionReq = MKDirectionsRequest()
        directionReq.source = sourceMapItem
        directionReq.destination = destinationMapItem
        directionReq.transportType = .automobile
        
        let directions = MKDirections(request: directionReq)
        
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("error in direction generation: \(error)")
                }
                return
            }
            
            
            let route = response.routes[0]
            let distance = route.distance
            print(distance)
            self.routesarr.append(route.polyline)
            self.mapView.add(route.polyline,level: MKOverlayLevel.aboveRoads)
            location2.subtitle = "\nDistance:"+String(describing: distance)+"meters\nExpectedTime:"+String(describing: route.expectedTravelTime)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            let span = MKCoordinateSpanMake(5, 5)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtLatitude.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(MapViewController.search != 0){
            mapView.removeAnnotations(a10)
            mapView.removeOverlays(routesarr)
        }
        self.performSearch()
    }
    @IBAction func change(_ sender: Any) {
        switch ((sender as AnyObject).selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    
    @IBAction func myLocation(_ sender: Any) {
        let span = MKCoordinateSpanMake(5, 5)
        let region = MKCoordinateRegionMake((locManager.location?.coordinate)!, span)
        mapView.setRegion(region, animated: true)
    }
    
    func performSearch() {
        MapViewController.search += 1
        matchingItems.removeAll()
        a10.removeAll()
        routesarr.removeAll()
        
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
                    func getName() -> String{
                        if item.phoneNumber != nil {
                            return item.phoneNumber!
                        }else{
                            return " "
                        }
                    }
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name!+"("+getName()+")"
                    print(annotation.coordinate)
                    self.a10.append(annotation)
                    self.mapView.addAnnotation(annotation)
                    
                }
            }
        })
    }
    
}


/*
 var lat = ""
 var lng = ""
 
 let alert1 = UIAlertController(title: "Destination", message: "Enter Destination location", preferredStyle: .alert)
 
 var location1: CLLocationCoordinate2D!
 var annotation1: MKPointAnnotation!
 
 let alert2 = UIAlertController(title: "Requested Route", message: "route", preferredStyle: .alert)
 
 let action1 = UIAlertAction(title: "Show", style: .default) { (action) in
 
 }
 
 alert2.addAction(action1)
 
 let action = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {
 alert -> Void in
 
 let firstTextField = alert1.textFields![0] as UITextField
 let secondTextField = alert1.textFields![1] as UITextField
 
 lat = firstTextField.text!
 lng = secondTextField.text!
 
 location1 = CLLocationCoordinate2DMake(Double(lat)!,Double(lng)!)
 annotation1 = MKPointAnnotation()
 annotation1.coordinate = location1
 annotation1.title = "Entered Location"
 self.mapView.addAnnotation(annotation1)
 self.present(alert2, animated: true, completion: nil)
 })
 
 alert1.addTextField { (textField : UITextField!) -> Void in
 textField.placeholder = "Enter First Name"
 textField.keyboardType = UIKeyboardType.numberPad
 }
 alert1.addTextField { (textField : UITextField!) -> Void in
 textField.placeholder = "Enter Second Name"
 textField.keyboardType = UIKeyboardType.numberPad
 }
 alert1.addAction(action)
 
 self.present(alert1, animated: true, completion: nil)
*/
