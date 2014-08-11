//
//  DXAppDelegate.m
//  DXImageLoader
//
//  Created by Dx.Yang on 14-8-7.
//  Copyright (c) 2014年 Dx.Yang. All rights reserved.
//

#import "DXAppDelegate.h"
#import "DXImageLoaderView.h"

@implementation DXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    int imageSizeWidth = 300;
    int imageSizeHeight = 150;
    DXImageLoaderView *imageView0 = [[DXImageLoaderView alloc] initWithFrame:CGRectMake(10, 30,
                                                                            imageSizeWidth,
                                                                            imageSizeHeight)];
    imageView0.backgroundColor = [UIColor whiteColor];
    imageView0.layer.borderColor = [[UIColor blackColor] CGColor];
    imageView0.layer.borderWidth = 0.5f;
    
    [self.window addSubview:imageView0];

    // 链接
    NSString *imageURLString = [NSString stringWithFormat:@"http://182.92.184.22/statics/pics/201407311700-xxxx-color3a4737.jpg?%li", time(NULL)];
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    // 下载
    [imageView0 loadImageWithURL:imageURL];
    
    // 上传
    imageView0.tag = 101;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(120, 300, 80, 30);
    [button setTitle:@"upload" forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(uploadImage:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    return YES;
}

- (IBAction)uploadImage:(id)sender
{
    DXImageLoaderView *imageView0 = (DXImageLoaderView *)[self.window viewWithTag:101];
    [imageView0 uploadImage:@"http://182.92.184.22/postTestAction"
                 parameters:nil
                   fileName:@"testimage.jpg"
                   mimeType:@"image/jpeg"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
