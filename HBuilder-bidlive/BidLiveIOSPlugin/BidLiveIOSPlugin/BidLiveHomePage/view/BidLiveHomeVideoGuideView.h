//
//  BidLiveHomeVideoGuideView.h
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BidLiveHomeVideoGuaideListModel;
@interface BidLiveHomeVideoGuideView : UIView
-(void)updateVideoGuideList:(NSArray <BidLiveHomeVideoGuaideListModel *> *)list;
@end

NS_ASSUME_NONNULL_END
