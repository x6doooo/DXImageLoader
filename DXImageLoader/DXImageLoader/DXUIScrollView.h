//
//  DXUIScrollView.h
//  DXImageLoader
//
//  Created by Dx.Yang on 14-8-12.
//  Copyright (c) 2014年 Dx.Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXImageScrollView;

@protocol DXUIScrollViewDelegate <UIScrollViewDelegate>
- (void)singleGesture:(UIGestureRecognizer *)sender;
- (void)doubleGesture:(UIGestureRecognizer *)sender;
@end

@interface DXUIScrollView : UIScrollView
@property(nonatomic, strong) id<DXUIScrollViewDelegate> imageScrollViewDelegate;
@end
