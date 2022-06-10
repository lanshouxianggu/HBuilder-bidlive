//
//  BidLiveHomeAnchorModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeAnchorListModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *dataType;
@property (nonatomic, assign) NSInteger storeId;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, assign) NSInteger publishId;
@property (nonatomic, copy) NSString *publishName;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, assign) NSInteger anchorAuthorityId;
@property (nonatomic, assign) NSInteger liveStatus;
@property (nonatomic, assign) NSInteger anchorLiveStatus;
@property (nonatomic, copy) NSString *coverImage;
@property (nonatomic, copy) NSString *backgroundImage;
@property (nonatomic, copy) NSString *liveDateTime;
@property (nonatomic, copy) NSString *liveDateTimeStr;
@property (nonatomic, assign) bool isTransverse;
@property (nonatomic, copy) NSString *subjectName;
@property (nonatomic, copy) NSString *shareContent;
@property (nonatomic, assign) NSInteger watchCount;
@property (nonatomic, copy) NSString *storeLogo;
@property (nonatomic, assign) NSInteger liveRoomType;
@property (nonatomic, assign) NSInteger videolabel;
@property (nonatomic, assign) bool isShowAnchor;
@property (nonatomic, assign) bool isShowAvater;
@property (nonatomic, assign) NSInteger auditStatus;
@property (nonatomic, assign) NSInteger anchorType;
@property (nonatomic, assign) NSInteger videoStatus;
@property (nonatomic, assign) NSInteger heatCount;
@property (nonatomic, assign) bool isShowHome;
@property (nonatomic, assign) NSInteger sortNo;
@property (nonatomic, copy) NSString *storeRegisterTime;
@property (nonatomic, assign) NSInteger rankWeight;
@property (nonatomic, assign) bool isTryLive;
@property (nonatomic, assign) NSInteger rankCustomGroup;
@property (nonatomic, assign) NSInteger rankOrderNo;
@end

@interface BidLiveHomeAnchorModel : NSObject
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSArray <BidLiveHomeAnchorListModel *> *list;
@end

NS_ASSUME_NONNULL_END
