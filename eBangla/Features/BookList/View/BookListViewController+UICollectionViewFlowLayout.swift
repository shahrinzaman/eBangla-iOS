//
//  BookListViewController+UICollectionViewFlowLayout.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import UIKit

extension BookListViewController : UICollectionViewDelegateFlowLayout{
    
    var inset : CGFloat { return 10 }
    var minimumInterItemSpacing : CGFloat { return 10 }
    var numberOfColumns : Int { return 2 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return edgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = (collectionViewWidth - (inset + inset + CGFloat(numberOfColumns - 1) * minimumInterItemSpacing )) / CGFloat(numberOfColumns)
        let cellSize = CGSize(width: cellWidth, height: (cellWidth * 11) / 9)
        return cellSize
    }
    
}
