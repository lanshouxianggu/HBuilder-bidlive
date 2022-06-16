//
//  BidLiveHomeScrollAnchorMainView.h
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import <UIKit/UIKit.h>
#import "BidLiveHomeAnchorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeScrollAnchorMainView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <BidLiveHomeAnchorListModel *>*anchorsArray;
@property (nonatomic, copy) void (^moreClickBlock)(void);
@property (nonatomic, copy) void (^retractingClickBlock)(void);
@property (nonatomic, copy) void (^arrowClickBlock)(void);
@property (nonatomic, copy) void (^cellClickBlock)(BidLiveHomeAnchorListModel *model);

- (void)scrollViewDidEndScroll:(CGFloat)offsetY;
-(void)startPlayFirstCell;
-(void)startPlayVideo;
-(void)stopPlayVideo;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
