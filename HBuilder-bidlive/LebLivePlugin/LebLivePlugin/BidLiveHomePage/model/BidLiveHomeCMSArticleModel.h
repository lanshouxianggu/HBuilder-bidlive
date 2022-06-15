//
//  BidLiveHomeCMSArticleModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeCMSArticleModel : NSObject
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Summary;
@property (nonatomic, copy) NSString *Content;
@property (nonatomic, copy) NSString *ImageUrl;
@property (nonatomic, copy) NSString *AddDate;
@property (nonatomic, copy) NSString *SendTime;
@property (nonatomic, copy) NSString *SendTime2;
@end

NS_ASSUME_NONNULL_END
