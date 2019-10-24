//
//  PinnedLocationRW.swift
//  PhaseTime
//
//  Created by Keshav Bansal on 10/07/18.
//  Copyright © 2018 Keshav Bansal. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation

typealias PinnedLocationRW = PinnedLocation

extension PinnedLocationRW {

    class func getAllSavedCoordinates() -> Results<PinnedLocation> {
        let realm = try! Realm()
        let results = realm.objects(PinnedLocation.self)
        return results
    }
    
    func getCopiesIfAny() -> Results<PinnedLocation> {
        let epsilon: Float = 0.00001;
        let predicate = NSPredicate(format: "latitude > %f AND longitude > %f AND latitude < %f AND longitude < %f", self.latitude - epsilon, self.longitude - epsilon, self.latitude + epsilon, self.longitude + epsilon)
        let results = PinnedLocationRW.getAllSavedCoordinates().filter(predicate)
        return results
    }
    
    func saveToDB() {
        let results = self.getCopiesIfAny()
        if results.count == 0 {
            let realm = try! Realm()
            try! realm.write {
                realm.add(self)
            }
        }
    }
    
    func isLocationPinned() -> Bool {
        let results = self.getCopiesIfAny()
        return results.count != 0
    }
    
    func unpin() {
        let results = self.getCopiesIfAny()
        let realm = try! Realm()
        try! realm.write {
            realm.delete(results)
        }
    }
    
    func getLatitudeFloatString() -> String {
        return String(format: "%.5f", self.latitude)
    }
    
    func getLongitudeFloatString() -> String {
        return String(format: "%.5f", self.longitude)
    }
    
    func getCoordinateString() -> String {
        return self.getLatitudeFloatString() + ", " + self.getLongitudeFloatString()
    }
    
    func getLatitudeCLDegrees() -> CLLocationDegrees {
        return CLLocationDegrees(self.latitude)
    }

    func getLongitudeCLDegrees() -> CLLocationDegrees {
        return CLLocationDegrees(self.longitude)
    }
    
    func getCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.getLatitudeCLDegrees(), longitude: self.getLongitudeCLDegrees())
    }
}
