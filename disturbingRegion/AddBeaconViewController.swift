//
//  AddBeaconViewController.swift
//  disturbingRegion
//
//  Created by sayone73 on 28/10/2020.
//  Copyright © 2020 rinoy. All rights reserved.
//

import UIKit
import CoreLocation

class AddBeaconViewController: UIViewController {

    var newCallback : ((Item) -> Void)?
    @IBOutlet var minorTextfield: UITextField!
    @IBOutlet var majorTextField: UITextField!
    @IBOutlet var uuidTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        minorTextfield.delegate = self
        majorTextField.delegate = self
        uuidTextfield.delegate = self
        uuidTextfield.text = "e8491414-6eda-4e72-a03d-d5455f6f69d2"
        majorTextField.text = "12"
        minorTextfield.text = "13"
    }
    
    @IBAction func addAction(_ sender: Any) {
        let uuid = UUID(uuidString: (uuidTextfield?.text)!)
        let major = Int((majorTextField?.text)!)!
        let minor = Int((minorTextfield?.text)!)!
        let item = Item(name: "beaconRegion", uuid: uuid!, majorValue: major, minorValue: minor)
        newCallback!(item)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddBeaconViewController : UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

