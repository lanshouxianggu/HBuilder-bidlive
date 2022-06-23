//
//  BidLiveHomeScrollYouLikeCell.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/31.
//

#import <UIKit/UIKit.h>
#import "BidLiveHomeGuessYouLikeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScrollYouLikeCell : UICollectionViewCell
@property (nonatomic, strong) BidLiveHomeGuessYouLikeListModel *model;
@property (nonatomic, copy) void (^livingTapBlock)(NSString *title);
@end

NS_ASSUME_NONNULL_END
