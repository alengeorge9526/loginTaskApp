////
////  mapViewController.swift
////  loginTask
////
////  Created by Alen George on 30/08/23.
////
//
import UIKit
import MapKit
import CoreLocation
class mapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UIGestureRecognizerDelegate{



            @IBOutlet weak var mapView: MKMapView!
            @IBOutlet weak var latTextField: UITextField!
            @IBOutlet weak var longTextField: UITextField!

    @IBOutlet weak var btn: UIButton!


//                annotationView?.pinTintColor = .red
//
//            }
//
//        }else{
//
//            annotationView?.annotation = annotation
//
//        }
//
//
//
//        return annotationView
//
//    }
//
//
//
//    @IBAction func showMap(_ sender: UIButton) {
//
//        guard
//
//            let latitudeStr = latTextField.text,
//
//            let longitudeStr = longTextField.text,
//
//            let latitude = Double(latitudeStr),
//
//            let longtitude = Double(longitudeStr)
//
//        else{
//
//            return
//
//        }
//
//        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
//
//        let annotation = MKPointAnnotation()
//
//        annotation.coordinate = location
//
//        annotation.title = "Selected Location"
//
//        mapView.addAnnotation(annotation)
//
//        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//
//        let region = MKCoordinateRegion(center: location, span: span)
//
//        mapView.setRegion(region, animated: true)
//
//    }
//
//    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
//
//        if gesture.state == .ended {
//
//            // Get the tapped point on the map
//
//            let tapPoint = gesture.location(in: mapView)
//
//
//
//            // Convert the tapped point to a coordinate on the map
//
//            let coordinate = mapView.convert(tapPoint, toCoordinateFrom: mapView)
//
//            let geocoder = CLGeocoder()
//
//            geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { [weak self] placemarks, error in
//
//                if let error = error {
//
//                    print("Reverse geocoding error: \(error.localizedDescription)")
//
//                    return
//
//                }
//
//
//
//                guard let placemark = placemarks?.first else {
//
//                    print("No placemarks found")
//
//                    return
//
//                }
//
//
//
//                let annotation = MKPointAnnotation()
//
//                annotation.coordinate = coordinate
//
//                annotation.title = placemark.name
//
//                annotation.subtitle = placemark.locality
//
//                self?.mapView.addAnnotation(annotation)
//
//
//
//            }
//
//        }
//
//
//
//    }
//
//}

         var locationManager: CLLocationManager!
//
//        // Custom view for displaying location details
//
//        let locationDetailsView: LocationDetailsView = {
//              let view = LocationDetailsView()
//              view.translatesAutoresizingMaskIntoConstraints = false
//              return view
//          }()
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            locationManager = CLLocationManager()
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.startUpdatingLocation()
//            // Do any additional setup after loading the view.
//            mapView.delegate = self
//
//            // Add the custom location details view to the map view
//                    mapView.addSubview(locationDetailsView)
//                    locationDetailsView.isHidden = true
//
//                    // Create a tap gesture recognizer for the map view
//                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//                    mapView.addGestureRecognizer(tapGesture)
//        }
//        // Function to handle the tap gesture on the map view
//            @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
//                if gestureRecognizer.state == .ended {
//                    // Get the tapped point on the map view
//                    let point = gestureRecognizer.location(in: mapView)
//
//                    // Convert the tapped point to a coordinate
//                    let tappedCoordinate = mapView.convert(point, toCoordinateFrom: mapView)
//
//                    // Reverse geocode the coordinate to get location details
//                    let location = CLLocation(latitude: tappedCoordinate.latitude, longitude: tappedCoordinate.longitude)
//                    let geocoder = CLGeocoder()
//                    geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
//                        if let placemark = placemarks?.first {
//                            // Update the custom location details view with the placemark information
//                            self?.locationDetailsView.update(with: placemark)
//                            self?.locationDetailsView.isHidden = false
//                            self?.locationDetailsView.center = point
//                        }
//                    }
//                }
//            }
//
//
//
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            if let location = locations.last {
//                let coordinate = location.coordinate
//                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
//                mapView.setRegion(region, animated: true)
//
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = coordinate
//                annotation.title = "My Location"
//                mapView.addAnnotation(annotation)
//
//
//                locationManager.stopUpdatingLocation()
//            }
//        }
//
//        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//            // Handle location error
//            print("Location error: \(error.localizedDescription)")
//        }
//
//        @IBAction func showLocationButtonPressed(_ sender: UIButton) {
//            guard
//                let latitudeStr = latTextField.text,
//                let longitudeStr = longTextField.text,
//                let latitude = Double(latitudeStr),
//                let longitude = Double(longitudeStr)
//            else {
//                // Handle invalid input
//                return
//            }
//
//            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = location
//            annotation.title = "Selected Location"
//            mapView.addAnnotation(annotation)
//
//            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
//            let region = MKCoordinateRegion(center: location, span: span)
//            mapView.setRegion(region, animated: true)
//
//            //userLocation
//
//
//        }
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            if annotation is MKUserLocation {
//                return nil
//            }
//            let reuseIdentifier = "Customannotation"
//            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
//
//            if annotationView == nil {
//                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//                annotationView?.canShowCallout = true
//
//                if annotation.title == "My Location"{
//                    annotationView?.pinTintColor = .blue
//                }else {
//                    annotationView?.pinTintColor = .red
//                }
//            } else {
//                annotationView?.annotation = annotation
//            }
//            return annotationView
//        }
//
//
//    }
//
//class LocationDetailsView: UIView {
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let addressLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupUI()
//    }
//
//    private func setupUI() {
//        backgroundColor = UIColor.green
//        layer.cornerRadius = 8
//        layer.masksToBounds = true
//
//        addSubview(nameLabel)
//        addSubview(addressLabel)
//
//        NSLayoutConstraint.activate([
//            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//
//            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
//            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//            addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
//        ])
//    }
//
//    func update(with placemark: CLPlacemark) {
//        nameLabel.text = placemark.name
//        var formattedAddress = ""
//
//        if let thoroughfare = placemark.thoroughfare {
//            formattedAddress += thoroughfare + ", "
//        }
//
//        if let locality = placemark.locality {
//            formattedAddress += locality + ", "
//        }
//
//        if let administrativeArea = placemark.administrativeArea {
//            formattedAddress += administrativeArea + " "
//        }
//
//        if let postalCode = placemark.postalCode {
//            formattedAddress += postalCode
//        }
//
//        addressLabel.text = formattedAddress
//    }
//
//}
//






override func viewDidLoad() {

    super.viewDidLoad()

    locationManager = CLLocationManager()

    locationManager.delegate = self

    locationManager.desiredAccuracy = kCLLocationAccuracyBest

    locationManager.requestWhenInUseAuthorization()

    locationManager.startUpdatingLocation()

    mapView.delegate = self

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))

    mapView.addGestureRecognizer(tapGesture)

    // Do any additional setup after loading the view.

}



func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    if let location = locations.last {

        // Update map view with user's current location

        let coordinate = location.coordinate

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)

        mapView.setRegion(region, animated: true)

        

        // Add a user annotation to the map

        let annotation = MKPointAnnotation()

        annotation.coordinate = coordinate

        annotation.title = "Your Location"

        mapView.addAnnotation(annotation)

        

        // Stop updating location to conserve battery

        locationManager.stopUpdatingLocation()

    }

}





func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    print("Location error: \(error.localizedDescription)")

}





func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

    if annotation is MKUserLocation {

        return nil // Use default blue dot for user's location

    }

    

    let identifier = "CustomAnnotation"

    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

    

    

    if annotationView == nil {

        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)

        annotationView?.canShowCallout = true

        if annotation.title == "Your Location"{

            annotationView?.pinTintColor = .blue

        } else {

            annotationView?.pinTintColor = .red

        }

    }else{

        annotationView?.annotation = annotation

    }

    

    return annotationView

}



@IBAction func showMap(_ sender: UIButton) {

    guard

        let latitudeStr = latTextField.text,

        let longitudeStr = longTextField.text,

        let latitude = Double(latitudeStr),

        let longtitude = Double(longitudeStr)

    else{

        return

    }

    let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)

    let annotation = MKPointAnnotation()

    annotation.coordinate = location

    annotation.title = "Selected Location"

    mapView.addAnnotation(annotation)

    let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)

    let region = MKCoordinateRegion(center: location, span: span)

    mapView.setRegion(region, animated: true)

}

@objc func handleMapTap(_ gesture: UITapGestureRecognizer) {

    if gesture.state == .ended {

        // Get the tapped point on the map

        let tapPoint = gesture.location(in: mapView)

        

        // Convert the tapped point to a coordinate on the map

        let coordinate = mapView.convert(tapPoint, toCoordinateFrom: mapView)

        let geocoder = CLGeocoder()
        mapView.removeAnnotations(mapView.annotations)
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { [weak self] placemarks, error in

            if let error = error {

                print("Reverse geocoding error: \(error.localizedDescription)")

                return

            }

            

            guard let placemark = placemarks?.first else {

                print("No placemarks found")

                return

            }

            

            let annotation = MKPointAnnotation()

            annotation.coordinate = coordinate

            annotation.title = placemark.name

            annotation.subtitle = placemark.locality

            self?.mapView.addAnnotation(annotation)

            

        }

    }

    

}

}


