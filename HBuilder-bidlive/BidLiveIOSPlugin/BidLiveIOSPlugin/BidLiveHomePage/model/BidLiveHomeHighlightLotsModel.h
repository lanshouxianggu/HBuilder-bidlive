//
//  BidLiveHomeHighlightLotsModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeHighlightLotsListModel : NSObject
@property (nonatomic, copy) NSString *dealPrice;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *strRemainTime;
@property (nonatomic, assign) NSInteger mode;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *sqId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger sellerId;
@property (nonatomic, copy) NSString *sellerName;
@property (nonatomic, assign) NSInteger auctionId;
@property (nonatomic, copy) NSString *auctionName;
@property (nonatomic, copy) NSString *auctionCoin;
@property (nonatomic, assign) NSInteger startingPrice;
@property (nonatomic, copy) NSString *strStartingPrice;
@property (nonatomic, copy) NSString *strDealPrice;
@property (nonatomic, assign) float myBidPrice;
@property (nonatomic, copy) NSString *strMyBidPrice;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *strStatus;
@property (nonatomic, assign) bool bidSuccess;
@property (nonatomic, copy) NSString *countryName;
@property (nonatomic, copy) NSString *strEstimatePrice;
@property (nonatomic, assign) long startTime;
@property (nonatomic, copy) NSString *strStartTime;
@property (nonatomic, copy) NSString *strRemindTime;
@property (nonatomic, assign) NSInteger auctionStatus;
@property (nonatomic, copy) NSString *strAuctionStatus;
@property (nonatomic, assign) bool isLiveAuction;
@property (nonatomic, assign) bool isFavorite;
@end

@interface BidLiveHomeHighlightLotsModel : NSObject
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSArray <BidLiveHomeHighlightLotsListModel *> *list;
@end

NS_ASSUME_NONNULL_END
