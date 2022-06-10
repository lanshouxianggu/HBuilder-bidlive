//
//  BidLiveHomeGuessYouLikeModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeGuessYouLikeListModel : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger auctionId;
@property (nonatomic, copy) NSString *auctionName;
@property (nonatomic, copy) NSString *auctionCoin;
@property (nonatomic, copy) NSString *sellerName;
@property (nonatomic, copy) NSString *lot;
@property (nonatomic, copy) NSString *auctionItemName;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) NSInteger startTime;
@property (nonatomic, assign) NSInteger serverNowTime;
@property (nonatomic, copy) NSString *strAuctionStartTime;
@property (nonatomic, copy) NSString *strRemainTime;
@property (nonatomic, copy) NSString *strStartingPrice;
@property (nonatomic, assign) NSInteger auctionStatus;
@property (nonatomic, copy) NSString *countryIcon;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) bool isEn;
@end

@interface BidLiveHomeGuessYouLikeModel : NSObject
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSArray <BidLiveHomeGuessYouLikeListModel *> *list;
@end

NS_ASSUME_NONNULL_END
