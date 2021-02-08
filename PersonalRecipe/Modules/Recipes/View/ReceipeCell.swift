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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = "recipeCell"
        translatesAutoresizingMaskIntoConstraints = false
        [recipeImageView, recipeTitleLabel].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
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
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView = imageView
        recipeImageView.accessibilityIdentifier = "recipeImageView"
        addSubview(recipeImageView)

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        recipeTitleLabel = label
        recipeTitleLabel.accessibilityIdentifier = "recipeTitleLabel"
        addSubview(recipeTitleLabel)
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
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: CGFloat(spacing))
        ])
        
    }
}
