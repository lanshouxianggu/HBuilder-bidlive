//
//  TestComponent.h
//  DCTestUniPlugin
//
//  Created by XHY on 2020/4/23.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "DCUniComponent.h"
#import <LiveEB_IOS/LiveEBVideoView.h>
#import "WebRtcView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LebLiveComponent : DCUniComponent<LiveEBVideoViewDelegate>
@property (nonatomic, strong) WebRtcView *rtcView;
@property CGFloat videoWidthRate;
@property CGFloat videoHeightRate;

@end

NS_ASSUME_NONNULL_END
