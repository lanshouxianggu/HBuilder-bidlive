//
//  BidLiveHomeNetworkModel.m
//  OCTools
//
//  Created by bidlive on 2022/6/6.
//

#import "BidLiveHomeNetworkModel.h"
#import "BidLiveInterfaceEnum.h"
#import "MJExtension.h"
#import "HJNetwork.h"
#import "LCConfig.h"

@implementation BidLiveHomeNetworkModel

+(void)getHomePageBannerList:(NSInteger)bannerId client:(NSString *)client completion:(nonnull void (^)(NSArray<BidLiveHomeBannerModel *> * _Nonnull))completionBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppWebApiAddress,kGetBannerList];
    NSDictionary *params = @{@"id":@(bannerId),@"client":client};
    
    [HJNetwork POSTWithURL:url parameters:params cachePolicy:HJCachePolicyNetworkElseCache callback:^(id responseObject, BOOL isCache, NSError *error) {
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            if ([responseObject[@"success"] boolValue]) {
                NSArray *list = [BidLiveHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
                !completionBlock?:completionBlock(list);
            }
        }else {
            !completionBlock?:completionBlock(@[]);
        }
    }];
}


+(void)getHomePageArticleList:(int)pageIndex pageSize:(int)pageSize completion:(nonnull void (^)(NSArray<BidLiveHomeCMSArticleModel *> * _Nonnull))completionBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@?pageIndex=%d&pageSize=%d",kAppEnApiAddress,kGetCMSArticleList,pageIndex,pageSize];
    
    [HJNetwork POSTWithURL:url parameters:nil cachePolicy:HJCachePolicyNetworkElseCache callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock(@[]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                NSArray *list = [BidLiveHomeCMSArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"List"]];
                !completionBlock?:completionBlock(list);
            }else{
                !completionBlock?:completionBlock(@[]);
            }
        }
    }];
}

+(void)getHomePageGlobalLiveList:(NSString *)source completion:(void (^)(NSArray<BidLiveHomeGlobalLiveModel *> * _Nonnull))completionBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppWebApiAddress,kGetListForIndex];
    NSDictionary *params = @{@"source":source};
    
    [HJNetwork POSTWithURL:url parameters:params cachePolicy:HJCachePolicyNetworkElseCache callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock(@[]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                NSArray *list = [BidLiveHomeGlobalLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
                !completionBlock?:completionBlock(list);
            }else{
                !completionBlock?:completionBlock(@[]);
            }
        }
    }];
}

+(void)getHomePageHotCourse:(int)pageIndex pageSize:(int)pageSize pageCount:(int)pageCount completion:(nonnull void (^)(BidLiveHomeHotCourseModel * _Nonnull))completionBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppNewttpApiAddress,kGetHomeHotCourse];
    NSDictionary *params = @{@"pageIndex":@(pageIndex),
                             @"pageSize":@(pageSize),
                             @"pageCount":@(pageCount)
    };
    
    [HJNetwork POSTWithURL:url parameters:params cachePolicy:HJCachePolicyNetworkElseCache callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock([BidLiveHomeHotCourseModel new]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                if ([responseObject[@"result"] isKindOfClass:NSDictionary.class]) {
                    BidLiveHomeHotCourseModel *model = [BidLiveHomeHotCourseModel mj_objectWithKeyValues:responseObject[@"result"]];
                    !completionBlock?:completionBlock(model);
                }
            }else{
                !completionBlock?:completionBlock([BidLiveHomeHotCourseModel new]);
            }
        }
    }];
}

+(void)getHomePageVideoGuaideList:(int)pageIndex
                         pageSize:(int)pageSize
                         isNoMore:(bool)isNoMore
                           isLoad:(bool)isLoad
                       scrollLeft:(NSString *)scrollLeft
                       completion:(void (^)(BidLiveHomeVideoGuaideModel * _Nonnull))completionBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppWebApiAddress,kGetLiveRoomPromotionList];
    NSDictionary *params = @{@"pageIndex":@(pageIndex),
                             @"pageSize":@(pageSize),
                             @"isNoMore":@(isNoMore),
                             @"isLoad":@(isLoad),
                             @"scrollLeft":scrollLeft
    };
    
    [HJNetwork POSTWithURL:url parameters:params cachePolicy:HJCachePolicyNetworkElseCache callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock([BidLiveHomeVideoGuaideModel new]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                if ([responseObject[@"result"] isKindOfClass:NSDictionary.class]) {
                    BidLiveHomeVideoGuaideModel *model = [BidLiveHomeVideoGuaideModel mj_objectWithKeyValues:responseObject[@"result"]];
                    !completionBlock?:completionBlock(model);
                }
            }else{
                !completionBlock?:completionBlock([BidLiveHomeVideoGuaideModel new]);
            }
        }
    }];
}

+(void)getHomePageAnchorList:(int)pageIndex
                    pageSize:(int)pageSize
                   pageCount:(int)pageCount
         isContainBeforePage:(bool)isContainBeforePage
                  completion:(void (^)(BidLiveHomeAnchorModel * _Nonnull))completionBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppNewttpApiAddress,kGetHomeHotLiveV2];
    NSDictionary *params = @{@"pageIndex":@(pageIndex),
                             @"pageSize":@(pageSize),
                             @"pageCount":@(pageCount),
                             @"isContainBeforePage":@(isContainBeforePage)
    };
    
    [HJNetwork POSTWithURL:url parameters:params cachePolicy:HJCachePolicyNetworkElseCache callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock([BidLiveHomeAnchorModel new]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                if ([responseObject[@"result"] isKindOfClass:NSDictionary.class]) {
                    BidLiveHomeAnchorModel *model = [BidLiveHomeAnchorModel mj_objectWithKeyValues:responseObject[@"result"]];
                    !completionBlock?:completionBlock(model);
                }
            }else{
                !completionBlock?:completionBlock([BidLiveHomeAnchorModel new]);
            }
        }
    }];
}

+(void)getHomePageGuessYouLikeList:(int)pageIndex
                        completion:(void (^)(BidLiveHomeGuessYouLikeModel * _Nonnull))completionBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppWebApiAddress,kGetGuangGuangPagedList];
    NSDictionary *params = @{@"pageIndex":@(pageIndex)};
    
    [HJNetwork POSTWithURL:url parameters:params cachePolicy:HJCachePolicyNetworkElseCache callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock([BidLiveHomeGuessYouLikeModel new]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                if ([responseObject[@"result"] isKindOfClass:NSDictionary.class]) {
                    BidLiveHomeGuessYouLikeModel *model = [BidLiveHomeGuessYouLikeModel mj_objectWithKeyValues:responseObject[@"result"]];
                    !completionBlock?:completionBlock(model);
                }
            }else{
                !completionBlock?:completionBlock([BidLiveHomeGuessYouLikeModel new]);
            }
        }
    }];
}

+(void)getHomePageHighlightLotsList:(int)pageIndex
                           pageSize:(int)pageSize
                           isNoMore:(bool)isNoMore
                             isLoad:(bool)isLoad
                         scrollLeft:(NSString *)scrollLeft
                         completion:(void (^)(BidLiveHomeHighlightLotsModel * _Nonnull))completionBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppWebApiAddress,kGetAuctionPromotionItems];
    NSDictionary *params = @{@"pageIndex":@(pageIndex),
                             @"pageSize":@(pageSize),
                             @"isNoMore":@(isNoMore),
                             @"isLoad":@(isLoad),
                             @"scrollLeft":scrollLeft
    };
    
    [HJNetwork POSTWithURL:url parameters:params cachePolicy:HJCachePolicyNetworkElseCache callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock([BidLiveHomeHighlightLotsModel new]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                if ([responseObject[@"result"] isKindOfClass:NSDictionary.class]) {
                    BidLiveHomeHighlightLotsModel *model = [BidLiveHomeHighlightLotsModel mj_objectWithKeyValues:responseObject[@"result"]];
                    !completionBlock?:completionBlock(model);
                }
            }else{
                !completionBlock?:completionBlock([BidLiveHomeHighlightLotsModel new]);
            }
        }
    }];
}

+(void)getHomePageGetLiveRoomStatus:(NSString *)liveRoomId completion:(void (^)(NSInteger))completionBlock
{
    NSString *url = @""[kAppNewttpApiAddress][kGetLiveRoomStatus];
    NSDictionary *params = @{@"liveRoomId":@""[liveRoomId]};
    
    [HJNetwork POSTWithURL:url parameters:params callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock(-1);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                if ([responseObject[@"result"] isKindOfClass:NSDictionary.class]) {
                    NSDictionary *dataDic = responseObject[@"result"];
                    NSInteger status = [dataDic[@"liveStatus"] integerValue];
                    !completionBlock?:completionBlock(status);
                }else{
                    !completionBlock?:completionBlock(-1);
                }
            }
        }
    }];
}

+(void)getHomePageGetTXTtpPlayUrl:(NSInteger)playType
                           domain:(NSString *)domain
                       streamName:(NSString *)streamName
                          appName:(NSString *)appName
                              key:(NSString *)key
                      secondsTime:(NSInteger)secondsTime
                       completion:(void (^)(NSString * _Nonnull))completionBlock
{
    NSString *url = @""[kAppWebApiAddress][kGetTXTtpPlayUrl];
    NSDictionary *params = @{@"playType":@(playType),
                             @"domain":@""[domain],
                             @"streamName":@""[streamName],
                             @"appName":@""[appName],
                             @"key":@""[key],
                             @"secondsTime":@(secondsTime)
    };
    
    [HJNetwork POSTWithURL:url parameters:params callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock(@"");
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                if ([responseObject[@"result"] isKindOfClass:NSDictionary.class]) {
                    NSDictionary *dataDic = responseObject[@"result"];
                    NSString *url = @""[dataDic[@"message"]];
                    !completionBlock?:completionBlock(url);
                }else{
                    !completionBlock?:completionBlock(@"");
                }
            }
        }
    }];
}

@end
