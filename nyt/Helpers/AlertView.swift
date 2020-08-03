//
//  AlertView.swift
//  nyt
//
//  Created by Umer Saleem on 31/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation
import UIKit

/// Generic AlertController protocol can be used to show alerts through out the application
protocol AlertPresentable {
    func presentAlert(title: String, message: String, completion: (() -> ())?)
}

extension AlertPresentable where Self: UIViewController {
    func presentAlert(title: String, message: String, completion: (() -> ())?) {
        
        if self.presentedViewController == nil {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: { _ in
                guard let completion = completion else { return }
                completion()
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}
