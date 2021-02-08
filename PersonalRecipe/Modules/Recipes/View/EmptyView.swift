//
//  EmptyView.swift
//  Aswani
//
//  Created by Aswani on 11/27/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    private var emptyViewHeaderLabel = UILabel()
    private var emptyViewMessageLabel = UILabel()
    private var emptyViewRefreshButton = UIButton()
    private var viewModel: ErrorViewModel
    private var emptyStackView = UIStackView()
    
    init(frame: CGRect, viewModel: ErrorViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setUpView()
        applyStyle()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        let headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center
        headerLabel.sizeToFit()
        headerLabel.textColor = .black
        headerLabel.text = viewModel.title
        emptyViewHeaderLabel = headerLabel
        
        let messageLabel = UILabel()
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        messageLabel.text = viewModel.subTitle
        emptyViewMessageLabel = messageLabel
        
        let refreshButton = UIButton()
        refreshButton.setTitle(viewModel.buttonTitle, for: .normal)
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
        addSubview(emptyStackView)
    }
    
    private func applyStyle() {
        [emptyViewHeaderLabel, emptyViewMessageLabel, emptyViewRefreshButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        emptyViewHeaderLabel.font = .boldSystemFont(ofSize: 24)
        emptyViewMessageLabel.font = .systemFont(ofSize: 18)
        emptyStackView.setCustomSpacing(20, after: emptyViewRefreshButton)
        backgroundColor = .clear
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            emptyStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc private func refreshButtonTapped() {
        viewModel.buttonAction()
    }
}
