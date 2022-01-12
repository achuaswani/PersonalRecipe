//
//  AlertViewModel.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

import UIKit

struct AlertViewModel {
    let title: String?
    let message: String?
    let actions: [AlertAction]
}

struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let action: ((UIAlertAction) -> Void)?
}
