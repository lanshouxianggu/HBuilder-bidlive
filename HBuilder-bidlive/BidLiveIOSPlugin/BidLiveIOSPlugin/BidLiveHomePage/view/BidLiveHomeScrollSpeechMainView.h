//
//  BidLiveHomeScrollSpeechMainView.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScrollSpeechMainView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *videosArray;
@property (nonatomic, copy) void (^moreClickBlock)(void);
@property (nonatomic, copy) void (^retractingClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
