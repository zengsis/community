//
//  TitleCommunityView.m
//  DressLink
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 devein. All rights reserved.
//


#import "TitleCommunityView.h"

@interface TitleCommunityView ()
{
    NSMutableArray *_titleButtonArray;
    NSMutableArray *_titleViewArray;
}

@end

@implementation TitleCommunityView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleButtonArray = [NSMutableArray array];
        _titleViewArray = [NSMutableArray array];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    for (UIButton *button in _titleButtonArray)
    {
        [button removeFromSuperview];
    }
    [_titleButtonArray removeAllObjects];
    for (UIView *view in _titleViewArray){
        [view removeFromSuperview];
    }
    [_titleViewArray removeAllObjects];

    CGFloat iWidth = self.frame.size.width/titleArray.count;
    CGFloat buttonHeight = self.frame.size.height - 5;
    //CGFloat lineHeight = 5;
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(iWidth*i, 0, iWidth, buttonHeight);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_titleButtonArray addObject:button];
        button.backgroundColor = [UIColor yellowColor];
        [_titleViewArray addObject:button.backgroundColor];
    }
    self.selectedIndex = 0;
}

- (void)buttonClicked:(UIButton *)sender{
    self.selectedIndex= sender.tag-1000;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setSelectedIndex:(NSUInteger)selectIndex{
    _selectedIndex = selectIndex;
    for (UIButton *button in _titleButtonArray) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
    }
    UIButton *button = _titleButtonArray[_selectedIndex];
    button.backgroundColor = _titleViewArray[_selectedIndex];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    
}

@end

















