//
//  DXImageLoadController.m
//  DXImageLoader
//
//  Created by Dx.Yang on 14-8-7.
//  Copyright (c) 2014年 Dx.Yang. All rights reserved.
//

//  TODO:
//  点击图片可以重新加载
//  由于能够反复加载 loading圆环 & errorlabel需要复用（或者删除掉，每次生成，每次删除。这样可能性能更好）
//  upload的路径
//  upload的加载图标

#import "DXImageLoaderView.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"

@implementation DXImageLoaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 设置默认样式
        self.processCircleWidth = 20;
        self.processCircleHeight = 20;
        self.processCircleThickness = 8;
        self.processCircleCompletedColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }
    return self;
}

- (void)uploadImage
{
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSMutableURLRequest *request =
        [serializer multipartFormRequestWithMethod:@"POST"
                                         URLString:@"http://182.92.184.22/postTestAction"
                                        parameters: nil
                         constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
        {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.image, 1)
                                        name:@"file"
                                    fileName:@"myimage.jpg"
                                    mimeType:@"image/jpeg"];
        }
        error:nil];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
        [manager HTTPRequestOperationWithRequest:request
            success:^(AFHTTPRequestOperation *operation, id responseObject)
            {
                NSLog(@"Success %@", responseObject);
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error)
            {
                NSLog(@"Failure %@", error.description);
            }];
    /*
        response JSON =>
        {
            code: 0 //0 is ok or 1 is error
            desc: 'ok' //description
        }
     */
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    
    // 5. Begin!
    [operation start];
}

- (void)loadImageWithURL:(NSURL *)url
{
    int orginX = (self.bounds.size.width - self.processCircleWidth) / 2;
    int orginY = (self.bounds.size.height - self.processCircleHeight) / 2;
  
    MDRadialProgressView *radialView = [[MDRadialProgressView alloc]
                                        initWithFrame:CGRectMake(orginX, orginY,
                                                                self.processCircleWidth,
                                                                self.processCircleHeight)];
	radialView.progressTotal = 100;
    radialView.progressCounter = 0;
    radialView.theme.thickness = self.processCircleThickness;
	radialView.theme.incompletedColor = [UIColor clearColor];
	radialView.theme.completedColor = self.processCircleCompletedColor;
    radialView.theme.sliceDividerHidden = YES;
    radialView.label.hidden = YES;
	
	[self addSubview:radialView];
    
    //create request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //create operation
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //下载数据完毕后 格式化的方法
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    // 获取进度
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
    {
        radialView.progressTotal = (NSUInteger)totalBytesExpectedToRead;
        radialView.progressCounter = (NSUInteger)totalBytesRead;
    }];

    // 下载完毕
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {

        [radialView removeFromSuperview];
        self.image = responseObject;
        
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        UIImageView *errorImgView = [[UIImageView alloc]
                                     initWithFrame:CGRectMake(self.bounds.size.width / 2 - 6,
                                                              self.bounds.size.height / 2 - 6, 12, 12)];
        errorImgView.alpha = 0.3;
        errorImgView.image = [UIImage imageNamed:@"warning"];
        [self addSubview:errorImgView];
        
    }];
    
    [operation start];
}
@end
