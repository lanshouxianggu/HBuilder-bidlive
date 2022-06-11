//
//  BidLiveHomeScrollYouLikeMainView.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/31.
//

#import <UIKit/UIKit.h>
#import "BidLiveHomeGuessYouLikeModel.h"
#import "BidLiveHomeBannerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScrollYouLikeMainView : UIView
@property (nonatomic, strong) NSMutableArray *likesArray;
@property (nonatomic, strong) NSMutableArray <BidLiveHomeBannerModel *> *bannerArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) void (^loadMoreGuessYouLikeDataBlock)(void);
@property (nonatomic, copy) void (^youLikeViewScrollToTopBlock)(void);
@end

NS_ASSUME_NONNULL_END
