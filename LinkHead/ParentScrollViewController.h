//
//  ParentScrollViewController.h
//  LinkHead
//
//  Created by maqing on 2017/7/26.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentScrollViewController : UIViewController

@property(strong, nonatomic)UIScrollView *scrollView;//整个滑动view
@property(assign, nonatomic)BOOL canScroll;//判断当TableView滑到顶端时是否可以移动

@end
