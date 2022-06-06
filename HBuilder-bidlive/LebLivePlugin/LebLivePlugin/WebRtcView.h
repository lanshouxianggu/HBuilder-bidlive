//
//  WebRtcView.h
//  WRTCDemo
//
//  Created by AlexiChen on 2020/6/30.
//  Copyright © 2020 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveEB_IOS/LiveEBVideoView.h>

@interface WebRtcView : UIView

@property (nonatomic, strong) LiveEBVideoView *videoView;

- (void)changeSize:(CGRect)frame;

@end
