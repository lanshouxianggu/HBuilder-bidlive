//
//  BidLiveHomeViewController.h
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BidLiveHomeBannerModel;
@class BidLiveHomeCMSArticleModel;
@class BidLiveHomeGlobalLiveModel;
@class BidLiveHomeHotCourseListModel;
@class BidLiveHomeHighlightLotsListModel;
@class BidLiveHomeGuessYouLikeListModel;
@class BidLiveHomeAnchorListModel;
@class BidLiveHomeVideoGuaideListModel;
@interface BidLiveHomeViewController : UIViewController
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
///视频导览cell点击block
@property (nonatomic, copy) void (^videoGuaideCellClickBlock)(BidLiveHomeVideoGuaideListModel *model);
///全球直播cell点击block
@property (nonatomic, copy) void (^globalLiveCellClickBlock)(BidLiveHomeGlobalLiveModel *model);
///全球直播海外点击block
@property (nonatomic, copy) void (^abroadClickBlock)(void);
///全球直播国内点击block
@property (nonatomic, copy) void (^internalClickBlock)(void);
///精选主播cell点击block
@property (nonatomic, copy) void (^anchorCellClickBlock)(BidLiveHomeAnchorListModel *model);
///精选主播箭头点击block
@property (nonatomic, copy) void (^anchorViewArrowClickBlock)(void);
///名家讲堂顶部更多箭头点击block
@property (nonatomic, copy) void (^speechTopMoreClickBlock)(void);
///名家讲堂cell点击block
@property (nonatomic, copy) void (^speechCellClickBlock)(BidLiveHomeHotCourseListModel *model);
///焦点拍品cell点击block
@property (nonatomic, copy) void (^highlightLotsCellClickBlock)(BidLiveHomeHighlightLotsListModel *model);
///猜你喜欢cell点击block
@property (nonatomic, copy) void (^guessYouLikeCellClickBlock)(BidLiveHomeGuessYouLikeListModel *model);
///猜你喜欢banner点击block
@property (nonatomic, copy) void (^guessYouLikeBannerClickBlock)(BidLiveHomeBannerModel *model);
///新上拍场点击block
@property (nonatomic, copy) void (^toNewAuctionClickBlock)(void);

///停止视频导览/精选主播上播放的视频
-(void)stopPlayVideo;
@end

NS_ASSUME_NONNULL_END
