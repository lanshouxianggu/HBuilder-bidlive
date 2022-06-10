//
//  BidliveInterfaceEnum.h
//  OCTools
//
//  Created by bidlive on 2022/6/6.
//

#ifndef BidliveInterfaceEnum_h
#define BidliveInterfaceEnum_h


/*************************************************************************************/
static NSString *const kAppWebApiAddress = @"http://webapi.51bidlive.com";

///是否登录
static NSString *const kCheckIsLoginedV2 = @"/api/services/app/Member/CheckIsLoginedV2";

///首页顶部banner
static NSString *const kGetBannerList = @"/api/services/app/Setting/GetBannerList";
///首页视频导览
static NSString *const kGetLiveRoomPromotionList = @"/api/services/app/AuctionPromotion/GetLiveRoomPromotionList";

///全球直播列表
static NSString *const kGetListForIndex = @"/api/services/app/AuctionQuery/GetListForIndex";
///焦点拍品
static NSString *const kGetAuctionPromotionItems = @"/api/services/app/AuctionPromotion/GetAuctionPromotionItems";
///猜你喜欢
static NSString *const kGetGuangGuangPagedList = @"/api/services/app/AuctionItemQuery/GetGuangGuangPagedList";

/*************************************************************************************/
static NSString *const kAppNewttpApiAddress = @"http://newttp_api.51bidlive.com";

///精选主播
static NSString *const kGetHomeHotLiveV2 = @"/api/services/app/Home/GetHomeHotLiveV2";
///名家讲堂
static NSString *const kGetHomeHotCourse = @"/api/services/app/Home/GetHomeHotCourse";

/*************************************************************************************/
static NSString *const kAppEnApiAddress = @"http://en.m.51bidlive.com";

///动态
static NSString *const kGetCMSArticleList = @"/MessageAll/GetCMSArticleList";

static NSString *const kCMSNewsDetails = @"/MessageAll/CMSNewsDetails";

#endif /* BidliveInterfaceEnum_h */
