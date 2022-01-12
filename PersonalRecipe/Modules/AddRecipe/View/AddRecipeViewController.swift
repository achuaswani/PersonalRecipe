//
//  AddRecipeView.swift
//  PersonalRecipe
//
//  Created by Aswani G on 2/8/21.
//

import UIKit
import Combine

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
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        applyStyle()
        setUpLayout()
        registerClosure()
        setupBindings()
    }
    
    private func setupBindings() {
        subscriptions = [
            viewModel.$title
                .receive(on: DispatchQueue.main)
                .assign(to: \.text, on: recipeTitle),
            viewModel.$description
                .receive(on: DispatchQueue.main)
                .assign(to: \.text, on: recipeDescription)
        ]
    }
    
    private func registerClosure() {
        viewModel.updateErrorStateClosure = { [weak self] errorViewModel in
            self?.displayEmptyMessageView(for: errorViewModel)
        }
    }
    
    private func setUpView() {
        navigationItem.title = viewModel.navigationBarTitle
        
        recipeTitle.textColor = .black
        recipeTitle.placeholder = viewModel.recipeTitlePlaceholder
        recipeTitle.isSecureTextEntry = false
        recipeTitle.delegate = self
        recipeTitle.accessibilityIdentifier = "recipeTitle"
        recipeTitle.text = viewModel.title
        
        recipeDescription.textColor = .black
        recipeDescription.placeholder = viewModel.descriptionPlaceholder
        recipeDescription.isSecureTextEntry = false
        recipeDescription.delegate = self
        recipeDescription.accessibilityIdentifier = "recipeDescription"
        recipeDescription.text = viewModel.description
        
        //recipeImageView.image =  UIImage(named: "login")!
        recipeImageView.accessibilityIdentifier = "recipeImageView"
        
        recipeIngredients.textColor = .black
        recipeIngredients.placeholder = viewModel.ingredientsPlaceholder
        recipeIngredients.isSecureTextEntry = false
        recipeIngredients.delegate = self
        recipeIngredients.accessibilityIdentifier = "recipeIngredients"
        recipeIngredients.text = viewModel.ingredients
        
        recipeSteps.textColor = .black
        recipeSteps.placeholder = viewModel.stepsPlaceholder
        recipeSteps.isSecureTextEntry = false
        recipeSteps.delegate = self
        recipeSteps.accessibilityIdentifier = "recipeSteps"
        recipeSteps.text = viewModel.steps
        
        recipeTips.textColor = .black
        recipeTips.placeholder = viewModel.tipsPlaceholder
        recipeTips.isSecureTextEntry = false
        recipeTips.delegate = self
        recipeTips.accessibilityIdentifier = "recipeTips"
        recipeTips.text = viewModel.tips

        addRecipeButton.setTitle(viewModel.recipeButtonTitle, for: .normal)
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
        viewModel.buttonAction()
    }
    
    private func displayEmptyMessageView(for: ErrorViewModel) {
        print("Error")
    }
}
