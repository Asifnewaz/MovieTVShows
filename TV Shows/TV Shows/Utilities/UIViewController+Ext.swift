//
//  UIViewController+Ext.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit

extension UIViewController: StoryboardInitializable {
    
}

extension UIViewController {
    func presentAlert(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true)
        }
        
    }
}

