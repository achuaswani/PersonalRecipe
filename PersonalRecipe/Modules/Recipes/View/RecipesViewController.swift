//
//  RecipesViewController.swift
//  Aswani
//
//  Copyright © 2016 Aswani. All rights reserved.
//

// MARK: - RecipesViewController Implementation

// RecipesViewController is the viewcontroller where all the UIactivities are done. Collectionview delegate and datasource implementation is also done in this class.
// ViewModel is calling here to get the Model data and the view model

import UIKit

class RecipesViewController: UIViewController {
    
    private lazy var recipesCollectionView = UICollectionView()
    private lazy var recipesActiviytIndicator = UIActivityIndicatorView()

    private var viewModel: RecipesViewModel = {
        return RecipesViewModel()
    }()
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        applyStyles()
        applyConstraints()
        configureViewModel()
        setUpViewDelegates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private methods
    
    private func createSubviews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        if DeviceType.iPhone5orless {
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        } else if DeviceType.iPad {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        } else {
            layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: CellType.recipeCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.preservesSuperviewLayoutMargins = true
        recipesCollectionView = collectionView
        view.addSubview(recipesCollectionView)
        
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = view.center
        recipesActiviytIndicator = activityIndicator
        view.addSubview(recipesActiviytIndicator)
        
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
    }
    
    private func applyStyles() {
        view.backgroundColor = .white
        view.accessibilityIdentifier = "recipe"
        recipesCollectionView.backgroundColor = .white
        recipesCollectionView.accessibilityIdentifier = "recipesCollectionView"
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

    }
    @objc private func addTapped() {
        let addNewRecipe = AddRecipeViewController()
        self.present(addNewRecipe, animated: true, completion: nil)
    }
    private func displayAlert(_ alertViewModel: AlertViewModel) {
        let alert = UIAlertController(alertViewModel: alertViewModel)
        alert.view.accessibilityIdentifier = "alertView"
        present(alert, animated: true, completion: nil)
    }
    
    private func displayEmptyMessageView(for errorViewModel: ErrorViewModel) {
        let emptyView = EmptyView(frame: .zero, viewModel: errorViewModel)
        recipesCollectionView.backgroundView = emptyView
    }
    
    private func displayActivityIndicator(for state: LoadingState) {
        switch state {
        case .loading:
            recipesActiviytIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations: {
                self.recipesCollectionView.alpha = 0.3
            })
        default:
            recipesActiviytIndicator.stopAnimating()
            UIView.animate(withDuration: 0.2, animations: {
                self.recipesCollectionView.alpha = 1.0
            })
        }
        
    }
    
    private func configureViewModel() {
        
        viewModel.recipesCollectionViewReloadClosure = { [weak self] () in
            self?.recipesCollectionView.reloadData()
        }
        
        viewModel.updateLoadingStateClosure = { [weak self] loadingState in
            self?.displayActivityIndicator(for: loadingState)
        }
        
        viewModel.displayAlertClosure = { [weak self] alertViewModel in
            self?.displayAlert(alertViewModel)
        }
        
        viewModel.updateErrorStateClosure = { [weak self] errorViewModel in
            self?.displayEmptyMessageView(for: errorViewModel)
        }
        
        viewModel.fetchRecipes()
    }
    
    private func setUpViewDelegates() {
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            recipesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipesCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            recipesCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            recipesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionView Implementation

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.getRecipeCell(collectionView, indexPath)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipesCollectionView.backgroundView = nil
        return viewModel.recipeListCount
    }
}

extension RecipesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.recipeSelected(at: indexPath)
    }
}

extension RecipesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation.isLandscape {
            return CGSize(width: collectionView.frame.size.width/3.2,
                          height: collectionView.frame.size.width/2.8)
        } else {
            return CGSize(width: collectionView.frame.size.width/2.2,
                          height: collectionView.frame.size.width/1.9)
        }
        
    }
}
