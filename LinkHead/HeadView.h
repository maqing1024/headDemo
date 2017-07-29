//
//  HeadView.h
//  LinkHead
//
//  Created by maqing on 2017/7/27.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"

@interface HeadView : UIView
@property (nonatomic, strong) UIButton *gameBtn;
@property (nonatomic, strong) UIButton *seleteBtn;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITapGestureRecognizer *gametapGester;

@property (nonatomic, strong) ListViewController *listVC;
- (instancetype)initWithFrame:(CGRect)frame ParentController:(UIViewController *)parentC DataArray:(NSMutableArray *)dataArray;

@end
