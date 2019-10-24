//
//  Extensions.swift
//  PhaseTime
//
//  Created by Keshav Bansal on 24/10/19.
//  Copyright © 2019 Keshav Bansal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(masksToBounds: Bool = false) {
        self.layer.masksToBounds = masksToBounds
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.24
        self.layer.shadowRadius = 6.0
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
}

extension SavedPinPickerVC {
    
    class func getInstance() -> SavedPinPickerVC {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController =  storyBoard.instantiateViewController(withIdentifier: "SavedPinPickerVC") as! SavedPinPickerVC
        return viewController
    }
}
