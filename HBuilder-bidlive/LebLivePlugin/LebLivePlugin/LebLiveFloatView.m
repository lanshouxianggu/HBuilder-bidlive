//
//  LebLiveFloatView.m
//  DCTestUniPlugin
//
//  Created by bidlive on 2022/5/24.
//  Copyright © 2022 DCloud. All rights reserved.
//

#import "LebLiveFloatView.h"
#import "WebRtcView.h"
#import <LiveEB_IOS/LiveEBManager.h>

#define kIsLiuHaiPing UIApplication.sharedApplication.statusBarFrame.size.height>20

@interface LebLiveFloatView ()
@property (nonatomic, strong) WebRtcView *rtcView;
@end

@implementation LebLiveFloatView

-(instancetype)initWithFrame:(CGRect)frame liveUrl:(NSString *)liveUrl isFullScreen:(BOOL)isFullScreen fixWidth:(CGFloat)fixWidth fixHeight:(CGFloat)fixHeight {
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0.1;
        self.backgroundColor = UIColor.blackColor;
        CGRect floatRect = isFullScreen?CGRectMake(0, 0, 200, 120):CGRectMake(0, 0, 120, 160);
        if (isFullScreen) {
            floatRect = CGRectMake(0, 0, 200, 120);
        }else {
            CGFloat height = fixHeight*120/fixWidth;
            CGFloat offsetY = frame.size.height/2-height*0.85;
            floatRect = CGRectMake(0, offsetY, 120, height);
        }
        WebRtcView *rtcView = [[WebRtcView alloc] initWithFrame:floatRect];
        rtcView.videoView.liveEBURL = liveUrl;
//        rtcView.center = self.center;
        self.rtcView = rtcView;
//        rtcView.videoView.delegate = self;
        [self addSubview: rtcView];
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"BidLiveIOSPlugin" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *imagePath = [bundle pathForResource:@"ic_close" ofType:@"png"];
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        UIImage *image = [UIImage imageWithData:imageData];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImage:image forState:UIControlStateNormal];
        closeBtn.frame = CGRectMake(frame.size.width-29, 4, 24, 24);
        [self addSubview:closeBtn];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction)];
        [self addGestureRecognizer:ges];
    }
    return self;
}

-(void)tapGesAction {
    !self.floatViewTapBlock?:self.floatViewTapBlock();
    [self.rtcView.videoView stop];
    [[LiveEBManager sharedManager] finitSDK];
    [self removeFromSuperview];
}

-(void)show {
    self.alpha = 1;
    //添加滑动手势事件
    UIPanGestureRecognizer *panges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:panges];
}

-(void)closeAction {
    if (self.floatViewDismissBlock) {
        self.floatViewDismissBlock();
    }
    [self.rtcView.videoView stop];
    [[LiveEBManager sharedManager] finitSDK];
    [self removeFromSuperview];
}

#pragma mark - 播放流
-(void)startPlay {
    [self.rtcView.videoView setStatState:YES];
    [self.rtcView.videoView start];
}

#pragma mark - 结束播放
-(void)endPlay {
    [self.rtcView.videoView stop];
}

#pragma mark - 滑动手势
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"FlyElephant---视图拖动开始");
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [recognizer locationInView:self];
        
        if (location.y < 0 || location.y > self.bounds.size.height) {
            return;
        }
        CGPoint translation = [recognizer translationInView:self];
        
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);
        [recognizer setTranslation:CGPointZero inView:self];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"FlyElephant---视图拖动结束 %.2f,%.2f",self.frame.origin.x,self.frame.origin.y);
        CGRect rect = self.frame;
        CGFloat offset = UIApplication.sharedApplication.statusBarFrame.size.height;
        if (CGRectGetMinX(self.frame)<10) {
            rect.origin.x = 10;
        }
        if (CGRectGetMinY(self.frame)<offset) {
            rect.origin.y = offset;
        }
        if (CGRectGetMaxX(self.frame)>[UIScreen mainScreen].bounds.size.width-10) {
            rect.origin.x = [UIScreen mainScreen].bounds.size.width-rect.size.width-10;
        }
        if (CGRectGetMaxY(self.frame)>[UIScreen mainScreen].bounds.size.height-10) {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height-rect.size.height-10;
        }
        [UIView animateWithDuration:0.35 animations:^{
            self.frame = rect;
        }];
    }
}

@end
