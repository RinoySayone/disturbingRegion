//
//  Item.swift
//  disturbingRegion
//
//  Created by sayone73 on 02/11/2020.
//  Copyright © 2020 rinoy. All rights reserved.
//

import UIKit
import CoreLocation

class Item: NSObject {

    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
    let name: String
    let uuid: UUID

    init(name: String, uuid: UUID, majorValue: Int, minorValue: Int) {
      self.name = name
      self.uuid = uuid
      self.majorValue = CLBeaconMajorValue(majorValue)
      self.minorValue = CLBeaconMinorValue(minorValue)
    }
    
    func asBeaconRegion() -> CLBeaconRegion {
        return CLBeaconRegion(uuid: uuid, major: majorValue, minor: minorValue, identifier: name)
    }
    
}
