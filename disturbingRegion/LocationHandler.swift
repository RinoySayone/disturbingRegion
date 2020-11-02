//
//  LocationManage.swift
//  disturbingApp
//
//  Created by sayone73 on 28/10/2020.
//  Copyright © 2020 rinoy. All rights reserved.
//
import CoreLocation
import Foundation
import UserNotifications

class LocationHandler : NSObject{
    private let locationManager = CLLocationManager()
    private let notificationLocal  = LocalNotificationManager()
    override init() {
        super.init()
        self.initLocationManager()
    }
    private func initLocationManager() {
        self.requestLocationPermission()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func requestLocationPermission() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted, .authorizedWhenInUse:
            break
        default:
            break
        }
    }
    
    func startScanning(item: Item) {
        let beaconRegion = item.asBeaconRegion()
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
    }
}

extension LocationHandler : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.allowsBackgroundLocationUpdates = true
        } else if status == .denied || status == .restricted {
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exited from region \(region.identifier)")
//        should stop the timer
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered in region \(region.identifier)")
        //here we need to implement timer here
        notificationLocal.didinitiateNotification()
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
//        notificationLocal.didinitiateNotification()
        //this only works in only app is in foreground not background
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
      print("Failed monitoring region: \(error.localizedDescription)")
    }
      
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("Location manager failed: \(error.localizedDescription)")
    }
}

