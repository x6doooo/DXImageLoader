//
//  DXImageLoadController.h
//  DXImageLoader
//
//  Created by Dx.Yang on 14-8-7.
//  Copyright (c) 2014年 Dx.Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

/**
 *  基于AFNetworking加载图片
 *  加载过程中显示加载进度（进度环基于MDRadiaProgress生成）
 */
@interface DXImageLoaderView : UIImageView

/// 进度环的宽度
@property(nonatomic, assign) int processCircleWidth;

/// 进度环的高度
@property(nonatomic, assign) int processCircleHeight;

/// 进度环的环宽
@property(nonatomic, assign) int processCircleThickness;

/// 进度环的颜色
@property(nonatomic, strong) UIColor *processCircleCompletedColor;

- (id)initWithFrame:(CGRect)frame;
- (void)uploadImage:(NSString *)urlString
         parameters:(NSDictionary *)params
           fileName:(NSString *)fileName
           mimeType:(NSString *)mimeType;
/**
 * @brief 根据URL加载图片
 * @param url 图片URL
 */
- (void)loadImageWithURL:(NSURL *)url;
@end
