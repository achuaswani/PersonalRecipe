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
    let navigationBarTitle: String = "add.recipe.header.title".localized()
    let addRecipeTitlePlaceholder: String =  "add.recipe.title.placeholder".localized()
    let addDescriptionPlaceholder: String =  "add.recipe.description.placeholder".localized()
    let addTipsPlaceholder: String =  "add.recipe.tips.placeholder".localized()
    let addIngredientsPlaceholder: String =  "add.recipe.ingredients.placeholder".localized()
    let addStepsPlaceholder: String =  "add.recipe.steps.placeholder".localized()
    let addRecipeButtonTitle: String =  "add.recipe.button.title".localized()
    var updateErrorStateClosure:((ErrorViewModel) -> Void)?
    private var errorViewModel: ErrorViewModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self, let errorViewModel = self.errorViewModel else {
                    return
                }
                self.updateErrorStateClosure?(errorViewModel)
            }
        }
    }
    
    func buttonAction(_ recipe: Recipe) {
        let recipeResponseHandler = { (result: Result<[Recipe], APIError>) in
            switch result {
            case .success(let _): break
                
            case .failure(let error): break
                self.errorViewModel = ErrorViewModel(
                    title: "service.request.try.again".localized(),
                    subTitle: error.debugDescription,
                    buttonTitle: "general.button.refresh.title".localized(),
                    buttonAction: {
                    }
                )
            }
        }
        serviceManager.postRequest(path: AppConstants.ADDRECIPE, body: recipe, completionHandler: recipeResponseHandler)
    }
}
