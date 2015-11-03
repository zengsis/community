//
//  BuyShowViewController.m
//  DressLink
//
//  Created by apple on 15/10/25.
//  Copyright © 2015年 devein. All rights reserved.
//

#import "BuyShowViewController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface BuyShowViewController ()
{
    NSInteger _indexPath;
    UILabel *_lable;
    UILabel *_nickName;
    UIImageView *_imgView;
    UIImageView *_avoterView;
}

@end

@implementation BuyShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
            [self CreatInit];
}

- (void)CreatInit
{
    //头像
    _avoterView = [UIImageView new];
    [self.view addSubview:_avoterView];
    [_avoterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@20);
        make.size.equalTo(MASBoxValue(CGSizeMake(60, 80)));
    }];
    _avoterView.backgroundColor = [UIColor orangeColor];
    
    //昵称
    _nickName = [UILabel new];
    [self.view addSubview:_nickName];
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avoterView.mas_top);
        make.left.equalTo(_avoterView.mas_right).offset(15);
        make.size.equalTo(MASBoxValue(CGSizeMake(100, 35)));
    }];
    
    //更新
    _lable = [UILabel new];
    [self.view addSubview:_lable];
    [_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickName.mas_bottom).offset(10);
        make.left.equalTo(_nickName);
        make.size.equalTo(MASBoxValue(CGSizeMake(250, 30)));
    }];
    
    
    _imgView = [UIImageView new];
    [self.view addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lable.mas_bottom).offset(20);
        make.left.equalTo(@30);
        make.size.equalTo(MASBoxValue(CGSizeMake(300, 400)));
    }];
     [_imgView sd_setImageWithURL:[NSURL URLWithString:_strImg]];
    _lable.text = _strUpdata;
    _nickName.text = _strLable;

}


@end
