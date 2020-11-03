//
//  ViewController.swift
//  disturbingRegion
//
//  Created by sayone73 on 28/10/2020.
//  Copyright © 2020 rinoy. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet var monitoringLabel: UILabel!
    @IBOutlet var addBeacon: UIButton!
    var locationHandler : LocationHandler = LocationHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        monitoringLabel.isHidden = true
    }
    
    @IBAction func addBeaconAction(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "AddBeaconViewController") as? AddBeaconViewController
        controller?.newCallback = { item in
            self.locationHandler.startScanning(item: item)
            self.monitoringLabel.isHidden = false
        }
        self.present(controller!, animated: true, completion: nil)
    }
}




