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
import SideMenu
class mapViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetLocationmanager()
        setMapView()
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
    func SetLocationmanager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func setMapView(){
        mapView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
}
extension mapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let coordinate = location.coordinate
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Your Location"
            mapView.addAnnotation(annotation)
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
extension mapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
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
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
extension mapViewController: UIGestureRecognizerDelegate {
    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            let tapPoint = gesture.location(in: mapView)
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


