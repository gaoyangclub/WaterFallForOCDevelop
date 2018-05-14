
//
//  WaterCollectionCell.m
//  WaterFallForOC
//
//  Created by admin on 16/9/6.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WaterCollectionCell.h"
#import "BatchLoaderForOC.h"
#import "UIImage+ImageEffects.h"


@implementation GradientNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制
    }
    return self;
}

+(void)drawRect:(CGRect)bounds withParameters:(id<NSObject>)parameters isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock isRasterizing:(BOOL)isRasterizing{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    CGContextClipToRect(context, bounds);
    
    UIColor* startColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    UIColor* endColor = [UIColor blackColor];
    
    
    CFArrayRef colors = CFArrayCreate(kCFAllocatorDefault, (const void*[]){startColor.CGColor, endColor.CGColor}, 2, nil);
    
    //3 - set up the color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //4 - set up the color stops
    const CGFloat colorLocations[2] = {0, 1};
    
    //5 - create the gradient
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,colors,
                                                        colorLocations);
    //6 - draw the gradient
    CGPoint startPoint = CGPointMake(0,0);
    CGPoint endPoint = CGPointMake(0, bounds.size.height);
    //        var endPoint = CGPoint(x:self.bounds.width, y:self.bounds.height)
    //由绘制的首末位置决定绘制径向路径
    
    //径向渐变
    CGContextDrawLinearGradient(context,
                                gradient,
                                startPoint,
                                endPoint,kCGGradientDrawsBeforeStartLocation);
    
//    CGContextRestoreGState(context);
}

@end

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
        _imageView.layerBacked = YES;
//        _imageView.backgroundColor = [UIColor whiteColor];
//        _imageView.layer.cornerRadius = 30;
//        _imageView.cornerRadius = 30;
//        _imageView.layer.masksToBounds = YES;
        [self.contentView.layer addSublayer:_imageView.layer];
    }
    return _imageView;
}

-(ASImageNode *)backImageView{
    if (!_backImageView) {
        _backImageView = [[ASImageNode alloc]init];
        _backImageView.layerBacked = YES;
//        _backImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView.layer addSublayer:_backImageView.layer];
//        __weak __typeof(self) weakSelf = self;
        id imageBlock = ^(UIImage * input) {
//            UIImage* roundImage = [weakSelf roundCornerRadiusImage:input _:30];
            UIImage* blurredImage = [input applyBlurWithRadius:30 tintColor:[[UIColor alloc] initWithWhite:0.5 alpha:0.3] saturationDeltaFactor:1.8 maskImage:nil];
            return blurredImage;
        };
        _backImageView.imageModificationBlock = imageBlock;
    }
    return _backImageView;
}

-(ASTextNode *)titleView{
    if (!_titleView) {
        _titleView = [[ASTextNode alloc]init];
        _titleView.layerBacked = YES;
//        _titleView.textColor = [UIColor whiteColor];
//        _titleView.backgroundColor = [[UIColor alloc]initWithCGColor:CGColorCreateCopyWithAlpha([UIColor blackColor].CGColor, 0.6)];
//        _titleView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
//        _titleView.textAlignment = NSTextAlignmentCenter;
        [self.titleBack addSubnode:_titleView];
    }
    return _titleView;
}

-(ASTextNode *)descriptionView{
    if (!_descriptionView) {
        _descriptionView = [[ASTextNode alloc]init];
        _descriptionView.layerBacked = YES;
        [self.contentView.layer addSublayer:_descriptionView.layer];
    }
    return _descriptionView;
}

- (ASDisplayNode *)titleBack{
    if (!_titleBack) {
        _titleBack = [[GradientNode alloc]init];
//        _titleBack.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
//        _titleBack.opaque = NO;
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
    
    self.backImageView;
    self.imageView;
    self.titleView;
    self.descriptionView;
    
    if (self->isImageChange) {
        __weak __typeof(self) weakSelf = self;
        self->isImageChange = NO;
        self.imageView.image = nil;//先清除掉
        self.backImageView.image = nil;
        [BatchLoaderForOC loadFile:self.imageVo.imageUrl _:^(UIImage * image) {
            CGFloat desPadding = 10;
            //    self.imageView.frame = self.contentView.bounds;
            
            NSMutableAttributedString* desString =[[NSMutableAttributedString alloc]initWithString:weakSelf.imageVo.describe];
            [desString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, weakSelf.imageVo.describe.length)];
            [desString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, weakSelf.imageVo.describe.length)];
            
            weakSelf.descriptionView.attributedText = desString;
            CGFloat desWidth = weakSelf.contentView.bounds.size.width - desPadding * 2;
            CGSize desSize = [weakSelf.descriptionView measure:CGSizeMake(desWidth, FLT_MAX)];
            CGFloat desHeight = desSize.height;
            
            CGSize trueSize = image.size;
            CGFloat prevCellHeight = weakSelf.imageVo.cellHeight;
            CGFloat imageHeight = weakSelf.frame.size.width / trueSize.width * trueSize.height;
            CGFloat cellHeight = imageHeight + desHeight + desPadding * 2;
            
            weakSelf.imageVo.cellHeight = cellHeight;
            
            [weakSelf measureChilds:desWidth _:desHeight _:desPadding _:imageHeight _:cellHeight];
            
            dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //2.添加任务到队列中，就可以执行任务
            //异步函数：具备开启新线程的能力
            dispatch_async(queue, ^{
//                NSLog(@"下载图片1----%@",[NSThread currentThread]);
                UIImage* roundImage = [weakSelf roundCornerRadiusImage:image _:30];
                weakSelf.imageView.image = image;
                weakSelf.backImageView.image = image;
            });
            
            if (prevCellHeight != weakSelf.imageVo.cellHeight) {//高度不一致更新
                [weakSelf.collectionView reloadItemsAtIndexPaths:[[NSMutableArray alloc]initWithObjects:weakSelf.indexPath, nil]];
            }
        }];
    }
//    [btn setAttributedTitle:attrString forState:ASControlStateNormal];
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

-(void)measureChilds:(CGFloat)desWidth _:(CGFloat)desHeight _:(CGFloat)desPadding _:(CGFloat)imageHeight _:(CGFloat)cellHeight{
    
    self.backImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, cellHeight);
    
    self.imageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, imageHeight);
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]initWithString:self.imageVo.name];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, self.imageVo.name.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNext-Heavy" size:20] range:NSMakeRange(0, self.imageVo.name.length)];
    //    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    //    paragrapStyle.alignment = NSTextAlignmentCenter; //文本居中
    //    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, self.imageVo.name.length)];
    
    self.titleView.attributedText = attrString;
    
    CGFloat titleLeft = 10;
    CGRect b = self.contentView.bounds; // convenience
    CGSize size = [self.titleView measure:CGSizeMake(b.size.width - titleLeft, FLT_MAX)];
    CGPoint origin = CGPointMake(titleLeft, 0);
    
    CGFloat titleHeight = size.height;
    
    self.titleBack.frame = CGRectMake(0, self.imageView.bounds.size.height - titleHeight, self.imageView.bounds.size.width, titleHeight);
//    roundf( (b.size.height - size.height) / 2.0f ));
    self.titleView.frame = (CGRect){ origin, size };
    
    self.descriptionView.frame = CGRectMake(desPadding, self.contentView.bounds.size.height - desPadding - desHeight, desWidth, desHeight);
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
