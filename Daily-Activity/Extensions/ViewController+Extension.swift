//
//  ViewController+Extension.swift
//  Daily-Activity
//
//  Created by chander bhushan on 16/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    // Alert to show Error
    func showAlert(_ title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: false, completion: nil)
    }
}
