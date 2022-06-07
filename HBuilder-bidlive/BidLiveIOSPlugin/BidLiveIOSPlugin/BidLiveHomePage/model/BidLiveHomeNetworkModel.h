//
//  BidLiveHomeNetworkModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/6.
//

#import <Foundation/Foundation.h>
#import "BidLiveHomeBannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeNetworkModel : NSObject

+(void)getHomePageBannerList:(NSInteger)bannerId client:(NSString *)client completion:(void (^)(NSArray<BidLiveHomeBannerModel *> *bannerList))completionBlock;

@end

NS_ASSUME_NONNULL_END
