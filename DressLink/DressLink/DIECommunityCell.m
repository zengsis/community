//
//  DIECommunityCell.m
//  DressLink
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 devein. All rights reserved.
//

#import "DIECommunityCell.h"
#import "Masonry.h"

@implementation DIECommunityCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageV];
        _label = [[UILabel alloc]init];
        [self.contentView addSubview:_label];
        _imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:_imgView];
        
        //注意是contentView里设大小
        CGSize size = self.contentView.bounds.size;
        [_imageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(@0);
            make.size.equalTo(MASBoxValue(CGSizeMake(size.width, size.height-30)));
        }];
        _label.textAlignment = NSTextAlignmentCenter;
        
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageV.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.size.equalTo(MASBoxValue(CGSizeMake(size.width, 15)));
        }];
        
        [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_label.mas_bottom);
            make.left.equalTo(self.mas_left).offset(30);
            make.size.equalTo(MASBoxValue(CGSizeMake(15, 15)));
        }];

    }
    return self;
}







@end
