//
//  WebRtcView.m
//  WRTCDemo
//
//  Created by AlexiChen on 2020/6/30.
//  Copyright © 2020 AlexiChen. All rights reserved.
//

#import "WebRtcView.h"



@implementation WebRtcView

- (void)dealloc
{
    NSLog(@"%p | %p release", self, _videoView);
}

//- (BOOL)startWebRtc:(NSString *)qurl{
//    BOOL playwrtc = NO;
//    if ([qurl.lowercaseString hasPrefix:@"webrtc://"]) {
//        _videoView.liveEBURL = qurl;
//        [_videoView start];
//        [_videoView setStatState:YES];
//        playwrtc = YES;
//    }
//
//    return playwrtc;
//}
//
//- (BOOL)stopWebRtc {
//    [_videoView stop];
//    return YES;
//}

- (void)changeSize:(CGRect)frame {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->_videoView.frame = frame;
        self.frame = frame;
        
        [self setNeedsLayout];
        
    });
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _videoView = [[LiveEBVideoView alloc] init];
        _videoView.frame = frame;
        //_videoView.backgroundColor = [UIColor colorWithRed:(arc4random()%50 + 50)/100.0 green:(arc4random()%50 + 50)/100.0 blue:(arc4random()%50 + 50)/100.0 alpha:1];
       [self addSubview:_videoView];
        
        self.frame = frame;
    }
    return self;
}


- (instancetype)initWith:(NSString *)qurl {
    if (self = [self initWithFrame:CGRectMake(0, 0, 750, 460)]) {
        _videoView.liveEBURL = qurl;
        _videoView.rtcHost = @"https://webrtc.liveplay.myqcloud.com";
    }
    return self;
}



@end
