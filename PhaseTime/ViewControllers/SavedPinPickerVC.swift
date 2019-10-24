//
//  SavedPinPickerVC.swift
//  PhaseTime
//
//  Created by Keshav Bansal on 24/10/19.
//  Copyright © 2019 Keshav Bansal. All rights reserved.
//

import UIKit
import RealmSwift

class SavedPinPickerVC: UIViewController {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var pinnedLocations: Results<PinnedLocation>!
    
    // true for positive action
    var didSelectLocation: (PinnedLocation) -> Void = { (location: PinnedLocation) in }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configureVC() {
        self.overlayView.alpha = 0.2
        self.containerView.addShadow()
        self.pinnedLocations = PinnedLocationRW.getAllSavedCoordinates()
        self.tableView.reloadData()
        self.presentAnimateTransition()
    }
    
    func presentAnimateTransition() {
        self.containerView.center = self.view.center
        self.containerView.transform = CGAffineTransform.init(scaleX: 0.4, y: 0.4)
        self.containerView.alpha = 0
        UIView.animate(withDuration: 0.33) {
            self.containerView.alpha = 1
            self.containerView.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func overlayViewTapped(_ tapGesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SavedPinPickerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pinnedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = self.pinnedLocations[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = location.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let location = self.pinnedLocations[indexPath.row]
        self.didSelectLocation(location)
        self.dismiss(animated: true, completion: nil)
    }
    
}
