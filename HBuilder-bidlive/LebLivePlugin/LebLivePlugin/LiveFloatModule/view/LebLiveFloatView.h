//
//  LebLiveFloatView.h
//  DCTestUniPlugin
//
//  Created by bidlive on 2022/5/24.
//  Copyright © 2022 DCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LebLiveFloatView : UIView
@property (nonatomic, copy) void (^floatViewDismissBlock)(void);
@property (nonatomic, copy) void (^floatViewTapBlock)(void);
-(instancetype)initWithFrame:(CGRect)frame
                     liveUrl:(NSString *)liveUrl
                isFullScreen:(BOOL)isFullScreen
                    fixWidth:(CGFloat)fixWidth
                   fixHeight:(CGFloat)fixHeight;
-(void)show;
-(void)startPlay;
-(void)endPlay;
-(void)closeAction;
@end

NS_ASSUME_NONNULL_END
