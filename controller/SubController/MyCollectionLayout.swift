//
//  MyCollectionLayout.swift
//  MySwiftPro
//
//  Created by  Tmac on 2018/7/16.
//  Copyright © 2018年 Tmac. All rights reserved.
//

import UIKit

class MyCollectionLayout: UICollectionViewFlowLayout {

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }

    override func prepare() {
        super.prepare();
        
        self.scrollDirection = UICollectionViewScrollDirection.horizontal;
        self.minimumLineSpacing = 12;
        self.itemSize = CGSize(width: 160, height: 180);
//        let collView:UICollectionView = self.collectionView!;
//        let inset:CGFloat = (collView.frame.size.width - self.itemSize.width) * 0.5;
//        let yinset:CGFloat = (collView.frame.size.height - self.itemSize.height) * 0.5;
//        self.sectionInset = UIEdgeInsetsMake(yinset, inset, yinset, inset);
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        let array:[UICollectionViewLayoutAttributes]! = super.layoutAttributesForElements(in: rect);
        let collView:UICollectionView = self.collectionView!;
        let centerX:CGFloat = collView.contentOffset.x + collView.bounds.size.width*0.5;

        for attrs in array
        {
            let delta:CGFloat = fabcC(num: attrs.center.x - centerX);
            let apartScale:CGFloat = delta/collView.bounds.size.width;
//            let mp:CGFloat = CGFloat(.pi);
            let scale:CGFloat = fabcC(num: cos(apartScale * CGFloat.pi/2));
            attrs.transform = CGAffineTransform.init(scaleX: 1.0, y: scale);
        }

        return array;
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let collView:UICollectionView = self.collectionView!;
        
        var rect:CGRect = collView.frame;
        rect.origin.x = proposedContentOffset.x;
        rect.origin.y = 0;
        
        let array:[UICollectionViewLayoutAttributes]! = super.layoutAttributesForElements(in: rect);
        
        let centerX:CGFloat = proposedContentOffset.x + collView.bounds.size.width*0.5;
        
        var minDelta:CGFloat = 1000;
        for attrs in array
        {
            if(fabcC(num: minDelta) > fabcC(num: attrs.center.x-centerX))
            {
                minDelta = attrs.center.x - centerX;
            }
        }
        var offset:CGPoint = proposedContentOffset;
        offset.x = offset.x + minDelta;
        
        return offset;
    }

}
