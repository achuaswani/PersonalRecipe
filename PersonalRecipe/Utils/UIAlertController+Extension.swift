//
//  UIAlertController+Extension.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

import UIKit

extension UIAlertController {
    convenience init(alertViewModel viewModel: AlertViewModel) {
        self.init(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        viewModel.actions.forEach { action in
            addAlertAction(action)
        }
    }
    
    private func addAlertAction(_ alertAction: AlertAction) {
        addAction(UIAlertAction(
                    title: alertAction.title,
                    style: alertAction.style,
                    handler: alertAction.action))
    }
}
