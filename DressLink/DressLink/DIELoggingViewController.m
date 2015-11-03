//
//  DIELoggingViewController.m
//  DressLink
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 devein. All rights reserved.
//

#import "DIELoggingViewController.h"
#import "DIETitleViewController.h"
#import "DIECommunityViewController.h"
@interface DIELoggingViewController ()

@end

@implementation DIELoggingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *_back = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 100, 30)];
    [_back addTarget:self action:@selector(didBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    _back.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_back];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:@"a.png" style:UIBarButtonItemStylePlain target:self action:@selector(didLeftClicked:)];

    
}

- (void)didLeftClicked:(id)sender
{
    DIECommunityViewController *community = [DIECommunityViewController new];
    [self.navigationController pushViewController:community animated:YES];
}


- (void)didBackClicked:(id)sender
{
    DIETitleViewController *communityViewController = [DIETitleViewController new];
    [self.navigationController pushViewController:communityViewController animated:YES];
}
@end
