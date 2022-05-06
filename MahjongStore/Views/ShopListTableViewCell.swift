//
//  ShopListTableViewCell.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/4.
//

import UIKit
import MapKit

//The class for the custom tableViewCell on the page of shop address list.
class ShopListTableViewCell: UITableViewCell,MKMapViewDelegate{

    @IBOutlet weak var shopImg: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopAddress: UILabel!
    @IBOutlet weak var opennMapButton: UIButton!
    @IBOutlet weak var shopMap: MKMapView!
    
    
    var itemModel = [String:String](){
        
        didSet{
            
            shopName.text = itemModel["shopName"]
            shopAddress.text = itemModel["shopAddress"]
            shopImg.loadImageFrom(url: itemModel["shopImage"]!)
            
            let coordinate =   CLLocationCoordinate2D.init(latitude: Double(itemModel["lat"]!)! , longitude: Double(itemModel["lon"]!)!)
            
            shopMap.setRegion(MKCoordinateRegion.init(center: coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
            self.addAnnotation(coordinate: coordinate, title: "", subtitle: itemModel["shopName"]!)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code.
    }
    //add Annotation
    func addAnnotation(coordinate:CLLocationCoordinate2D,title:String,subtitle:String){
        
        let annotattion = MKPointAnnotation.init()
        annotattion.coordinate = coordinate
//        annotattion.title = title
//        annotattion.subtitle = subtitle
        shopMap.removeAnnotations(shopMap.annotations)
        shopMap.addAnnotation(annotattion)
        
    }
    //Setup the map view. 
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "an")
        annotationView?.frame.size = CGSize(width: 25, height: 25)
        if annotationView == nil {
            
            annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "an")
        }
        annotationView?.image = UIImage.init(named:itemModel["shopId"]! )
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state.
    }

}
