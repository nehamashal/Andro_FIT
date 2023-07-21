//
//  DynamicHeightCollectionView.swift
//  Andro Fit App
//
//  Created by Neha on 18/07/23.
//

import Foundation
import UIKit


class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
