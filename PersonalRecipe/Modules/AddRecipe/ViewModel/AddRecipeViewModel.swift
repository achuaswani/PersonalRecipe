//
//  AddRecipeViewModel.swift
//  PersonalRecipe
//
//  Created by Aswani G on 2/8/21.
//

import Foundation
import Combine

protocol AddRecipeModelType {
    var title: String? { get set }
    var description: String? { get set }
    var tips: String? { get set }
    var ingredients: String? { get set }
    var steps: String? { get set }

    func buttonAction()
}

class AddRecipeViewModel: AddRecipeModelType {
    let serviceManager: ServiceManagerType
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
    }
    @Published var title: String?
    @Published var description: String?
    @Published var tips: String?
    @Published var ingredients: String?
    @Published var steps: String?
    let navigationBarTitle: String = "add.recipe.header.title".localized()
    let recipeTitlePlaceholder: String =  "add.recipe.title.placeholder".localized()
    let descriptionPlaceholder: String =  "add.recipe.description.placeholder".localized()
    let tipsPlaceholder: String =  "add.recipe.tips.placeholder".localized()
    let ingredientsPlaceholder: String =  "add.recipe.ingredients.placeholder".localized()
    let stepsPlaceholder: String =  "add.recipe.steps.placeholder".localized()
    let recipeButtonTitle: String =  "add.recipe.button.title".localized()
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
    
    func getRecipe() -> Recipe? {
//        guard let recipeTitle = title,
//              let recipeIngredients = ingredients else {
//            self.errorViewModel = ErrorViewModel(
//                title: "add.recipe.enter.all".localized(),
//                buttonTitle: "general.button.ok.title".localized(),
//                buttonAction: {
//                }
//            )
//            
//            return nil
//        }
        
        
        let recipe = Recipe(
            title: "test",//recipeTitle,
            category: "test",
            description: description ?? "",
            image: "",
            ingredients: "tes",//recipeIngredients,
            steps: steps ?? "",
            tips: tips ?? "",
            author: "Test"
        )
        
        return recipe
        
    }
    
    func buttonAction() {
        guard let recipe  = getRecipe() else {
            return
        }
        let recipeResponseHandler = { (result: Result<[Recipe], APIError>) in
            switch result {
            case .success(_): break
                
            case .failure(let error):
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
