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

    @IBOutlet var addBeacon: UIButton!
    var locationHandler : LocationHandler = LocationHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addBeaconAction(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "AddBeaconViewController") as? AddBeaconViewController
        controller?.newCallback = { item in
            self.locationHandler.startScanning(item: item)
        }
        self.present(controller!, animated: true, completion: nil)
    }
}
extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("here notified VC")
        completionHandler([.alert])
    }
}




