//
//  DIECommunityViewController.m
//  DressLink
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 devein. All rights reserved.
//

#import "DIECommunityViewController.h"
#import "DIECommunityCell.h"
#import "BuyShowViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface DIECommunityViewController ()<UICollectionViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_communityCollecionView;
     NSDictionary *_dic;
     CGFloat _width;
     CGFloat _height;

}

@end

@implementation DIECommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    //设置分组边距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //最小⾏间距
    flowLayout.minimumLineSpacing = 0;
    //最⼩小间距
    flowLayout.minimumInteritemSpacing = 10;
   
    //滚动⽅方向,⽀支持⽔水平和垂直滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGSize size = self.view.bounds.size;
    _communityCollecionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, size.width, size.height) collectionViewLayout:flowLayout];
    //设置代理
    _communityCollecionView.dataSource = self;
    _communityCollecionView.delegate = self;
    //注册Cell类型
   [_communityCollecionView registerClass:[DIECommunityCell class] forCellWithReuseIdentifier:@"communityCell"];
    [self.view addSubview:_communityCollecionView];
    _communityCollecionView.backgroundColor = [UIColor redColor];


}
-(void)test{
{
     NSString *urlString = @"http://cmsmedias.dresslink.com/MobileAPI_fetchMediasData?app_key=8E9EF80383070B5304633E9E9F587DAA&platform_en_name_code=dl&per_page_count=12&show_way=2&page=0&website_code=en&session=382c5fb64cf49eb8c8d31da9a01e062a";
    
    AFHTTPSessionManager *maneger=[AFHTTPSessionManager manager];
    maneger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    [maneger GET:urlString parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
         _dic=(NSDictionary *)responseObject;
        //NSLog(@"%@",_dic);
      [_communityCollecionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败:%@",error);
    }];
    
  }
    
}



#pragma mark UICollectionViewDataSource
//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dic[@"info"]  count];
}


//每个UICollectionView 展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    DIECommunityCell *communityCell;
    communityCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"communityCell" forIndexPath:indexPath];
    
//    communityCell.label.text = nil;
//    communityCell.imageV.image = nil;
//    communityCell.imgView.image = nil;
    
    NSString *uploadTime = _dic[@"info"][indexPath.item][@"upload_time"];
    communityCell.label.text = uploadTime;
    communityCell.label.textColor = [UIColor yellowColor];
    communityCell.label.textAlignment = NSTextAlignmentCenter;
    
    NSString *str=_dic[@"info"][indexPath.item][@"image_url"];
    NSURL *url=[NSURL URLWithString:str];
    
    communityCell.imgView.image = [UIImage imageNamed:@"show_praise@2x.png"];
    [communityCell.imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ali.png"]];
    
    return communityCell;
}

#pragma mark ==UICollectionDelegateFlowLayout
//定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",indexPath.item);
    CGSize size = self.view.bounds.size;
    NSArray *arr=_dic[@"info"] ;
    NSInteger width=[arr[indexPath.item][@"image_width"] integerValue];
   CGFloat w = (CGFloat)width;
    _width = (size.width - 30)/2.0 ;
    //缩放比例
    CGFloat scale = _width/w;
    NSInteger height=[arr[indexPath.item][@"image_height"] integerValue];
    CGFloat h = (CGFloat)height;
    _height = h * scale;
    return CGSizeMake(_width, _height);
    
}


#pragma mark --UICollectionViewDelegate
//被选中时调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    DIECommunityCell *cell = (DIECommunityCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"点击了:%@",cell.label.text);
     BuyShowViewController *buyVtrl = [BuyShowViewController new];
      NSString *str = _dic[@"info"][indexPath.item][@"image_url"];
      buyVtrl.strImg = str;
    NSString *str1 = _dic[@"info"][indexPath.item][@"upload_time"];
    buyVtrl.strUpdata = str1;
    NSString *str2 = _dic[@"info"][indexPath.item][@"customers_name"];
    buyVtrl.strLable = str2;
    [self.navigationController pushViewController:buyVtrl animated:YES];
}

@end
























