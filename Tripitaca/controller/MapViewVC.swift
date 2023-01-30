//
//  MapViewVC.swift
//  Tripitaca
//
//  Created by Ernest Mwangi on 27/01/2023.
//

import UIKit
import MapKit

class MapViewVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!

    public var passedLatitude: Double?
    public var passedLongitude: Double?
    public var passedName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarTitle.title = passedName

        setPinUsingMKPointAnnotation(placeName: passedName! , location: CLLocationCoordinate2D(latitude: passedLatitude!, longitude: passedLongitude!))
    }

    func setPinUsingMKPointAnnotation(placeName: String, location: CLLocationCoordinate2D){
       let annotation = MKPointAnnotation()
       annotation.coordinate = location
       annotation.title = placeName
       annotation.subtitle = "Hotel Location"
       let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
    }

    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
    }

}
