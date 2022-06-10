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
@end

NS_ASSUME_NONNULL_END
