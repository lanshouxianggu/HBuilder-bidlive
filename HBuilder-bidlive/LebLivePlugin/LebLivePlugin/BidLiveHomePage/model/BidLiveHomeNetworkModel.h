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

///获取直播播流地址
/**
 params:
 @playType:直播类型 1=直播带货 2=公开课 3=预展
 @domain:推流域名
 @streamName:传值拍场ID, StreamName(自定义的流名称，每路直播流的唯一标识符，推荐用随机数字或数字。)
 @appName:直播的应用名称，默认为 live，可自定义
 @key:鉴权 Key（非必需）
 @secondsTime:过期时间 秒
 */
+(void)getHomePageGetTXTtpPlayUrl:(NSInteger)playType
                           domain:(NSString *)domain
                       streamName:(NSString *)streamName
                          appName:(NSString *)appName
                              key:(NSString *)key
                      secondsTime:(NSInteger)secondsTime
                       completion:(void (^)(NSString * liveUrl))completionBlock;

@end

NS_ASSUME_NONNULL_END
