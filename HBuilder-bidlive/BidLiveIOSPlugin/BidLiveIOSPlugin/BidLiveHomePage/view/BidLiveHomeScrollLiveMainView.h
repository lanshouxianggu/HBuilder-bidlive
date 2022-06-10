//
//  BidLiveHomeScrollLiveMainView.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import <UIKit/UIKit.h>
#import "BidLiveHomeBannerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScrollLiveMainView : UIView
@property (nonatomic, strong) NSArray *firstPartLiveArray;
@property (nonatomic, strong) NSArray *adsArray;
@property (nonatomic, strong) NSArray *secondPartLiveArray;

///海外点击block
@property (nonatomic, copy) void (^abroadClickBlock)(void);
///国内点击block
@property (nonatomic, copy) void (^internalClickBlock)(void);
///gif点击block
@property (nonatomic, copy) void (^gifImageClickBlock)(BidLiveHomeBannerModel *model);

-(void)updateBannerArray:(NSArray <BidLiveHomeBannerModel *> *)bannerArray;

-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
