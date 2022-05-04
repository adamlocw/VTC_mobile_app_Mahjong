//
//  MapViewController.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/4.
//

import UIKit

import MapKit

//Open the Map View in application
class MapViewController: UIViewController,MKMapViewDelegate {

    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var shopModel = [String:String]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

      //Setup the map location
        let coordinate =    CLLocationCoordinate2D.init(latitude: Double(shopModel["lat"]!)! , longitude: Double(shopModel["lon"]!)!)
        
        self.mapView.setRegion(MKCoordinateRegion.init(center: coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D.init(latitude: Double(shopModel["lat"]!)! , longitude: Double(shopModel["lon"]!)!)
        annotation.title = shopModel["shopName"]!
        self.mapView.addAnnotation(annotation)
    }
   

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        if  annotation  is  MKUserLocation  {return  nil}
        
        let  reuserId =  "pin"
        var  pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuserId)
            as?  MKPinAnnotationView
        if  pinView ==  nil  {
            pinView =  MKPinAnnotationView (annotation: annotation, reuseIdentifier: reuserId)
            pinView?.canShowCallout =  true
            pinView?.animatesDrop =  true
            pinView?.pinTintColor =  UIColor .red
            pinView?.rightCalloutAccessoryView =  UIButton (type: .detailDisclosure)
        } else {
            pinView?.annotation = annotation
        }
        
        return  pinView
    }
       

}
