//
//  WaterFallLayout.h
//  WaterFallForOC
//
//  Created by admin on 16/9/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFallLayoutDelegate <NSObject>
@optional
-(CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface WaterFallLayout : UICollectionViewLayout{
    NSMutableArray* maxYOfColums;
    NSArray<__kindof UICollectionViewLayoutAttributes *>* layoutAttributes;
    CGFloat oldScreenWidth;
}

@property (nonatomic, assign) int numberOfColums;
@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, weak) id<WaterFallLayoutDelegate> delegate;


//- (id)initWithBoundView:(UIView *)boundView
//             dataSource:(id)datasource
//               delegate:(id)delegate
//              popupType:(XDPopupListViewType)popupType;


@end
