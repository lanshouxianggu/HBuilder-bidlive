//
//  TxLiveComponent.m
//  LebLivePlugin
//
//  Created by ChenYe on 2021/4/7.
//

#import "TxLiveComponent.h"
#import "DCUniConvert.h"
#import <Foundation/Foundation.h>
#import <TXLiteAVSDK_Smart/TXLiteAVSDK.h>

@interface TxLiveComponent ()

//事件
@property (nonatomic, assign) BOOL onPushEvent;
@property (nonatomic, assign) BOOL onNetStatus;

@end

@implementation TxLiveComponent



-(void)onCreateComponentWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events uniInstance:(DCUniSDKInstance *)uniInstance
{
}

- (UIView *)loadView {
    return [UIView new];
}

- (void)viewDidLoad {

}

/// 前端注册的事件会调用此方法
//onPushEvent
//onNetStatus
/// @param eventName 事件名称
- (void)addEvent:(NSString *)eventName {
    if ([eventName isEqualToString:@"onPushEvent"]) {
        _onPushEvent = YES;
    }
    if ([eventName isEqualToString:@"onNetStatus"]) {
        _onNetStatus = YES;
    }
}

/// 对应的移除事件回调方法
/// @param eventName 事件名称
- (void)removeEvent:(NSString *)eventName {
    if ([eventName isEqualToString:@"onPushEvent"]) {
        _onPushEvent = NO;
    }
    if ([eventName isEqualToString:@"onNetStatus"]) {
        _onNetStatus = NO;
    }
}

// 通过 WX_EXPORT_METHOD 将方法暴露给前端
UNI_EXPORT_METHOD(@selector(setConfig:))
UNI_EXPORT_METHOD(@selector(startCameraPreview))
UNI_EXPORT_METHOD(@selector(stopCameraPreview))
UNI_EXPORT_METHOD(@selector(startPusher:callback:))
UNI_EXPORT_METHOD(@selector(stopPusher))
UNI_EXPORT_METHOD(@selector(switchCamera))
UNI_EXPORT_METHOD(@selector(setVideoQuality:))
UNI_EXPORT_METHOD(@selector(setRenderRotation:))
UNI_EXPORT_METHOD(@selector(setZoom:))
UNI_EXPORT_METHOD(@selector(setMirror:))
UNI_EXPORT_METHOD(@selector(setBeautyFilter:))

- (void)setConfig:(NSDictionary *)options {
    NSLog(@"setConfig");
    //{'width':width, 'height':height, 'liveUrl':url, 'autoPlay':isAutoPlay}
    NSString* licenceURL = [DCUniConvert NSString: options[@"licenceURL"]];
    NSString* licenceKey = [DCUniConvert NSString: options[@"licenceKey"]];
    BOOL enablePureAudioPush = [DCUniConvert BOOL: options[@"enablePureAudioPush"]];
    int homeOrientatio = (int)[DCUniConvert NSInteger: options[@"homeOrientatio"]];
    int videoFPS = (int)[DCUniConvert NSInteger: options[@"videoFPS"]];

    videoFPS = videoFPS == 0 ? 20 : videoFPS;
    
    [TXLiveBase setLicenceURL:licenceURL key:licenceKey];
    
    TXLivePushConfig *_config = [[TXLivePushConfig alloc] init];  // 一般情况下不需要修改默认 config
    _config.homeOrientation = homeOrientatio;
    _config.enablePureAudioPush = enablePureAudioPush;
    _config.videoFPS = videoFPS;
    _pusher = [[TXLivePush alloc] initWithConfig: _config]; // config 参数不能为空
    
    BOOL adjustBitrate = [DCUniConvert BOOL: options[@"adjustBitrate"]];
    NSInteger quality = [DCUniConvert NSInteger: options[@"quality"]];
    quality = quality == 0 ? 1 : quality;

    [_pusher setVideoQuality:quality adjustBitrate:adjustBitrate adjustResolution:NO];
        
    _pusher.delegate = self;
    
}

- (void) startCameraPreview {
    //创建一个 view 对象，并将其嵌入到当前界面中
    UIView *_localView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:_localView atIndex:0];
    _localView.center = self.view.center;
     //启动本地摄像头预览
    [_pusher startPreview:_localView];
}
- (void) stopCameraPreview {
    [_pusher stopPreview];
}
- (void) startPusher:(NSString *)url callback:(UniModuleKeepAliveCallback)callback {
    int ret = [_pusher startPush:url];
    
    // 回调方法，传递参数给 js 端 注：只支持返回 String 或 NSDictionary (map) 类型
    if (callback) {
        callback([NSString stringWithFormat:@"%d",ret],NO);
    }
    NSLog(@"startPusherRet%d",ret);
}
- (void) stopPusher {
    [_pusher stopPush];
}
- (void) switchCamera {
    [_pusher switchCamera];
}
- (void) setVideoQuality:(NSDictionary *)options {
    BOOL adjustBitrate = [DCUniConvert BOOL: options[@"adjustBitrate"]];
    NSInteger quality = [DCUniConvert NSInteger: options[@"quality"]];
    
    [_pusher setVideoQuality:quality adjustBitrate:adjustBitrate adjustResolution:NO];
}
- (void) setRenderRotation:(NSDictionary *)options {
    int value = (int)[DCUniConvert NSInteger: options[@"value"]];
    [_pusher setRenderRotation:value];
}
- (void) setZoom:(NSDictionary *)options {
    NSInteger value = [DCUniConvert NSInteger: options[@"value"]];
    [_pusher setZoom:value];
}
- (void) setMirror:(NSDictionary *)options {
    BOOL value = [DCUniConvert BOOL: options[@"value"]];
    [_pusher setMirror:value];
}
- (void) setBeautyFilter:(NSDictionary *)options {
    //int style = (int)[DCUniConvert NSInteger: options[@"style"]];
    //CGFloat beautyLevel = [DCUniConvert CGFloat: options[@"beautyLevel"]];
    //CGFloat whiteningLevel = [DCUniConvert CGFloat: options[@"whiteningLevel"]];
    //CGFloat ruddyLevel = [DCUniConvert CGFloat: options[@"ruddyLevel"]];
    //[_pusher setBeautyStyle:style beautyLevel:beautyLevel whitenessLevel:whiteningLevel ruddinessLevel:ruddyLevel];
}

- (void)onPushEvent:(int)EvtID withParam:(NSDictionary *)param {
    NSLog(@"onPushEvent : %d", EvtID);
    if (_onPushEvent) {
        NSString* event = [NSString stringWithFormat:@"%d",EvtID];
        //[self fireEvent:@"onPushEvent" params:@{@"detail":@{@"event":event}} domChanges:nil];
    }
}

- (void)onNetStatus:(NSDictionary *)param {
//    {
//       "AUDIO_BITRATE" = 62;
//       "AUDIO_CACHE" = 6;
//       "AUDIO_DROP" = 0;
//       "AUDIO_INFO" = "1|48000,1";
//       "CPU_USAGE" = "0.144";
//       "CPU_USAGE_DEVICE" = "0.5213032";
//       "NET_SPEED" = 897;
//       "SERVER_IP" = "157.255.14.63:9900";
//       "STREAM_ID" = "rtmp://135114.livepush.myqcloud.com/live/a01?txSecret=a4e6826251bb05669479858852e6b5d1&txTime=60B49CA1";
//       "VIDEO_BITRATE" = 825;
//       "VIDEO_CACHE" = 0;
//       "VIDEO_DROP" = 0;
//       "VIDEO_FPS" = "19.71066460247318";
//       "VIDEO_GOP" = "3.044037388392857";
//       "VIDEO_HEIGHT" = 368;
//       "VIDEO_WIDTH" = 640;
//   }
    
    NSString* videoWidth = [DCUniConvert NSString: param[@"VIDEO_WIDTH"]];
    NSString* videoHeight = [DCUniConvert NSString: param[@"VIDEO_HEIGHT"]];
    NSString* cpu = [DCUniConvert NSString: param[@"CPU_USAGE"]];
    NSString* res = [NSString stringWithFormat:@"%@*%@",videoWidth, videoHeight];
    NSString* spd = [NSString stringWithFormat:@"%@Kbps",[DCUniConvert NSString: param[@"NET_SPEED"]]];
    NSString* fps = [DCUniConvert NSString: param[@"VIDEO_FPS"]];
    NSString* ara = [NSString stringWithFormat:@"%@Kbps",[DCUniConvert NSString: param[@"AUDIO_BITRATE"]]];
    NSString* vra = [NSString stringWithFormat:@"%@Kbps",[DCUniConvert NSString: param[@"VIDEO_BITRATE"]]];

    if (_onNetStatus) {
        NSDictionary *detail = [NSDictionary dictionaryWithObjectsAndKeys:
                              cpu, @"CPU",
                              res, @"RES",
                              spd, @"SPD",
                              fps, @"FPS",
                              ara,  @"ARA",
                              vra,  @"VRA",
                              nil];
        
        [self fireEvent:@"onNetStatus" params:@{@"detail":detail} domChanges:nil];

        //NSDictionary* params = new
    }
}
/**
 * 当屏幕分享开始时，SDK 会通过此回调通知
 */
- (void)onScreenCaptureStarted
{
    
}

/**
 * 当屏幕分享暂停时，SDK 会通过此回调通知
 *
 * @param reason 原因，0：用户主动暂停；1：屏幕窗口不可见暂停
 */
- (void)onScreenCapturePaused:(int)reason
{
    
}

/**
 * 当屏幕分享恢复时，SDK 会通过此回调通知
 *
 * @param reason 恢复原因，0：用户主动恢复；1：屏幕窗口恢复可见从而恢复分享
 */
- (void)onScreenCaptureResumed:(int)reason
{
    
}

/**
 * 当屏幕分享停止时，SDK 会通过此回调通知
 *
 * @param reason 停止原因，0：用户主动停止；1：屏幕窗口关闭导致停止
 */
- (void)onScreenCaptureStoped:(int)reason
{
    
}

#pragma method

- (CGFloat) rpxTo:(CGFloat) value{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat rate = screenRect.size.width / 750;
    CGFloat result = value * rate;
    return result;
}

@end

