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

@implementation BidLiveHomeNetworkModel

+(void)getHomePageBannerList:(NSInteger)bannerId client:(NSString *)client completion:(nonnull void (^)(NSArray<BidLiveHomeBannerModel *> * _Nonnull))completionBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppUrlAddress,kBidLiveHomeGetBannerList];
    NSDictionary *params = @{@"id":@(bannerId),@"client":client};
    
    [HJNetwork POSTWithURL:url parameters:params callback:^(id responseObject, BOOL isCache, NSError *error) {
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

@end
