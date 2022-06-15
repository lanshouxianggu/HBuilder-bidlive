//
//  BidLiveHomeVideoGuaideModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeVideoGuaideListModel : NSObject
@property (nonatomic, copy) NSString *liveRoomId;
@property (nonatomic, assign) NSInteger sellerId;
@property (nonatomic, assign) bool isMult;
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *coverUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger storeId;
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, assign) bool isLiveroom;
@property (nonatomic, assign) NSInteger sortNo;
@property (nonatomic, assign) NSInteger liveStatus;
@property (nonatomic, assign) NSInteger roomType;
@property (nonatomic, assign) bool isTransverse;
@property (nonatomic, copy) NSString *coverImage;
@property (nonatomic, assign) NSInteger publishId;
@property (nonatomic, assign) NSInteger anchorType;
@end

@interface BidLiveHomeVideoGuaideModel : NSObject
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSArray <BidLiveHomeVideoGuaideListModel *> *list;
@end

NS_ASSUME_NONNULL_END
