//
//  HeroCell.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 15/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation
import UIKit
class HeroCell: CollectionViewBaseCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none, isFavorite: false)
    }
    
//    let cellBackgroundView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 15
//        view.backgroundColor = Colors.heroCellBackgroundColor
//        return view
//    }()
    
    let thumbnailImageView: UIImageView = {
        let thumbnailImageView = UIImageView()
        
        var width = UIScreen.main.bounds.width / 2.5
        var height = width
        
        thumbnailImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        thumbnailImageView.layer.cornerRadius = 10
        
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill
        return thumbnailImageView
    }()
    
    let thumbnailLoadingIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        indicatorView.color = Colors.marvelRed
        return indicatorView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 22)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        indicatorView.color = Colors.marvelRed
        return indicatorView
    }()
    
    let favoriteIndicatorImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setupViews(){
//        addConstraint(NSLayoutConstraint(item: self, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: self, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 0))
        
        //addSubview(cellBackgroundView)
        //addSubview(indicatorView)
        
//        addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        //addSubview(thumbnailLoadingIndicatorView)
        addSubview(thumbnailImageView)
        //addSubview(favoriteIndicatorImageView)
        addSubview(titleLabel)
        
//        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .bottomMargin, relatedBy: .equal, toItem: titleLabel, attribute: .topMargin, multiplier: 1, constant: -30))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -10))
        
//        addConstraint(NSLayoutConstraint(item: thumbnailLoadingIndicatorView, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 10))
//        addConstraint(NSLayoutConstraint(item: thumbnailLoadingIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: thumbnailLoadingIndicatorView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.85, constant: 0))
//        addConstraint(NSLayoutConstraint(item: thumbnailLoadingIndicatorView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.85, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .topMargin, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottomMargin, multiplier: 1, constant: 30))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: -10))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -10))
        
//        addConstraint(NSLayoutConstraint(item: favoriteIndicatorImageView, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -12))
//        addConstraint(NSLayoutConstraint(item: favoriteIndicatorImageView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 12))
//        addConstraint(NSLayoutConstraint(item: favoriteIndicatorImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.15, constant: 1))
//        addConstraint(NSLayoutConstraint(item: favoriteIndicatorImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.15, constant: 1))
        
//        addConstraint(NSLayoutConstraint(item: self, attribute: .bottomMargin, relatedBy: .equal, toItem: titleLabel, attribute: .bottomMargin, multiplier: 1, constant: 1))
    }
    
    func configure(with hero: Hero?, isFavorite: Bool) {
        layer.cornerRadius = 15
        backgroundColor = Colors.heroCellBackgroundColor
        
        if let hero = hero {
            thumbnailLoadingIndicatorView.startAnimating()
            indicatorView.stopAnimating()
            titleLabel.isHidden = false
            thumbnailImageView.isHidden = false
            titleLabel.text = hero.name
            if isFavorite {
                favoriteIndicatorImageView.isHidden = false
                favoriteIndicatorImageView.image = UIImage(systemName: "star.fill")
                favoriteIndicatorImageView.tintColor = UIColor.red
            } else {
                favoriteIndicatorImageView.isHidden = true
            }
            //            if let thumbnail = hero.heroThumbnail {
            //                thumbnailImageView.image = UIImage(data: thumbnail as Data)
            //            }
            
            //            if let image = hero.heroThumbnail {
            //                thumbnailImageView.image = UIImage(data: image as Data)
            //            } else {
            //                let urlAsString = "\(hero.thumbnail.path).\(hero.thumbnail.extension)"
            //                //print(urlAsString)
            //                let url = URL(string: urlAsString)! as URL
            //
            //                DispatchQueue.global().async { [weak self] in
            //                    if let imageData = try? Data(contentsOf: url){
            //                        DispatchQueue.main.async {
            //                            self?.thumbnailImageView.image = UIImage(data: imageData as Data)
            //                            //                        self?.titleLabel.alpha = 1
            //                            //                        self?.indicatorView.alpha = 0
            //                            //                        self?.titleLabel.text = hero.name
            //                        }
            //                    }
            //                }
            //            }
        } else {
            titleLabel.isHidden = true
            thumbnailImageView.image = nil
            thumbnailImageView.isHidden = true
            indicatorView.startAnimating()
        }
    }
    
    func addThumbnail(thumbnailData: Data) {
        thumbnailLoadingIndicatorView.stopAnimating()
        thumbnailImageView.image = UIImage(data: thumbnailData as Data)
    }
    
//    lazy var width: NSLayoutConstraint = {
//        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
//        width.isActive = true
//        return width
//    }()
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        width.constant = bounds.size.width
//        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
//
//    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//        layoutIfNeeded()
//        layoutAttributes.frame.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize,
//                                                              withHorizontalFittingPriority: .required,
//                                                              verticalFittingPriority: .fittingSizeLevel)
//        return layoutAttributes
//    }
}
