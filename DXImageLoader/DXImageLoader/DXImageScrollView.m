//
//  DXImageScrollView.m
//  DXImageLoader
//
//  Created by Dx.Yang on 14-8-11.
//  Copyright (c) 2014年 Dx.Yang. All rights reserved.
//

#import "DXImageScrollView.h"


@implementation DXImageScrollView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _maxScale = 2.0;
        minScale = 1.0;
        currentScale = 1.0;

        theScroll = [[DXUIScrollView alloc] initWithFrame:frame];
        theScroll.userInteractionEnabled = YES;
        theScroll.maximumZoomScale = 2.0;
        theScroll.minimumZoomScale = 1.0;
        theScroll.decelerationRate = 1.0;
        theScroll.delegate = self;
        // 代理缩放视图的单双击操作
        theScroll.imageScrollViewDelegate = self;
        theScroll.backgroundColor = [UIColor blackColor];
        theScroll.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|
                                     UIViewAutoresizingFlexibleTopMargin|
                                     UIViewAutoresizingFlexibleHeight;

        [self addSubview:theScroll];
        
        theImage = [[UIImageView alloc] init];
        
        //图片
        //UIImage *theImageName=[UIImage imageNamed:imageName];
        //theImage=[[UIImageView alloc] initWithImage:theImageName];
        theImage.userInteractionEnabled=YES;
        theImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
        //图片默认作为2倍图处理
        
        [theScroll addSubview:theImage];
        
    }
    return self;
}


-(void)singleGesture:(UIGestureRecognizer *)sender
{
    NSLog(@"1111");
    [self removeFromSuperview];
}

- (void)setImage:(UIImage *)image
{
    //UIImage *_image = [UIImage imageWithData:UIImageJPEGRepresentation(image, 1)];
    //theImage = [[UIImageView alloc] initWithImage:_image];
    theImage.image = image;
    //NSLog(@"%f, %f", self.frame.size.width, self.frame.size.height);

    //theImage.frame = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
    //[theScroll setContentSize:CGSizeMake(image.size.width/2, image.size.height/2)];
    theImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    theImage.contentMode = UIViewContentModeScaleAspectFit;
    [theScroll setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
}

#pragma mark -setter action
-(void)setMaxScale:(float)maxScale
{
    _maxScale=maxScale;
    theScroll.maximumZoomScale=maxScale;
}

#pragma mark -UIScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return theImage;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    currentScale=scale;
}
#pragma mark -DoubleGesture Action
-(void)doubleGesture:(UIGestureRecognizer *)sender
{
    
    //当前倍数等于最大放大倍数
    //双击默认为缩小到原图
    if (currentScale == _maxScale) {
        currentScale = minScale;
        [theScroll setZoomScale:currentScale animated:YES];
        return;
    }
    //当前等于最小放大倍数
    //双击默认为放大到最大倍数
    if (currentScale == minScale) {
        currentScale = _maxScale;
        [theScroll setZoomScale:currentScale animated:YES];
        return;
    }
    
    CGFloat aveScale = minScale + (_maxScale - minScale) / 2.0;//中间倍数
    
    //当前倍数大于平均倍数
    //双击默认为放大最大倍数
    if (currentScale >= aveScale) {
        currentScale = _maxScale;
        [theScroll setZoomScale:currentScale animated:YES];
        return;
    }
    
    //当前倍数小于平均倍数
    //双击默认为放大到最小倍数
    if (currentScale < aveScale) {
        currentScale = minScale;
        [theScroll setZoomScale:currentScale animated:YES];
        return;
    }
}

@end
