//
//  PinnedLocation.swift
//  PhaseTime
//
//  Created by Keshav Bansal on 10/07/18.
//  Copyright © 2018 Keshav Bansal. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import CoreLocation

class PinnedLocation: Object {

    @objc dynamic var latitude: Float = 0
    @objc dynamic var longitude: Float = 0
    @objc dynamic var title: String?
    @objc dynamic var snippet: String?
    
    var clLocation: CLLocation {
        get {
            CLLocation(latitude: CLLocationDegrees(self.latitude), longitude: CLLocationDegrees(self.longitude))
        }
    }
    
    var name: String {
        get {
            return self.title ?? self.getCoordinateString()
        }
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String?, snippet: String?) {
        super.init()
        self.latitude = Float(coordinate.latitude)
        self.longitude = Float(coordinate.longitude)
        self.title = title
        self.snippet = snippet
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema){
        super.init(realm: realm, schema: schema)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value:value, schema:schema)
    }
    
}
