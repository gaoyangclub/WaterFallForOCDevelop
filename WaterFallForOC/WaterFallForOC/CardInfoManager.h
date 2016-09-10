//
//  CardInfoManager.h
//  WaterFallForOC
//
//  Created by 高扬 on 16/9/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageVo:NSObject

@property (nonatomic, assign) NSString* imageUrl;
@property (nonatomic, assign) NSString* name;
@property (nonatomic, assign) NSString* describe;
@property (nonatomic, assign) CGFloat cellHeight;

@end

@interface CardInfoManager : NSObject

+(NSMutableArray *)getAllCardInfo;

@end
