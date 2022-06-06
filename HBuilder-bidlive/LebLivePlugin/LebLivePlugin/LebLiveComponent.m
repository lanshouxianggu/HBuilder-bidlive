
//  Created by TK on 2021/3/16.

#import "LebLiveComponent.h"
#import <LiveEB_IOS/LiveEBVideoView.h>
#import <LiveEB_IOS/LiveEBManager.h>
#import "DCUniConvert.h"
#import "WebRtcView.h"
#import "LebLiveFloatView.h"

static NSString *sLiveUrl;
static BOOL sIsFullScreen;
static BOOL sViewDidUnload;
static CGFloat sVideoFixWidth;
static CGFloat sVideoFixHeight;

static const CGFloat sFullScreenVideoWidth = 200;
static const CGFloat sFullScreenVideoHeight = 120;
static const CGFloat sVideoWidth = 120;
static const CGFloat sVideoHeight = 160;

@interface LebLiveComponent ()

//事件
@property (nonatomic, assign) BOOL didErrorEvent;
@property (nonatomic, assign) BOOL didChangeVideoSizeEvent;
@property (nonatomic, assign) BOOL onPreparedEvent;
@property (nonatomic, assign) BOOL onCompletionEvent;
@property (nonatomic, assign) BOOL onFirstFrameRenderEvent;
@property (nonatomic, assign) BOOL onVideoFloatViewClickEvent;
@property (nonatomic, assign) BOOL onVideoMinimizeClickEvent;
@property (nonatomic, assign) BOOL onNavigateBackEvent;
@property (nonatomic, assign) BOOL showStatsEvent;
@property (nonatomic, copy) NSString *liveUrl;
@property (nonatomic, assign) BOOL isFullScreen;

@end

@implementation LebLiveComponent



-(void)onCreateComponentWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events uniInstance:(DCUniSDKInstance *)uniInstance
{
}

- (UIView *)loadView {
    return [UIView new];
}

-(void)viewWillLoad {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *subView in [UIApplication sharedApplication].windows.firstObject.subviews) {
            if ([subView isKindOfClass:[LebLiveFloatView class]]) {
                LebLiveFloatView *floatView = (LebLiveFloatView *)subView;
                [floatView endPlay];
                [subView removeFromSuperview];
                sViewDidUnload = NO;
                [[LiveEBManager sharedManager] finitSDK];
            }
        }
    });
}

-(void)viewDidUnload {
//    if (!sViewDidUnload) {
//        sViewDidUnload = YES;
//        //显示播流浮窗
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSString *liveUrl = sLiveUrl;
//            CGFloat offsetY = UIApplication.sharedApplication.statusBarFrame.size.height;
//            CGFloat left = UIScreen.mainScreen.bounds.size.width-(sIsFullScreen?sFullScreenVideoWidth:sVideoWidth)-10;
//            CGFloat top = UIScreen.mainScreen.bounds.size.height/2-(sIsFullScreen?sFullScreenVideoHeight/2:sVideoHeight/2);
//
////            CGRect floatRect = sIsFullScreen?CGRectMake(10+offsetY, 10, 200, 120):CGRectMake(10, 10+offsetY, 120, 160);
//            CGRect floatRect = sIsFullScreen?CGRectMake(left, top, sFullScreenVideoWidth, sFullScreenVideoHeight):CGRectMake(left, top, sVideoWidth, sVideoHeight);
//            BOOL isFullScreen = sIsFullScreen;
//            for (UIView *subView in [UIApplication sharedApplication].windows.firstObject.subviews) {
//                if ([subView isKindOfClass:[LebLiveFloatView class]]) {
//                    [subView removeFromSuperview];
//                }
//            }
//
//
//            LebLiveFloatView *floatView = [[LebLiveFloatView alloc] initWithFrame:floatRect liveUrl:liveUrl isFullScreen:isFullScreen fixWidth:sVideoFixWidth fixHeight:sVideoFixHeight];
//            floatView.layer.cornerRadius = 4;
//            floatView.layer.masksToBounds = YES;
//
//            UIApplication *app = [UIApplication sharedApplication];
//            UIWindow *uiwindow = app.windows.firstObject;
//            [uiwindow addSubview:floatView];
//
//            [floatView show];
//            [floatView startPlay];
//            [floatView setFloatViewDismissBlock:^{
//                [[LiveEBManager sharedManager] finitSDK];
//                sViewDidUnload = NO;
//            }];
//
//            __weak typeof(self) weakeSelf = self;
//            [floatView setFloatViewTapBlock:^{
//                sViewDidUnload = NO;
//                [weakeSelf fireEvent:@"onVideoFloatViewClickEvent" params:@{@"detail":@{@"desc":@"videoFloatViewClick"}} domChanges:nil];
//            }];
//        });
//    }
    
}

- (void)viewWillUnload {
    [[LiveEBManager sharedManager] finitSDK];
}

-(void)showFloatView {
    if (!sViewDidUnload) {
        sViewDidUnload = YES;
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
            [floatView setFloatViewDismissBlock:^{
                [[LiveEBManager sharedManager] finitSDK];
                sViewDidUnload = NO;
            }];
            __block LebLiveComponent *tempSelf = self;
            [floatView setFloatViewTapBlock:^{
                sViewDidUnload = NO;
                [tempSelf fireEvent:@"onVideoFloatViewClickEvent" params:@{@"detail":@{@"desc":@"videoFloatViewClick"}} domChanges:nil];
            }];
        });
    }
}


/// 前端注册的事件会调用此方法
///
///
/// @param eventName 事件名称
- (void)addEvent:(NSString *)eventName {
    if ([eventName isEqualToString:@"onEventConnected"]) {
        _onPreparedEvent = YES;
    }
    if ([eventName isEqualToString:@"onEventConnectFailed"]) {
        _didErrorEvent = YES;
    }
    if ([eventName isEqualToString:@"onEventDisconnect"]) {
        _onCompletionEvent = YES;
    }
    if ([eventName isEqualToString:@"onEventFirstFrameRendered"]) {
        _onFirstFrameRenderEvent = YES;
    }
    if ([eventName isEqualToString:@"onEventStatsReport"]) {
        _showStatsEvent = YES;
    }
    if ([eventName isEqualToString:@"onVideoFloatViewClickEvent"]) {
        _onVideoFloatViewClickEvent = YES;
    }
    if ([eventName isEqualToString:@"onVideoMinimizeClickEvent"]) {
        _onVideoMinimizeClickEvent = YES;
    }
    if ([eventName isEqualToString:@"onNavigateBackEvent"]) {
        _onNavigateBackEvent = YES;
    }
}

/// 对应的移除事件回调方法
/// @param eventName 事件名称
- (void)removeEvent:(NSString *)eventName {
    if ([eventName isEqualToString:@"onEventConnected"]) {
        _onPreparedEvent = NO;
    }
    if ([eventName isEqualToString:@"onEventConnectFailed"]) {
        _didErrorEvent = NO;
    }
    if ([eventName isEqualToString:@"onEventDisconnect"]) {
        _onCompletionEvent = NO;
    }
    if ([eventName isEqualToString:@"onEventFirstFrameRendered"]) {
        _onFirstFrameRenderEvent = NO;
    }
    if ([eventName isEqualToString:@"onEventStatsReport"]) {
        _showStatsEvent = NO;
    }
    if ([eventName isEqualToString:@"onVideoFloatViewClickEvent"]) {
        _onVideoFloatViewClickEvent = NO;
    }
    if ([eventName isEqualToString:@"onVideoMinimizeClickEvent"]) {
        _onVideoMinimizeClickEvent = NO;
    }
    if ([eventName isEqualToString:@"onNavigateBackEvent"]) {
        _onNavigateBackEvent = NO;
    }
}

// 通过 WX_EXPORT_METHOD 将方法暴露给前端
UNI_EXPORT_METHOD(@selector(resetVideoSize:height:))
UNI_EXPORT_METHOD(@selector(startPlay))
UNI_EXPORT_METHOD(@selector(stopPlay))
UNI_EXPORT_METHOD(@selector(resumePlay))
UNI_EXPORT_METHOD(@selector(pausePlay))
UNI_EXPORT_METHOD(@selector(releaseLeb))
UNI_EXPORT_METHOD(@selector(mutePlay:))
UNI_EXPORT_METHOD(@selector(setVolume:))
UNI_EXPORT_METHOD(@selector(setRenderRotation:))
UNI_EXPORT_METHOD(@selector(initLeb:callback:))
UNI_EXPORT_METHOD(@selector(rotateVideo:))


- (void) resetVideoSize:(float)width height:(float)height {
    NSLog(@"setLandscape");
    [self setVideoSize:width height:height];
}


- (void)startPlay {
    NSLog(@"startPlay");
    [_rtcView.videoView start];
}

- (void)stopPlay {
    NSLog(@"stopPlay");
    [_rtcView.videoView stop];
}

-(void)rotateVideo:(BOOL)rotate {
    self.isFullScreen = rotate;
    sIsFullScreen = rotate;
}

- (void)pausePlay {
    NSLog(@"pausePlay");
    [_rtcView.videoView pause];
}

- (void)resumePlay {
    NSLog(@"resumePlay");
    [_rtcView.videoView resume];
}

- (void)releaseLeb {
    NSLog(@"releaseLeb");
}
- (void)mutePlay:(NSDictionary *)options {
    NSLog(@"mutePlay");
    BOOL value = [DCUniConvert BOOL: options[@"value"]];
    [_rtcView.videoView setAudioMute:value];}

- (void)setVolume:(NSDictionary *)options {
    NSLog(@"setVolume");
    CGFloat value = [DCUniConvert CGFloat: options[@"value"]];
    [_rtcView.videoView setVolume:value];
}

- (void)setRenderRotation:(NSDictionary *)options {
    NSLog(@"setRenderRotation");
    NSInteger value = [DCUniConvert CGFloat: options[@"value"]];
    [_rtcView.videoView setRenderRotation:(LEBVideoRotation)value];
}

- (void)initLeb:(NSDictionary *)options  callback:(UniModuleKeepAliveCallback)callback{
    NSLog(@"initLeb");
    //{'width':width, 'height':height, 'liveUrl':url, 'autoPlay':isAutoPlay}
    NSString* liveUrl = [DCUniConvert NSString: options[@"liveUrl"]];
    
    CGFloat layoutWidth = [DCUniConvert CGFloat: options[@"width"]];;
    CGFloat layoutHeight = [DCUniConvert CGFloat: options[@"height"]];;

    _videoWidthRate = [DCUniConvert CGFloat: options[@"videoWidthRate"]];
    _videoHeightRate = [DCUniConvert CGFloat: options[@"videoHeightRate"]];
    //NSString* requestPullUrl = [DCUniConvert NSString: options[@"requestPullUrl"]];//请求拉流
    //NSString* requestStopUrl = [DCUniConvert NSString: options[@"requestStopUrl"]];//停止拉流
    
    CGFloat videoRate = (CGFloat) _videoWidthRate / (CGFloat)_videoHeightRate;
    
    int fixWidth = 0;
    int fixHeight = 0;

    //float widthRate = (int)layoutWidth / (int)videoWidth;
    fixWidth = (int)layoutWidth;
    fixHeight = (int)(fixWidth / videoRate);

    if(fixHeight < layoutHeight)
    {
        fixHeight = (int)layoutHeight;
        
        fixWidth = (int)(fixHeight * videoRate);
    }

    sVideoFixWidth = fixWidth;
    sVideoFixHeight = fixHeight;
    //int leftMargin = fixWidth-layoutWidth > 0 ? (int)-((fixWidth-layoutWidth)/2) : 0;
    //int topMargin = fixHeight-layoutHeight > 0 ? (int)-((fixHeight-layoutHeight)/2) : 0;

    if(self->_rtcView == NULL)
    {
        self->_rtcView = [[WebRtcView alloc] init];
        self->_rtcView = [self->_rtcView initWithFrame:CGRectMake(0, 0, fixWidth, fixHeight)];
        self->_rtcView.videoView.liveEBURL = liveUrl;
        self.liveUrl = liveUrl;
        sLiveUrl = liveUrl;
        self->_rtcView.center = self.view.center;

        self->_rtcView.videoView.delegate = self;
        [self.view addSubview: self->_rtcView];
        [self->_rtcView.videoView setStatState:YES];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"最小化" forState:UIControlStateNormal];
        btn.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width-120, 30, 100, 100);
        [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnaction) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.zPosition = 100;
        [self.view addSubview:btn];
    }

    if (callback) {
         callback(@"OK",NO);

     }
}

-(void)btnaction {
    [self fireEvent:@"onVideoMinimizeClickEvent" params:@{@"detail":@{@"isFullScreen":@(sIsFullScreen),@"liveUrl":sLiveUrl,@"videoFixWidth":@(sVideoFixWidth),@"videoFixHeight":@(sVideoFixHeight)}} domChanges:nil];
//    [self showFloatView];
}

- (void) setVideoSize:(float)width height:(float)height
{
    CGFloat layoutWidth = width;
    CGFloat layoutHeight = height;
    
    CGFloat videoRate = (CGFloat)_videoWidthRate / (CGFloat)_videoHeightRate;
    
    int fixWidth = 0;
    int fixHeight = 0;

    //float widthRate = (int)layoutWidth / (int)videoWidth;
    fixWidth = (int)layoutWidth;
    fixHeight = (int)(fixWidth / videoRate);

    if(fixHeight < layoutHeight)
    {
        fixHeight = (int)layoutHeight;
        fixWidth = (int)(fixHeight * videoRate);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_rtcView changeSize:CGRectMake(0, 0, fixWidth, fixHeight)];
    });
}
#pragma LiveEBVideoViewDelegate
//onEventConnected
//onEventConnectFailed
//onEventFirstFrameRendered
//onEventStatsReport

- (void)videoView:(LiveEBVideoView *)videoView didError:(NSError *)error {
    NSLog(@"didError : %p, %@", videoView, error);
    if (_didErrorEvent) {
        // 向前端发送事件，params 为传给前端的数据 注：数据最外层为 NSDictionary 格式，需要以 "detail" 作为 key 值
        [self fireEvent:@"onEventConnectFailed" params:@{@"detail":@""} domChanges:nil];
    }
}

- (void)showStats:(LiveEBVideoView *)videoView statReport:(LEBStatReport*)statReport{
    //VideoLost 0
    //VideoJitterBuffer 0
    //VideoNack 0
    //FPS 0.000000
    //AudioDelay 0
    //AudioLost 0
    //AudioJitterBuffer 0
    //NSLog(@"LiveEBVideoView : =====>>>>>  %@",statReport);
    //NSLog(@"iiii %f",statReport.fps);
    if (_showStatsEvent) {
        //[self fireEvent:@"showStats" params:@{@"detail":@(statReport.pauseCount)} domChanges:nil];
        [self fireEvent:@"onEventStatsReport" params:@{@"detail":@{@"VideoLost":@(statReport.videoLost),@"VideoJitterBuffer":@(statReport.videoJitterBuffer),@"VideoNack":@(statReport.videoNack),@"FPS":@(statReport.fps),@"AudioDelay":@(statReport.audioDelay),@"AudioLost":@(statReport.audioDelay),@"AudioJitterBuffer":@(statReport.audioJitterBuffer)}} domChanges:nil];
    }
}


- (void)videoView:(LiveEBVideoView *)videoView didChangeVideoSize:(CGSize)size {
    NSLog(@"didChangeVideoSize : %p, %@", videoView, NSStringFromCGSize(size));
    if (_didChangeVideoSizeEvent) {
        [self fireEvent:@"didChangeVideoSize" params:@{@"detail":@{@"width":@(size.width),@"height":@(size.height)}} domChanges:nil];
    }
}

- (void)onPrepared:(LiveEBVideoView*)videoView {
    NSLog(@"onEventConnected : %p", videoView);
    
    if (_onPreparedEvent) {
        [self fireEvent:@"onEventConnected" params:@{@"detail":@""} domChanges:nil];
    }
}


//尽量不要在onCompletion里重试。
- (void)onCompletion:(LiveEBVideoView*)videoView {
    NSLog(@"onCompletion : %p", videoView);
    
    if (_onCompletionEvent) {
        [self fireEvent:@"onEventDisconnect" params:@{@"detail":@""} domChanges:nil];
    }
}

-(void)onFirstFrameRender:(LiveEBVideoView *)videoView {
    NSLog(@"onEventFirstFrameRendered : %p", videoView);
    if (_onFirstFrameRenderEvent) {
        [self fireEvent:@"onEventFirstFrameRendered" params:@{@"detail":@""} domChanges:nil];
    }
}

@end

