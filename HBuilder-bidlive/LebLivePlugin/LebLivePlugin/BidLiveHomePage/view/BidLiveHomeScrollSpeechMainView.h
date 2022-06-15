//
//  BidLiveHomeScrollSpeechMainView.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import <UIKit/UIKit.h>
#import "BidLiveHomeHotCourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScrollSpeechMainView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <BidLiveHomeHotCourseListModel *>*videosArray;
@property (nonatomic, copy) void (^moreClickBlock)(void);
@property (nonatomic, copy) void (^retractingClickBlock)(void);

@property (nonatomic, copy) void (^topArrowClickBlock)(void);
@property (nonatomic, copy) void (^cellClickBlock)(BidLiveHomeHotCourseListModel *model);
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
