//
//  AddRecipeView.swift
//  PersonalRecipe
//
//  Created by Aswani G on 2/8/21.
//

import UIKit

class AddRecipeViewController: UIViewController {
    private var emptyViewHeaderLabel = UILabel()
    private var emptyViewMessageLabel = UILabel()
    private var emptyViewRefreshButton = UIButton()
    private var emptyStackView = UIStackView()
    private var viewModel: AddRecipeViewModel = {
        return AddRecipeViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        applyStyle()
        setUpLayout()
    }
    
    private func setUpView() {
        let headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center
        headerLabel.sizeToFit()
        headerLabel.textColor = .black
        //headerLabel.text = viewModel.title
        emptyViewHeaderLabel = headerLabel
        
        let messageLabel = UILabel()
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        //messageLabel.text = viewModel.subTitle
        emptyViewMessageLabel = messageLabel
        
        let refreshButton = UIButton()
        //refreshButton.setTitle(viewModel.buttonTitle, for: .normal)
        refreshButton.setTitleColor(.blue, for: .normal)
        refreshButton.contentMode = .scaleAspectFit
        refreshButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        emptyViewRefreshButton = refreshButton
    
        let stackView = UIStackView(arrangedSubviews: [emptyViewHeaderLabel, emptyViewMessageLabel, emptyViewRefreshButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emptyStackView = stackView
        view.addSubview(emptyStackView)
    }
    
    private func applyStyle() {
        [emptyViewHeaderLabel, emptyViewMessageLabel, emptyViewRefreshButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        emptyViewHeaderLabel.font = .boldSystemFont(ofSize: 24)
        emptyViewMessageLabel.font = .systemFont(ofSize: 18)
        emptyStackView.setCustomSpacing(20, after: emptyViewRefreshButton)
        view.backgroundColor = .white
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            emptyStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func refreshButtonTapped() {
        //viewModel.buttonAction()
    }
}
