//
//  RecipesViewModel.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

import UIKit

class RecipesViewModel {
    let serviceManager: ServiceManagerType
    
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
    }
    
    var recipesCollectionViewReloadClosure:(() -> Void)?
    var displayAlertClosure: ((AlertViewModel) -> Void)?
    var updateLoadingStateClosure: ((LoadingState) -> Void)?
    var updateErrorStateClosure:((ErrorViewModel) -> Void)?
    
    let navigationBarTitle: String = "recipes.header.title".localized()
    var emptyMessage: String = ""
    var itemsPerBatch = 10
    var start: Int = 0
    var currentRow : Int = 9
    var url: String {
        "\(AppConstants.RECIPES)/start/\(start)/end/\(currentRow)"
    }

    // update the collectionview whenever the value changes
    private(set) var recipeList: [Recipe] = [Recipe]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.recipesCollectionViewReloadClosure?()
            }
        }
    }
    
    var recipeListCount: Int {
        return recipeList.count
    }
    var numberOfSections: Int {
        return 1
    }
    
    private let alertAction = AlertAction(title: "general.button.ok.title".localized(), style: .cancel, action: nil)
    
    private var alertViewModel: AlertViewModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self, let alertViewModel = self.alertViewModel else {
                    return
                }
                self.displayAlertClosure?(alertViewModel)
            }
        }
    }
    
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
    
    private var loadingState: LoadingState? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self,
                      let loadingState = self.loadingState,
                      oldValue != loadingState else {
                    return
                }
                self.updateLoadingStateClosure?(loadingState)
            }
        }
    }
    
    func fetchRecipes() {
        guard loadingState != .loading else {
            return
        }
        
        loadingState = .loading
        let recipeResponseHandler = { [weak self] (result: Result<[Recipe], APIError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let recipes):
                self.recipeList += recipes
            case .failure(let error):
                self.errorViewModel = ErrorViewModel(
                    title: "service.request.try.again".localized(),
                    subTitle: error.debugDescription,
                    buttonTitle: "general.button.refresh.title".localized(),
                    buttonAction: {
                        self.fetchRecipes()
                    }
                )
            }
            self.loadingState = .completed
        }
        serviceManager.getRequest(path: url, completionHandler: recipeResponseHandler)
    }
    
    func updateNextSet() {
        start += itemsPerBatch
        currentRow += start
        fetchRecipes()
    }
    
    func addNewRecipe() {
        
    }
    
    func getRecipeCell(_ collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.recipeCell, for: indexPath) as? RecipeCell else {
            fatalError("Expected cell type recipeCell")
        }
        let recipeItem = recipeList[indexPath.row]
        if let image = recipeItem.image { 
            cell.recipeImageView.setImage(urlstring: image, placeholder: UIImage(named: "placeholder"))
        }
        cell.recipeTitleLabel.text = recipeItem.title
        cell.authorLabel.text = recipeItem.author
       
        return cell
    }
    
    func recipeSelected(at indexPath: IndexPath) {
        self.alertViewModel = AlertViewModel(
            title: "\(recipeList[indexPath.row].title)",
            message: "alert.category.selected.message".localized(withValue: "\(recipeList[indexPath.row].title)"),
            actions: [alertAction]
        )
    }
}
