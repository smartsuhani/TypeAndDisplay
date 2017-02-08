import UIKit
import MapKit

class MapViewController: UIViewController {

    var lng: Float!
    var lat: Float!
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentLocation = MKMapItem.forCurrentLocation()
        /*let markTaipei = MKPlacemark(coordinate: CLLocationCoordinate2DMake(25.0305, 121.5360), addressDictionary: nil)*/
        //let taipei = MKMapItem(placemark: markTaipei)
        //taipei.name = "Taipei Daan Park"
        let array = NSArray(objects: currentLocation)
        let parameter = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)
        MKMapItem.openMaps(with: array as! [MKMapItem], launchOptions: parameter as? [String : Any])
    }

}
