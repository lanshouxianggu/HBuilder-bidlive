//
//  BidLiveHomeScrollLiveMainView.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScrollLiveMainView : UIView
@property (nonatomic, strong) NSArray *firstPartLiveArray;
@property (nonatomic, strong) NSArray *adsArray;
@property (nonatomic, strong) NSArray *secondPartLiveArray;

@property (nonatomic, copy) void (^abroadClickBlock)(void);
@property (nonatomic, copy) void (^internalClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
