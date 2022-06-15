//
//  BidLiveTopBannerView.h
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import <UIKit/UIKit.h>
#import "BidLiveHomeBannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveTopBannerView : UIView
@property (nonatomic, copy) void (^bannerClick)(BidLiveHomeBannerModel *model);
-(instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)array;
-(void)updateBannerArray:(NSArray <BidLiveHomeBannerModel *> *)bannerArray;

-(void)destroyTimer;
-(void)resumeTimer;
@end

NS_ASSUME_NONNULL_END
