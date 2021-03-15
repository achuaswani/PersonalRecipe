//
//  ReceipeCategoryCell.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    var recipeImageView = UIImageView()
    var recipeTitleLabel = UILabel()
    var authorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = "recipeCell"
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 6.0
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = true
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.3
    }
    
    // MARK: - Private Methods
    
    private func setUpViews() {
        [recipeImageView, recipeTitleLabel, authorLabel].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
        recipeImageView.image = UIImage(named: "placeholder")
        recipeImageView.contentMode = .scaleAspectFit
        recipeImageView.accessibilityIdentifier = "recipeImageView"
        addSubview(recipeImageView)

        [recipeTitleLabel, authorLabel].forEach {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 18)
        }
        recipeTitleLabel.accessibilityIdentifier = "recipeTitleLabel"
        addSubview(recipeTitleLabel)
        
        authorLabel.accessibilityIdentifier = "authorLabel"
        addSubview(authorLabel)
    }
        
    private func setUpLayout() {
        var spacing = 5
        if DeviceType.iPhone5orless {
            spacing = 2
        } else if DeviceType.iPad {
            spacing = 20
        }
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor),
            recipeImageView.rightAnchor.constraint(equalTo: rightAnchor),
            recipeImageView.leftAnchor.constraint(equalTo: leftAnchor),
            recipeImageView.widthAnchor.constraint(equalTo: widthAnchor),
            recipeImageView.heightAnchor.constraint(equalTo: widthAnchor),
            recipeTitleLabel.leftAnchor.constraint(equalTo: recipeImageView.leftAnchor),
            recipeTitleLabel.rightAnchor.constraint(equalTo: recipeImageView.rightAnchor),
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: CGFloat(spacing)),
            authorLabel.leftAnchor.constraint(equalTo: recipeTitleLabel.leftAnchor),
            authorLabel.rightAnchor.constraint(equalTo: recipeTitleLabel.rightAnchor),
            authorLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: CGFloat(spacing))
        ])
    }
}
