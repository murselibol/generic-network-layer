//
//  UIViewController+Ext.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 4.12.2023.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
