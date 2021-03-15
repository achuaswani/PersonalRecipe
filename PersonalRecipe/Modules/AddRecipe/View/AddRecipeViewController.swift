//
//  AddRecipeView.swift
//  PersonalRecipe
//
//  Created by Aswani G on 2/8/21.
//

import UIKit

class AddRecipeViewController: UIViewController, UITextFieldDelegate {
    private var recipeTitle = UITextField()
    private var recipeDescription = UITextField()
    private var recipeImageView = UIImageView()
    private var recipeIngredients = UITextField()
    private var recipeSteps = UITextField()
    private var recipeTips = UITextField()
    private var addRecipeButton = UIButton()
    private var addRecipeStackView = UIStackView()
    private var viewModel: AddRecipeViewModel = {
        return AddRecipeViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        applyStyle()
        setUpLayout()
        registerClosure()
    }
    
    private func registerClosure() {
        viewModel.updateErrorStateClosure = { [weak self] errorViewModel in
            self?.displayEmptyMessageView(for: errorViewModel)
        }
    }
    
    private func setUpView() {
        navigationItem.title = viewModel.navigationBarTitle
        
        recipeTitle.textColor = .black
        recipeTitle.placeholder = viewModel.addRecipeTitlePlaceholder
        recipeTitle.isSecureTextEntry = false
        recipeTitle.delegate = self
        recipeTitle.accessibilityIdentifier = "recipeTitle"
        
        recipeDescription.textColor = .black
        recipeDescription.placeholder = viewModel.addDescriptionPlaceholder
        recipeDescription.isSecureTextEntry = false
        recipeDescription.delegate = self
        recipeDescription.accessibilityIdentifier = "recipeDescription"
        
        //recipeImageView.image =  UIImage(named: "login")!
        recipeImageView.accessibilityIdentifier = "recipeImageView"
        
        recipeIngredients.textColor = .black
        recipeIngredients.placeholder = viewModel.addIngredientsPlaceholder
        recipeIngredients.isSecureTextEntry = false
        recipeIngredients.delegate = self
        recipeIngredients.accessibilityIdentifier = "recipeIngredients"
        
        recipeSteps.textColor = .black
        recipeSteps.placeholder = viewModel.addStepsPlaceholder
        recipeSteps.isSecureTextEntry = false
        recipeSteps.delegate = self
        recipeSteps.accessibilityIdentifier = "recipeSteps"
        
        recipeTips.textColor = .black
        recipeTips.placeholder = viewModel.addTipsPlaceholder
        recipeTips.isSecureTextEntry = false
        recipeTips.delegate = self
        recipeTips.accessibilityIdentifier = "recipeTips"

        addRecipeButton.setTitle(viewModel.addRecipeButtonTitle, for: .normal)
        addRecipeButton.setTitleColor(.blue, for: .normal)
        addRecipeButton.contentMode = .scaleAspectFit
        addRecipeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addRecipeButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    
        addRecipeStackView = UIStackView(arrangedSubviews: [recipeImageView, recipeTitle, recipeDescription, recipeIngredients, recipeSteps, recipeTips, addRecipeButton])
        addRecipeStackView.axis = .vertical
        addRecipeStackView.spacing = 15
        addRecipeStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addRecipeStackView)
    }
    
    private func applyStyle() {
        [recipeImageView, recipeTitle, recipeDescription, recipeIngredients, recipeSteps, recipeTips, addRecipeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        addRecipeStackView.setCustomSpacing(20, after: addRecipeButton)
        view.backgroundColor = .white
        let navBarBackgroundColor = UIColor(red: 0.0, green:0.036, blue: 0.72, alpha: 1.0)
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = navBarBackgroundColor
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.isTranslucent = false
        } else {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.barTintColor = navBarBackgroundColor
        }
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            addRecipeStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            addRecipeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addRecipeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10)
        ])
    }
    
    @objc private func refreshButtonTapped() {
        let recipe = Recipe(
            title: "test",
            category: "test",
            description: "test",
            image: "test",
            ingredients: "test",
            steps: recipeSteps.text,
            tips: recipeTips.text,
            author: "Test",
            dateTime: "Test"
        )
        viewModel.buttonAction(recipe)
    }
    
    private func displayEmptyMessageView(for: ErrorViewModel) {
        print("Error")
    }
}
