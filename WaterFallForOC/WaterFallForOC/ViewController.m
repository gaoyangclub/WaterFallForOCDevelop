//
//  ViewController.m
//  WaterFallForOC
//
//  Created by admin on 16/9/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "WaterFallLayout.h"
#import "WaterCollectionCell.h"
#import "CardInfoManager.h"


@interface ViewController ()<WaterFallLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

UICollectionView* collectionView;
NSMutableArray* cellInfoArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    cellInfoArr = [CardInfoManager getAllCardInfo];
    
//    [[NSMutableArray alloc]initWithObjects:
//                   [[ImageVo alloc]init:@"http://photo.enterdesk.com/2009-3-6/200903052204416294.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://www.bz55.com/uploads/allimg/140902/138-140Z2141A1-50.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1303/01/c1/18539066_1362129329512_320x480.png" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://b.zol-img.com.cn/sjbizhi/images/6/320x510/1384931932384.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://i2.hoopchina.com.cn/user/855/4868855/13672273231.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://i6.download.fd.pchome.net/t_230x350/g1/M00/05/1F/ooYBAFI5HBiIc9tGAAYrRcss3JwAAA4IwH3TuIABitd557.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://photo.enterdesk.com/2008-6-26/200806261057387026.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1305/28/c2/21385684_1369733667500_320x480.png" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://pic1.win4000.com/mobile/0/538d5f15094ce.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://b.zol-img.com.cn/sjbizhi/images/6/320x510/1384931936169.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://www.bz55.com/uploads/allimg/140902/138-140Z2141A0.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://5.133998.com/2014/pic/000/358/007c83e75513bc1d88e5293786f3f84f.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
//                   [[ImageVo alloc]init:@"http://pic.ffpic.com/files/2013/1208/1204lsztiphonegqdtbz11_s.jpg" andName:@"图片1" andDes:@"藐视啊哈GIA和GIAhi啊哈嘎哈共iahgoiahogha"],
////                   @300,@180,@700,@350,@116,@737,@63,@633,@484,
//                   nil];
    
    collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:[[UICollectionViewLayout alloc]init]];
    [collectionView registerClass:[WaterCollectionCell class] forCellWithReuseIdentifier:@"cellID"];
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self setWaterFallLayout];
}

-(void)setWaterFallLayout{
    WaterFallLayout* layout = [[WaterFallLayout alloc]init];
    layout.numberOfColums = 2;
    layout.delegate = self;
    
    [collectionView setCollectionViewLayout:layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageVo* imageVo = cellInfoArr[indexPath.row];
    return imageVo.cellHeight;
}

//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return cellInfoArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath: indexPath];
    ImageVo* imageVo = cellInfoArr[indexPath.row];
//    cell.backgroundColor = [UIColor blueColor];
    cell.indexPath = indexPath;
    cell.collectionView = collectionView;
    cell.imageVo = imageVo;
    return cell;
}


@end
