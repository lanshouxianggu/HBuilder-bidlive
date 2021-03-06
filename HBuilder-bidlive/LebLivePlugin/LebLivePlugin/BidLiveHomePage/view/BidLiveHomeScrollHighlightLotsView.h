//
//  BidLiveHomeScrollHighlightLotsView.h
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BidLiveHomeHighlightLotsListModel;
@interface BidLiveHomeScrollHighlightLotsView : UIView



-(void)updateHighlightLotsList:(NSArray<BidLiveHomeHighlightLotsListModel *> *)list;

@property (nonatomic, copy) void (^scrollToRightBlock)(void);
@property (nonatomic, copy) void (^cellClickBlock)(BidLiveHomeHighlightLotsListModel *model);
@property (nonatomic, copy) void (^cellLivingLabelClickBlock)(BidLiveHomeHighlightLotsListModel *model);
@end

NS_ASSUME_NONNULL_END
