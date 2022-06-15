//
//  BidLiveHomeNetworkModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/6.
//

#import <Foundation/Foundation.h>
#import "BidLiveHomeBannerModel.h"
#import "BidLiveHomeCMSArticleModel.h"
#import "BidLiveHomeGlobalLiveModel.h"
#import "BidLiveHomeHotCourseModel.h"
#import "BidLiveHomeVideoGuaideModel.h"
#import "BidLiveHomeAnchorModel.h"
#import "BidLiveHomeGuessYouLikeModel.h"
#import "BidLiveHomeHighlightLotsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeNetworkModel : NSObject

///获取首页顶部banner列表
+(void)getHomePageBannerList:(NSInteger)bannerId
                      client:(NSString *)client
                  completion:(void (^)(NSArray<BidLiveHomeBannerModel *> *bannerList))completionBlock;

///获取首页动态列表
+(void)getHomePageArticleList:(int)pageIndex
                     pageSize:(int)pageSize
                   completion:(void (^)(NSArray<BidLiveHomeCMSArticleModel *> *cmsArticleList))completionBlock;

///获取首页全球直播列表
+(void)getHomePageGlobalLiveList:(NSString *)source
                      completion:(void (^)(NSArray <BidLiveHomeGlobalLiveModel *> *liveList))completionBlock;

///获取首页名家讲堂列表
+(void)getHomePageHotCourse:(int)pageIndex
                   pageSize:(int)pageSize
                  pageCount:(int)pageCount
                 completion:(void (^)(BidLiveHomeHotCourseModel * courseModel))completionBlock;

///获取首页视频导览列表
+(void)getHomePageVideoGuaideList:(int)pageIndex
                         pageSize:(int)pageSize
                         isNoMore:(bool)isNoMore
                           isLoad:(bool)isLoad
                       scrollLeft:(NSString *)scrollLeft
                       completion:(void (^)(BidLiveHomeVideoGuaideModel * courseModel))completionBlock;

///获取首页精选主播列表
+(void)getHomePageAnchorList:(int)pageIndex
                    pageSize:(int)pageSize
                   pageCount:(int)pageCount
         isContainBeforePage:(bool)isContainBeforePage
                  completion:(void (^)(BidLiveHomeAnchorModel *model))completionBlock;

///获取首页猜你喜欢列表
+(void)getHomePageGuessYouLikeList:(int)pageIndex
                        completion:(void (^)(BidLiveHomeGuessYouLikeModel *model))completionBlock;

///获取首页焦点拍品列表
+(void)getHomePageHighlightLotsList:(int)pageIndex
                         pageSize:(int)pageSize
                         isNoMore:(bool)isNoMore
                           isLoad:(bool)isLoad
                       scrollLeft:(NSString *)scrollLeft
                       completion:(void (^)(BidLiveHomeHighlightLotsModel * courseModel))completionBlock;

///获取直播状态
+(void)getHomePageGetLiveRoomStatus:(NSString *)liveRoomId completion:(void (^)(NSInteger liveStatus))completionBlock;

@end

NS_ASSUME_NONNULL_END
