//
//  WaterCollectionCell.h
//  WaterFallForOC
//
//  Created by admin on 16/9/6.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardInfoManager.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>


@interface GradientNode:ASDisplayNode

@end

@interface WaterCollectionCell : UICollectionViewCell{
//    BOOL isLoading;
    BOOL isImageChange;
}

@property (nonatomic,retain) ImageVo* imageVo;
@property (nonatomic,retain) UICollectionView* collectionView;
@property (nonatomic,retain) NSIndexPath* indexPath;

@property (nonatomic,retain) ASImageNode* imageView;
@property (nonatomic,retain) ASImageNode* backImageView;
@property (nonatomic,retain) ASTextNode* titleView;
@property (nonatomic,retain) ASTextNode* descriptionView;
@property (nonatomic,retain) ASDisplayNode* titleBack;

@end
