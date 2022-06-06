//
//  BidLiveHomeScrollYouLikeMainView.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScrollYouLikeMainView : UIView
@property (nonatomic, strong) NSMutableArray *likesArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
