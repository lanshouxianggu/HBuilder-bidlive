//
//  BidLiveHomeScrollVideoGuaideCell.h
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import <UIKit/UIKit.h>
#import "BidLiveHomeVideoGuaideModel.h"
#import "YFGIFImageView.h"


@interface BidLiveLivingView : UIView
@property (nonatomic, strong) YFGIFImageView *animationImageView;
@end

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScrollVideoGuaideCell : UICollectionViewCell
@property (nonatomic, strong) BidLiveHomeVideoGuaideListModel *model;
@property (nonatomic, strong) BidLiveLivingView *livingView;
@property (nonatomic, strong) UIView *rtcSuperView;

@end

NS_ASSUME_NONNULL_END
