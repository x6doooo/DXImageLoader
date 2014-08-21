//
//  DXUIScrollView.m
//  DXImageLoader
//
//  Created by Dx.Yang on 14-8-12.
//  Copyright (c) 2014年 Dx.Yang. All rights reserved.
//

#import "DXUIScrollView.h"
#import "DXImageScrollView.h"

@implementation DXUIScrollView
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //计数
    int count = touch.tapCount;
    //单击
    if (count == 1)
    {
        //延迟执行单击方法
        [self performSelector:@selector(singleTap) withObject:nil afterDelay:0.2];
    }
    else if (count == 2)
    {
        //取消单击方法
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
        //执行双击方法
        [self doubleTap];
    }
}
//单击方法
-(void)singleTap
{
    NSLog(@"单击");
    [self.imageScrollViewDelegate singleGesture:nil];
    //UIView *view = [self viewWithTag:100];
    //view.backgroundColor = [UIColor blueColor];
}
//双击方法
-(void)doubleTap
{
    NSLog(@"双击");
    [self.imageScrollViewDelegate doubleGesture:nil];
    //UIView *view = [self viewWithTag:100];
    //view.backgroundColor = [UIColor redColor];
}
@end
