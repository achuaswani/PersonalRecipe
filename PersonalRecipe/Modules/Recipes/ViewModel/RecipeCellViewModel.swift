//
//  RecipeCellViewModel.swift
//  PersonalRecipe
//
//  Created by Aswani G on 3/7/21.
//

import UIKit

class RecipeCellViewModel {
    var image: String?
    var title: String
    
    init(_ recipe: Recipe) {
        image = recipe.image
        title = recipe.title
    }
}
