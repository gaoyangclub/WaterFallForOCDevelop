


//
//  WaterFallLayout.m
//  WaterFallForOC
//
//  Created by admin on 16/9/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WaterFallLayout.h"

@implementation WaterFallLayout

-(void)setNumberOfColums:(int)numberOfColums
{
    for (int i = 0; i < numberOfColums; i++) {
        [self->maxYOfColums addObject:@0];
    }
    _numberOfColums = numberOfColums;
}

- (instancetype)init
{
    
    self = [super init];
    if (self) {
        self.itemSpace = 5;
        self.numberOfColums = 1;//最少1列
        maxYOfColums = [NSMutableArray new];
        layoutAttributes = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    layoutAttributes = [self computeLayoutAttributes];
    
    oldScreenWidth = [UIScreen mainScreen].bounds.size.width;// 设置为当前屏幕的宽度
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return layoutAttributes[indexPath.row];
}


- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return layoutAttributes;
}

// 返回collectionView的ContentSize -> 滚动范围
-(CGSize)collectionViewContentSize{
    CGFloat maxY = [self getMaxYByColums:maxYOfColums];
    return CGSizeMake(0,maxY);
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return newBounds.size.width != oldScreenWidth;
}

-(CGFloat)getMaxYByColums:(NSMutableArray *) colums{
    CGFloat maxValue = [[colums valueForKeyPath:@"@max.floatValue"] floatValue];
    return maxValue;
}

-(CGFloat)getMinYByColums:(NSMutableArray *) colums{
    CGFloat minValue = [[colums valueForKeyPath:@"@min.floatValue"] floatValue];
    return minValue;
}

-(nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)computeLayoutAttributes{
    NSInteger totalNums = [self.collectionView numberOfItemsInSection:0];
    CGFloat width = (self.collectionView.bounds.size.width - self.itemSpace * (self.numberOfColums + 1)) /self.numberOfColums;
    
    NSMutableArray* attributesArr = [NSMutableArray new];
    
    if(self.delegate == nil){
        NSAssert(false, @"WaterFallLayout需要设置代理");
        return attributesArr;
    }
    
    for (int i = 0; i < self.numberOfColums; i++) {
        maxYOfColums[i] = @0;
    }
    for (NSInteger currentIndex = 0; currentIndex < totalNums; currentIndex++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        CGFloat height = [self.delegate heightForItemAtIndexPath:indexPath];
        
        NSInteger currentColum;
        
        if(currentIndex < self.numberOfColums){// 第一行直接添加到当前的列
            currentColum = currentIndex;
        } else {// 其他行添加到最短的那一列
            // 这里使用!会得到期望的值
            CGFloat minMaxY = [self getMinYByColums:maxYOfColums];
            currentColum = [maxYOfColums indexOfObject:[NSNumber numberWithFloat:(float)minMaxY]];
        }
        //            currentColum = currentIndex % numberOfColums
        CGFloat x = self.itemSpace + currentColum * (width + self.itemSpace);
        // 每个cell的y
        NSNumber *a = maxYOfColums[currentColum];
        CGFloat y = self.itemSpace + a.floatValue;
        // 记录每一列的最后一个cell的最大Y
        maxYOfColums[currentColum] = [NSNumber numberWithFloat:(y + height)];
        
        UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(x, y, width, height);
        
        [attributesArr addObject:attributes];
    }
    
    return attributesArr;
}


@end
