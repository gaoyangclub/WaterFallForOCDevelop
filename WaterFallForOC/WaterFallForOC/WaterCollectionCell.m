
//
//  WaterCollectionCell.m
//  WaterFallForOC
//
//  Created by admin on 16/9/6.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WaterCollectionCell.h"
#import "BatchLoaderForOC.h"

@implementation WaterCollectionCell


//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

-(ASImageNode *)imageView{
    if (!_imageView) {
        _imageView = [[ASImageNode alloc]init];
        _imageView.layerBacked = true;
        _imageView.backgroundColor = [UIColor whiteColor];
//        _imageView.layer.cornerRadius = 30;
//        _imageView.cornerRadius = 30;
//        _imageView.layer.masksToBounds = YES;
        [self.contentView.layer addSublayer:_imageView.layer];
    }
    return _imageView;
}

-(ASTextNode *)titleView{
    if (!_titleView) {
        _titleView = [[ASTextNode alloc]init];
        _titleView.layerBacked = true;
//        _titleView.textColor = [UIColor whiteColor];
//        _titleView.backgroundColor = [[UIColor alloc]initWithCGColor:CGColorCreateCopyWithAlpha([UIColor blackColor].CGColor, 0.6)];
//        _titleView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
//        _titleView.textAlignment = NSTextAlignmentCenter;
        [self.titleBack addSubnode:_titleView];
    }
    return _titleView;
}

- (ASDisplayNode *)titleBack{
    if (!_titleBack) {
        _titleBack = [[ASDisplayNode alloc]init];
        _titleBack.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
//        _titleBack.layerBacked = true;
        [self.contentView.layer addSublayer:_titleBack.layer];
    }
    return _titleBack;
}

-(void)setImageVo:(ImageVo *)imageVo{
    if (_imageVo != nil && [_imageVo.imageUrl isEqualToString:imageVo.imageUrl]) {
        return;
    }
    _imageVo = imageVo;
    isImageChange = true;
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self->isImageChange) {
        __weak __typeof(self) weakSelf = self;
        self->isImageChange = NO;
        self.imageView.image = nil;//先清除掉
        [BatchLoaderForOC loadFile:self.imageVo.imageUrl _:^(UIImage * image) {
            CGSize trueSize = image.size;
            CGFloat prevCellHeight = weakSelf.imageVo.cellHeight;
            weakSelf.imageVo.cellHeight = weakSelf.frame.size.width / trueSize.width * trueSize.height;
            
            dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //2.添加任务到队列中，就可以执行任务
            //异步函数：具备开启新线程的能力
            dispatch_async(queue, ^{
//                NSLog(@"下载图片1----%@",[NSThread currentThread]);
                weakSelf.imageView.image = [weakSelf roundCornerRadiusImage:image _:30];
            });
            if (prevCellHeight != weakSelf.imageVo.cellHeight) {//高度不一致更新
                [weakSelf.collectionView reloadItemsAtIndexPaths:[[NSMutableArray alloc]initWithObjects:weakSelf.indexPath, nil]];
            }
        }];
    }
    self.imageView.frame = self.contentView.bounds;
    
    NSMutableAttributedString* attrString =[[NSMutableAttributedString alloc]initWithString:self.imageVo.name];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, self.imageVo.name.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, self.imageVo.name.length)];

    //    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
//    paragrapStyle.alignment = NSTextAlignmentCenter; //文本居中
//    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, self.imageVo.name.length)];
    
    self.titleView.attributedText = attrString;
    
    self.titleBack.frame = CGRectMake(0, self.contentView.bounds.size.height - 30, self.contentView.bounds.size.width, 30);
    
    CGRect b = self.titleBack.bounds; // convenience
    CGSize size = [self.titleView measure:CGSizeMake(b.size.width, FLT_MAX)];
    CGPoint origin = CGPointMake(roundf( (b.size.width - size.width) / 2.0f ),
                                 roundf( (b.size.height - size.height) / 2.0f ));
    self.titleView.frame = (CGRect){ origin, size };
//    [btn setAttributedTitle:attrString forState:ASControlStateNormal];
    
}

-(UIImage*)roundCornerRadiusImage:(UIImage*)image _:(CGFloat)cornerRadius{
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGRect imageRect = CGRectMake(0, 0, w, h);
    
    if (cornerRadius < 0) {
        cornerRadius = 0;
    }else if(cornerRadius > MIN(w, h)){
        cornerRadius = MIN(w, h) / 2;
    }
    
    UIGraphicsBeginImageContextWithOptions((CGSize){w,h}, NO, scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageRect cornerRadius:cornerRadius] addClip];//圆角遮罩区域
    [image drawInRect:imageRect]; //用位图填充
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
