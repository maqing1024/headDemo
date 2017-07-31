//
//  HeadView.m
//  LinkHead
//
//  Created by maqing on 2017/7/27.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "HeadView.h"

//屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define KGColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >>8))/255.0 blue:((s & 0xFF))/255.0 alpha:1.0]
#define MQColor(r, g, b, t) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:t]

@interface HeadView()<UIGestureRecognizerDelegate>


@end

@implementation HeadView
- (instancetype)initWithFrame:(CGRect)frame ParentController:(UIViewController *)parentC DataArray:(NSMutableArray *)dataArray {
    if (self = [super initWithFrame:frame]) {
        [self refishUI];
        NSArray *titleArray =@[@"头条",@"游戏",@"美女",@"娱乐",@"军事"];
        UIScrollView *titleScrollView = [[UIScrollView alloc]init];
        titleScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 34);
        titleScrollView.contentSize = CGSizeMake(75 *titleArray.count, 34);
        titleScrollView.bounces = NO;
        titleScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:titleScrollView];
        
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            classBtn.frame = CGRectMake(75 * i, 0, 75, 34);
            classBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei" size:16];
            
            [classBtn setTitle:titleArray[i] forState:UIControlStateNormal];
            [classBtn setBackgroundColor:[UIColor whiteColor]];
            classBtn.tag = 500 + i;
            [classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [classBtn addTarget:self action:@selector(seleteStateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [titleScrollView addSubview:classBtn];
            self.gameBtn = classBtn;
            
        }
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(0, 32, 75, 2);
        titleLabel.backgroundColor = KGColorFromHex(0xe34449);
        [titleScrollView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        
        self.listVC=[[ListViewController alloc]init];
        [self addSubview:self.listVC.view];
        self.listVC.view.frame = CGRectMake(0, 33, frame.size.width,frame.size.height);
        [parentC addChildViewController:self.listVC];
        [self.listVC didMoveToParentViewController:parentC];
    }
    
    return self;
}
- (void)refishUI {
    NSArray *titleArray =@[@"头条",@"游戏",@"美女",@"娱乐",@"军事"];
    UIScrollView *titleScrollView = [[UIScrollView alloc]init];
    titleScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 34);
    titleScrollView.contentSize = CGSizeMake(75 * titleArray.count, 34);
    titleScrollView.bounces = NO;
    titleScrollView.scrollEnabled = YES;
    titleScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:titleScrollView];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        classBtn.frame = CGRectMake(75 * i, 0, 75, 34);
        classBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [classBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [classBtn setBackgroundColor:[UIColor whiteColor]];
        classBtn.tag = 500 + i;
        [classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [classBtn addTarget:self action:@selector(seleteStateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleScrollView addSubview:classBtn];
        self.gameBtn = classBtn;
        
    }
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 32, 75, 2);
    titleLabel.backgroundColor = KGColorFromHex(0xe34449);
    [titleScrollView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
}
- (void)seleteStateBtnAction:(UIButton *)btn {
    [self.seleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.frame = CGRectMake(75*(btn.tag - 500), 32, 75, 2);
        [btn setTitleColor:KGColorFromHex(0xe34449) forState:UIControlStateNormal];
        self.seleteBtn = btn;
    }];
    [self.listVC reloadData];
}


@end
