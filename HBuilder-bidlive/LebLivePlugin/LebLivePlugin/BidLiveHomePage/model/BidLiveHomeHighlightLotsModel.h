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
///(1,2直播拍场 3，4委托拍场)
@property (nonatomic, assign) NSInteger mode;
///拍品编号
@property (nonatomic, assign) NSInteger id;
///Lot号
@property (nonatomic, copy) NSString *sqId;
@property (nonatomic, copy) NSString *title;
///拍企编号
@property (nonatomic, assign) NSInteger sellerId;
///拍企名称
@property (nonatomic, copy) NSString *sellerName;
///拍场编号
@property (nonatomic, assign) NSInteger auctionId;
///拍场名称
@property (nonatomic, copy) NSString *auctionName;
///拍场货币
@property (nonatomic, copy) NSString *auctionCoin;
///起拍价
@property (nonatomic, assign) NSInteger startingPrice;
@property (nonatomic, copy) NSString *strStartingPrice;
///成交价
@property (nonatomic, copy) NSString *strDealPrice;
///我的出价
@property (nonatomic, assign) float myBidPrice;
@property (nonatomic, copy) NSString *strMyBidPrice;
///拍品封面图
@property (nonatomic, copy) NSString *imageUrl;
///拍品状态
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *strStatus;
///竞拍成功
@property (nonatomic, assign) bool bidSuccess;
///拍场举办国家
@property (nonatomic, copy) NSString *countryName;
///估价
@property (nonatomic, copy) NSString *strEstimatePrice;
@property (nonatomic, assign) long startTime;
@property (nonatomic, copy) NSString *strStartTime;
@property (nonatomic, copy) NSString *strRemindTime;
///拍场状态 3预展中 4准备中 5已结束 100进行中
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
