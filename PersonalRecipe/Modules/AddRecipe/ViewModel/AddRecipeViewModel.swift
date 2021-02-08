//
//  AddRecipeViewModel.swift
//  PersonalRecipe
//
//  Created by Aswani G on 2/8/21.
//

import Foundation

class AddRecipeViewModel {
    let serviceManager: ServiceManagerType
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
    }
}
