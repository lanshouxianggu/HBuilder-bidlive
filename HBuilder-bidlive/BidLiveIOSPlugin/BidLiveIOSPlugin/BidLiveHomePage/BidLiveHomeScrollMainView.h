//
//  BidLiveHomeScrollMainView.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BidLiveHomeBannerModel;
@class BidLiveHomeCMSArticleModel;
@class BidLiveHomeGlobalLiveModel;
@interface BidLiveHomeScrollMainView : UIView
///搜索block
@property (nonatomic, copy) void (^searchClickBlock)(void);
///全球拍卖block
@property (nonatomic, copy) void (^globalSaleClickBlock)(void);
///国内拍卖block
@property (nonatomic, copy) void (^countrySaleClickBlock)(void);
///讲堂block
@property (nonatomic, copy) void (^speechClassClickBlock)(void);
///鉴定block
@property (nonatomic, copy) void (^appraisalClickBlock)(void);
///送拍block
@property (nonatomic, copy) void (^sendClickBlock)(void);
///资讯block
@property (nonatomic, copy) void (^informationClickBlock)(void);
///直播间block
@property (nonatomic, copy) void (^liveRoomClickBlock)(void);
///广告点击block
@property (nonatomic, copy) void (^bannerClick)(BidLiveHomeBannerModel *model);
///动态点击block
@property (nonatomic, copy) void (^cmsArticleClickBlock)(BidLiveHomeCMSArticleModel *model);
///全球直播cell点击block
@property (nonatomic, copy) void (^globalLiveCellClickBlock)(BidLiveHomeGlobalLiveModel *model);

///新上拍场点击block
@property (nonatomic, copy) void (^toNewAuctionClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
