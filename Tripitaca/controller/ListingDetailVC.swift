//
//  ListingDetailVC.swift
//  Tripitaca
//
//  Created by Ernest Mwangi on 26/01/2023.
//

import UIKit
import AARatingBar
import MapKit

class ListingDetailVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var listingName: UILabel!
    @IBOutlet weak var listingLocation: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var featureImage: UIImageView!
    @IBOutlet weak var ratingView: AARatingBar!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var bookButton: UIButton!

    public var passedImage: String?
    public var passedName: String?
    public var passedLocation: String?
    public var passedRating: String?
    public var passedDesc: String?
    public var passedPrice: String?
    public var passedLatitude: Double?
    public var passedLongitude: Double?

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        loadPassedData()

    }

    func initViews(){
        contentView.layer.cornerRadius = 40
        bookButton.layer.cornerRadius = 10

        mapKit.layer.cornerRadius = 10
        mapKit.layer.borderWidth = 0.7
        mapKit.layer.borderColor = Colors.darkerWhite?.cgColor

        descriptionTextView.backgroundColor = .white
        descriptionTextView.showsVerticalScrollIndicator = true
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.setContentOffset(.zero, animated: true)
    }

    func loadPassedData(){
        featureImage.image = UIImage(named: passedImage!)

        listingName.text = passedName
        listingLocation.text = passedLocation
        ratingLabel.text = passedRating
        descriptionTextView.text = passedDesc
        priceLabel.text = passedPrice

        var cgFloat: CGFloat?

        if let doubleValue = Double(passedRating!) {
            cgFloat = CGFloat(doubleValue)
            ratingView.value = cgFloat!
        }

        setPinUsingMKPointAnnotation(placeName: passedName! , location: CLLocationCoordinate2D(latitude: passedLatitude!, longitude: passedLongitude!))


    }

    func setPinUsingMKPointAnnotation(placeName: String, location: CLLocationCoordinate2D){
       let annotation = MKPointAnnotation()
       annotation.coordinate = location
       annotation.title = placeName
       annotation.subtitle = "Hotel Location"
       let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapKit.setRegion(coordinateRegion, animated: true)
        mapKit.addAnnotation(annotation)
    }

    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func seeAllTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Alert", message: "Action to see all amenities", preferredStyle: .alert)

        let actionCancel = UIAlertAction(title: "Okay", style: .cancel) { (action:UIAlertAction) in
        }

        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func btnViewMapTapped(_ sender: Any) {

        let storyBoard: UIStoryboard = UIStoryboard(name: "ListingDetail", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewVC") as! MapViewVC
        newViewController.passedName = passedName
        newViewController.passedLatitude = passedLatitude
        newViewController.passedLongitude = passedLongitude

//        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)

    }



    @IBAction func actionBook(_ sender: Any) {
        let alertController = UIAlertController(title: "Alert", message: "Action to book this hotel", preferredStyle: .alert)

        let actionCancel = UIAlertAction(title: "Okay", style: .cancel) { (action:UIAlertAction) in
        }

        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
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
