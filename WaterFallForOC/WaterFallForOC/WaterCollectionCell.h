//
//  WaterCollectionCell.h
//  WaterFallForOC
//
//  Created by admin on 16/9/6.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface WaterCollectionCell : UICollectionViewCell{
//    BOOL isLoading;
    BOOL isImageChange;
}

@property (nonatomic,retain) ImageVo* imageVo;
@property (nonatomic,retain) UICollectionView* collectionView;
@property (nonatomic,retain) NSIndexPath* indexPath;

@property (nonatomic,retain) ASImageNode* imageView;
@property (nonatomic,retain) ASTextNode* titleView;
@property (nonatomic,retain) ASDisplayNode* titleBack;

@end
