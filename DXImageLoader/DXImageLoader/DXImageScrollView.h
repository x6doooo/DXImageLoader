//
//  DXImageScrollView.h
//  DXImageLoader
//
//  Created by Dx.Yang on 14-8-11.
//  Copyright (c) 2014年 Dx.Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXUIScrollView.h"

@interface DXImageScrollView : UIView <DXUIScrollViewDelegate>
{
    UIImageView *theImage;//背景图
    DXUIScrollView *theScroll;//控制器
    CGFloat currentScale;//当前倍率
    CGFloat minScale;//最小倍率
}
@property(nonatomic) float maxScale;
- (void)setImage:(UIImage *)image;
-(void)singleGesture:(UIGestureRecognizer *)sender;
-(void)doubleGesture:(UIGestureRecognizer *)sender;
@end
