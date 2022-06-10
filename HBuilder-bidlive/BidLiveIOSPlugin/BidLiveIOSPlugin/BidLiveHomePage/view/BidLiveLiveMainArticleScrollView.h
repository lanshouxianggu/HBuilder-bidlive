//
//  BidLiveLiveMainArticleScrollView.h
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import <UIKit/UIKit.h>
#import "BidLiveHomeCMSArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveLiveMainArticleScrollView : UIScrollView
@property (nonatomic, copy) void (^bannerClick)(BidLiveHomeCMSArticleModel *model);

-(void)updateBannerArray:(NSArray <BidLiveHomeCMSArticleModel *> *)bannerArray;
@end

NS_ASSUME_NONNULL_END
