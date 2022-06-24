//
//  BidLiveHomeTopView.h
//  LebLivePlugin
//
//  Created by bidlive on 2022/6/24.
//

#import <UIKit/UIKit.h>
#import "LCConfig.h"

#import "BidLiveHomeScrollTopMainView.h"
#import "BidLiveHomeScrollLiveMainView.h"
#import "BidLiveHomeScrollSpeechMainView.h"
#import "BidLiveHomeScrollAnchorMainView.h"
#import "BidLiveHomeScrollHighlightLotsView.h"

#import "BidLiveHomeNetworkModel.h"
#import "BidLiveHomeVideoGuaideModel.h"
NS_ASSUME_NONNULL_BEGIN

@class BidLiveHomeBannerModel;
@interface BidLiveHomeTopView : UIView
///topView，包括图片广告轮播，按钮模块，文字滚动，直播页
@property (nonatomic, strong) BidLiveHomeScrollTopMainView *topMainView;
///直播专场
@property (nonatomic, strong) BidLiveHomeScrollLiveMainView *liveMainView;
///精选主播
@property (nonatomic, strong) BidLiveHomeScrollAnchorMainView *anchorMainView;
///联拍讲堂
@property (nonatomic, strong) BidLiveHomeScrollSpeechMainView *speechMainView;
///焦点拍品
@property (nonatomic, strong) BidLiveHomeScrollHighlightLotsView *highlightLotsMainView;
///猜你喜欢
@property (nonatomic, strong) UIView *youlikeHeadTitleView;

///上一次讲堂视频的数量
@property (nonatomic, assign) NSInteger lastVideosCount;
///名家讲堂当前页码
@property (nonatomic, assign) int speechPageIndex;
///第一页名家讲堂列表数据
@property (nonatomic, strong) NSArray *speechOrigionArray;

///上一次精选主播的数量
@property (nonatomic, assign) NSInteger lastAnchorsCount;
///精选主播当前页码
@property (nonatomic, assign) int anchorPageIndex;
///第一页精选主播列表数据
@property (nonatomic, strong) NSArray *anchorOrigionArray;

///焦点拍品当前页码
@property (nonatomic, assign) int highlightLotsPageIndex;
///焦点拍品列表
@property (nonatomic, strong) NSMutableArray *hightlightLotsList;

@property (nonatomic, copy) void (^topBannerClickBlock)(BidLiveHomeBannerModel *model);
@property (nonatomic, copy) void (^highlightLotsViewScrollToRightBlock)(void);
@end

NS_ASSUME_NONNULL_END
