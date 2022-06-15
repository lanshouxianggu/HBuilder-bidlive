//
//  BidLiveHomeScollLiveNormalCell.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import <UIKit/UIKit.h>
#import "BidLiveHomeGlobalLiveModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScollLiveNormalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic, strong) BidLiveHomeGlobalLiveModel *model;
@end

NS_ASSUME_NONNULL_END
