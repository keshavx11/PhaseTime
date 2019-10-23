//
//  ViewController.swift
//  PhaseTime
//
//  Created by Keshav Bansal on 09/07/18.
//  Copyright © 2018 Keshav Bansal. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SolarCalculatorVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: UIView!
    @IBOutlet var navView: UIView!
    @IBOutlet weak var addPinButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    var currentLocation: PinnedLocation!
    var marker = GMSMarker()
    var map: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addShadowToNavBar()
        self.setUpLocationManager()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.loadMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func addShadowToNavBar() {
        self.navView.layer.shadowColor = UIColor.black.cgColor
        self.navView.layer.shadowOpacity = 0.24
        self.navView.layer.shadowRadius = 6.0
        self.navView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.navView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }
    
    func loadMap() {
        self.currentLocation = PinnedLocation(coordinate: CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20), title: "Sydney", snippet: "Australia")
        let camera = GMSCameraPosition.camera(withTarget: self.currentLocation.getCoordinates(), zoom: 6.0)
        let mapFrame = CGRect(origin: CGPoint.zero, size: self.mapView.frame.size)
        self.map = GMSMapView.map(withFrame: mapFrame, camera: camera)
        map.delegate = self
        self.setMarker(atLocation: self.currentLocation)
        self.marker.map = map
        self.mapView.addSubview(map)
    }
    
    func reloadMap(atLocation location: PinnedLocation) {
        self.currentLocation = location
        let camera = GMSCameraPosition.camera(withTarget: self.currentLocation.getCoordinates(), zoom: 6.0)
        self.map.camera = camera
        self.setMarker(atLocation: self.currentLocation)
        if self.currentLocation.isLocationPinned() {
            self.addPinButton.setImage(#imageLiteral(resourceName: "remove"), for: .normal)
        } else {
            self.addPinButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        }
    }
    
    func setMarker(atLocation location: PinnedLocation) {
        marker.position = location.getCoordinates()
        marker.title = "Sydney"
        marker.snippet = "Australia"
    }
    
    func setUpLocationManager() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.locationManager.stopUpdatingLocation()
        let newLoc = PinnedLocation(coordinate: locValue, title: "Sydney", snippet: "Australia")
        self.reloadMap(atLocation: newLoc)
    }

    func updateLocationoordinates(coordinates:CLLocationCoordinate2D) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.01)
        self.marker.position =  coordinates
        CATransaction.commit()
    }
    
    // Camera change Position this methods will call every time
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let destinationLocation = CLLocation(latitude: position.target.latitude,  longitude: position.target.longitude)
        let destinationCoordinate = destinationLocation.coordinate
        updateLocationoordinates(coordinates: destinationCoordinate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SolarCalculatorVC {
    
    @IBAction func addPinClicked() {
        if self.currentLocation.isLocationPinned() {
            let newLoc = PinnedLocation(coordinate: self.currentLocation.getCoordinates(), title: self.currentLocation.title, snippet: self.currentLocation.snippet)
            self.currentLocation.unpin()
            self.currentLocation = newLoc
        } else {
            self.currentLocation.saveToDB()
        }
        self.reloadMap(atLocation: self.currentLocation)
    }
    
    @IBAction func showAllPinsClicked() {
        
    }
    
}

extension SolarCalculatorVC: UISearchBarDelegate, GMSAutocompleteViewControllerDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(autocompleteController, animated: true)
        searchBar.resignFirstResponder()
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.locationManager.stopUpdatingLocation()
        let newLoc = PinnedLocation(coordinate: place.coordinate, title: place.name, snippet: place.addressComponents?.last?.name)
        self.reloadMap(atLocation: newLoc)
        self.navigationController?.popViewController(animated: true)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
        self.navigationController?.popViewController(animated: true)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
