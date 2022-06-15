//
//  BidLiveHomeGlobalLiveModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeGlobalLiveModel : NSObject
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger SellerId;
@property (nonatomic, assign) NSInteger AuctionItemCount;
@property (nonatomic, assign) NSInteger AuctionMode;
@property (nonatomic, copy) NSString *AuctionUrl;
@property (nonatomic, copy) NSString *CityName;
@property (nonatomic, assign) NSInteger CompanyAuctionCount;
@property (nonatomic, copy) NSString *CompanyName;
@property (nonatomic, copy) NSString *CountryName;
@property (nonatomic, copy) NSString *CountryNameCn;
@property (nonatomic, copy) NSString *DefaultProductImgUrl;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *NameCn;
@property (nonatomic, copy) NSString *SpecialName;
@property (nonatomic, assign) NSInteger NowItemCount;
@property (nonatomic, assign) NSInteger AuctionCount;
@property (nonatomic, copy) NSString *RemainTime;
@property (nonatomic, copy) NSString *StateName;
@property (nonatomic, assign) NSInteger Status;
@property (nonatomic, copy) NSString *Time;
@property (nonatomic, assign) NSInteger Times;
@property (nonatomic, assign) bool IsToday;
@property (nonatomic, copy) NSString *LotRange;
@property (nonatomic, assign) NSInteger StartTime;
@property (nonatomic, assign) NSInteger ServerTime;
@property (nonatomic, assign) NSInteger IsVideoLive;
@property (nonatomic, assign) bool IsDelay;
@end

NS_ASSUME_NONNULL_END
