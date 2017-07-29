//
//  MainTouchTableView.m
//  LinkHead
//
//  Created by maqing on 2017/7/27.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "MainTouchTableView.h"

@implementation MainTouchTableView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
