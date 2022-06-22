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
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

///可否滑动
@property (nonatomic,assign) BOOL canSlide;
@property (nonatomic, copy) void (^loadMoreGuessYouLikeDataBlock)(void);
@property (nonatomic, copy) void (^youLikeViewScrollToTopBlock)(void);
@property (nonatomic, copy) void (^youLikeViewEndScrollBlock)(void);
@property (nonatomic, copy) void (^youLikeViewDidScrollBlock)(void);

///cell点击block
@property (nonatomic, copy) void (^youlikeCellClickBlock)(BidLiveHomeGuessYouLikeListModel *model);
///banner点击block
@property (nonatomic, copy) void (^youlikeBannerClickBlock)(BidLiveHomeBannerModel *model);
@end

NS_ASSUME_NONNULL_END
