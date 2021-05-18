//
//  HeroCollectionViewFlowLayout.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 19/09/2020.
//  Copyright © 2020 Pedro Eusébio. All rights reserved.
//

import UIKit

protocol HeroCollectionViewFlowLayoutDelegate: AnyObject {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForHeroCellAtIndexPath indexPath: IndexPath) -> CGFloat
    
    func reload()
}

class HeroCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate: HeroCollectionViewFlowLayoutDelegate?
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        //1
        guard
            cache.isEmpty,
            let collectionView = collectionView
        else {
            return
        }
        
        self.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        //2
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []

        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)

        //3
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            //4
            let heroCellHeight = delegate!.collectionView(collectionView, heightForHeroCellAtIndexPath: indexPath)
            let height = cellPadding * 2 + heroCellHeight
            let frame = CGRect(x: xOffset[column], y:yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            //5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            //6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height

            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }

        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    //CHAVETO STUFF
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map { $0.copy() } as? [UICollectionViewLayoutAttributes]
//        layoutAttributesObjects?.forEach({ layoutAttributes in
//            if layoutAttributes.representedElementCategory == .cell {
//                if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
//                    layoutAttributes.frame = newFrame
//                }
//            }
//        })
//        return layoutAttributesObjects
//    }
//
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        guard let collectionView = collectionView else {
//            fatalError()
//        }
//        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
//            return nil
//        }
//
//        layoutAttributes.frame.origin.x = sectionInset.left
//        layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
//        return layoutAttributes
//    }
}
