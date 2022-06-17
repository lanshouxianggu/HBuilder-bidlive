//
//  FloatLiveDialogModule.m
//  LebLivePlugin
//
//  Created by bidlive on 2022/6/1.
//

#import "FloatLiveDialogModule.h"
#import "LebLiveFloatView.h"
#import <LiveEB_IOS/LiveEBVideoView.h>
#import <LiveEB_IOS/LiveEBManager.h>
#import "DCUniConvert.h"

static NSString *sLiveUrl;
static BOOL sIsFullScreen;
static BOOL sViewDidUnload;
static CGFloat sVideoFixWidth;
static CGFloat sVideoFixHeight;

static const CGFloat sFullScreenVideoWidth = 264;
static const CGFloat sFullScreenVideoHeight = 153;
static const CGFloat sVideoWidth = 152;
static const CGFloat sVideoHeight = 268;

@interface FloatLiveDialogModule ()
@property (nonatomic, strong) LebLiveFloatView *floatView;
@property (nonatomic, assign) BOOL hasOpenMiniFloatDialog;
@end

@implementation FloatLiveDialogModule
// 通过宏 UNI_EXPORT_METHOD_SYNC 将同步方法暴露给 js 端
UNI_EXPORT_METHOD_SYNC(@selector(testFloatView:))

// 通过宏 UNI_EXPORT_METHOD 将异步方法暴露给 js 端
UNI_EXPORT_METHOD(@selector(testAsyncFunc:callback:))
UNI_EXPORT_METHOD(@selector(openMiniFloatDialog:isFullScreen:callback:))
UNI_EXPORT_METHOD(@selector(closeMiniFloatDialog))

-(void)closeMiniFloatDialog {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.floatView) {
            [self.floatView endPlay];
            [[LiveEBManager sharedManager] finitSDK];
            [self.floatView removeFromSuperview];
            self.hasOpenMiniFloatDialog = NO;
            NSLog(@"视频悬浮窗关闭");
        }
    });
}

-(void)openMiniFloatDialog:(NSString *)videoUrl isFullScreen:(BOOL)isFullScreen callback:(UniModuleKeepAliveCallback)callback{
    if (self.hasOpenMiniFloatDialog) {
        return;
    }
    self.hasOpenMiniFloatDialog = YES;
    NSLog(@"视频悬浮窗显示");
    //显示播流浮窗
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *liveUrl = videoUrl;
        CGFloat offsetY = UIApplication.sharedApplication.statusBarFrame.size.height;
//        CGFloat left = UIScreen.mainScreen.bounds.size.width-(isFullScreen?sFullScreenVideoWidth:sVideoWidth);
        CGFloat left = UIScreen.mainScreen.bounds.size.width;
        CGFloat width = isFullScreen?(UIScreen.mainScreen.bounds.size.width*0.45):(UIScreen.mainScreen.bounds.size.width*0.26);
        CGFloat height = isFullScreen?(width*0.58):(width*1.75);
        CGFloat top = UIScreen.mainScreen.bounds.size.height/2-height/2;
        CGRect floatRect = CGRectMake(left, top, width, height);
        for (UIView *subView in [UIApplication sharedApplication].windows.firstObject.subviews) {
            if ([subView isKindOfClass:[LebLiveFloatView class]]) {
                [subView removeFromSuperview];
            }
        }

        
        LebLiveFloatView *floatView = [[LebLiveFloatView alloc] initWithFrame:floatRect liveUrl:liveUrl isFullScreen:isFullScreen fixWidth:sVideoFixWidth fixHeight:sVideoFixHeight];
        floatView.layer.cornerRadius = 4;
        floatView.layer.masksToBounds = YES;
        self.floatView = floatView;
        
        UIApplication *app = [UIApplication sharedApplication];
        UIWindow *uiwindow = app.windows.firstObject;
        [uiwindow addSubview:floatView];
        
        [floatView show];
        [floatView startPlay];
        
        [floatView setFloatViewTapBlock:^{
            if (callback) {
                callback(@"videoFloatViewTap",YES);
            }
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.35 animations:^{
                self.floatView.transform = CGAffineTransformMakeTranslation(-width, 0);
            }];
        });
    });
}

- (void)testAsyncFunc:(NSDictionary *)options callback:(UniModuleKeepAliveCallback)callback {

    BOOL isFullScreen = [DCUniConvert BOOL:options[@"isFullScreen"]];
    NSString *videoUrl = [DCUniConvert NSString:options[@"liveUrl"]];
    //显示播流浮窗
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *liveUrl = videoUrl;
        CGFloat offsetY = UIApplication.sharedApplication.statusBarFrame.size.height;
        CGFloat left = UIScreen.mainScreen.bounds.size.width-(isFullScreen?sFullScreenVideoWidth:sVideoWidth)-10;
        CGFloat top = UIScreen.mainScreen.bounds.size.height/2-(isFullScreen?sFullScreenVideoHeight/2:sVideoHeight/2);
//            CGRect floatRect = sIsFullScreen?CGRectMake(10+offsetY, 10, 200, 120):CGRectMake(10, 10+offsetY, 120, 160);
        CGRect floatRect = isFullScreen?CGRectMake(left, top, sFullScreenVideoWidth, sFullScreenVideoHeight):CGRectMake(left, top, sVideoWidth, sVideoHeight);
        for (UIView *subView in [UIApplication sharedApplication].windows.firstObject.subviews) {
            if ([subView isKindOfClass:[LebLiveFloatView class]]) {
                [subView removeFromSuperview];
            }
        }

        
        LebLiveFloatView *floatView = [[LebLiveFloatView alloc] initWithFrame:floatRect liveUrl:liveUrl isFullScreen:isFullScreen fixWidth:sVideoFixWidth fixHeight:sVideoFixHeight];
        floatView.layer.cornerRadius = 4;
        floatView.layer.masksToBounds = YES;

        UIApplication *app = [UIApplication sharedApplication];
        UIWindow *uiwindow = app.windows.firstObject;
        [uiwindow addSubview:floatView];
        
        [floatView show];
        [floatView startPlay];
        
        [floatView setFloatViewTapBlock:^{
            if (callback) {
                callback(@"videoFloatViewTap",YES);
            }
        }];
        [floatView setFloatViewDismissBlock:^{
            if (callback) {
                callback(@"videoFloatViewColse",YES);
            }
        }];
    });
}

/// 同步方法（注：同步方法会在 js 线程执行）
- (void)testFloatView:(NSDictionary *)dict {
    NSLog(@"%@", dict);
    NSDictionary *dataDic = [dict valueForKey:@"detail"];
    sIsFullScreen = [DCUniConvert BOOL:dataDic[@"isFullScreen"]];
    sLiveUrl = [DCUniConvert NSString:dataDic[@"liveUrl"]];
    sVideoFixWidth = [DCUniConvert CGFloat:dataDic[@"videoFixWidth"]];
    sVideoFixHeight = [DCUniConvert CGFloat:dataDic[@"videoFixHeight"]];
    //显示播流浮窗
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *liveUrl = sLiveUrl;
        CGFloat offsetY = UIApplication.sharedApplication.statusBarFrame.size.height;
        CGFloat left = UIScreen.mainScreen.bounds.size.width-(sIsFullScreen?sFullScreenVideoWidth:sVideoWidth)-10;
        CGFloat top = UIScreen.mainScreen.bounds.size.height/2-(sIsFullScreen?sFullScreenVideoHeight/2:sVideoHeight/2);
        
//            CGRect floatRect = sIsFullScreen?CGRectMake(10+offsetY, 10, 200, 120):CGRectMake(10, 10+offsetY, 120, 160);
        CGRect floatRect = sIsFullScreen?CGRectMake(left, top, sFullScreenVideoWidth, sFullScreenVideoHeight):CGRectMake(left, top, sVideoWidth, sVideoHeight);
        BOOL isFullScreen = sIsFullScreen;
        for (UIView *subView in [UIApplication sharedApplication].windows.firstObject.subviews) {
            if ([subView isKindOfClass:[LebLiveFloatView class]]) {
                [subView removeFromSuperview];
            }
        }

        
        LebLiveFloatView *floatView = [[LebLiveFloatView alloc] initWithFrame:floatRect liveUrl:liveUrl isFullScreen:isFullScreen fixWidth:sVideoFixWidth fixHeight:sVideoFixHeight];
        floatView.layer.cornerRadius = 4;
        floatView.layer.masksToBounds = YES;

        UIApplication *app = [UIApplication sharedApplication];
        UIWindow *uiwindow = app.windows.firstObject;
        [uiwindow addSubview:floatView];
        
        [floatView show];
        [floatView startPlay];
    });
}
@end
