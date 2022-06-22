//
//  BidLiveHomeVideoGuideView.m
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import "BidLiveHomeVideoGuideView.h"
#import "LCConfig.h"
#import "Masonry.h"
#import "BidLiveBundleResourceManager.h"
#import "BidLiveHomeScrollVideoGuaideCell.h"
#import "BidLiveHomeVideoGuaideModel.h"
#import <LiveEB_IOS/LiveEBManager.h>
#import "WebRtcView.h"

#define kCollectionViewHeight (SCREEN_HEIGHT*0.18)
#define kItemWidth (SCREEN_WIDTH-15*2-12*2)/2.25

@interface BidLiveHomeVideoGuideView () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray <BidLiveHomeVideoGuaideListModel *> *dataList;
@property (nonatomic, strong) BidLiveHomeScrollVideoGuaideCell *lastPlayVideoCell;
@property (nonatomic, strong) WebRtcView *rtcView;
@end

@implementation BidLiveHomeVideoGuideView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.collectionView];
}

-(void)backToStartFrame {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

-(void)updateVideoGuideList:(NSArray<BidLiveHomeVideoGuaideListModel *> *)list {
    self.dataList = list;
    [self.collectionView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startPlayFirstCell];
    });
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [UIView animateWithDuration:0.15 animations:^{
//        self.floatView.transform = CGAffineTransformMakeScale(0.001, 0.001);
//    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
       [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
       // 停止类型3
       BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
       if (dragToDragStop) {
          [self scrollViewDidEndScroll];
       }
  }
}

#pragma mark - 停止播放
-(void)stopPlayVideo {
    [self.rtcView.videoView stop];
//    self.lastPlayVideoCell.rtcSuperView.hidden = YES;
    self.lastPlayVideoCell.rtcSuperView.alpha = 0;
    [self.rtcView removeFromSuperview];
    [[LiveEBManager sharedManager] finitSDK];
}

#pragma mark - 开始播放
-(void)startPlayVideo {
//    [self.lastPlayVideoCell.rtcSuperView addSubview:self.rtcView];
//    [self playStream];
//    self.lastPlayVideoCell.rtcSuperView.alpha = 1;
    
    [self playStream:self.lastPlayVideoCell];
}

#pragma mark - 播放第一个
-(void)startPlayFirstCell {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    BidLiveHomeScrollVideoGuaideCell *firstCell = (BidLiveHomeScrollVideoGuaideCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [self playStream:firstCell];
}
#pragma mark - scrollView 停止滚动监测
//中间位置的cell播放视频流
- (void)scrollViewDidEndScroll {
    CGFloat offsetX = self.collectionView.contentOffset.x;
    
    NSIndexPath *indexPath = nil;
    BidLiveHomeScrollVideoGuaideCell *currentCell = nil;
    if (offsetX==0) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        currentCell = (BidLiveHomeScrollVideoGuaideCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    }else {
        indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(offsetX+self.collectionView.frame.size.width/2, 0)];
        currentCell = (BidLiveHomeScrollVideoGuaideCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    }
    if (currentCell==nil) {
        return;
    }
    if ([currentCell isEqual:self.lastPlayVideoCell]) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopPlayVideo];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self playStream:currentCell];
        });
    });
    
    NSLog(@"当前位置：%f", offsetX);
}

-(void)playStream:(BidLiveHomeScrollVideoGuaideCell *)currentCell {
    //1、请求接口获取播流地址
    
    [BidLiveHomeNetworkModel getHomePageGetTXTtpPlayUrl:currentCell.model.roomType domain:@"" streamName:@""[currentCell.model.liveRoomId] appName:@"" key:@"" secondsTime:1 completion:^(NSString * _Nonnull liveUrl) {
        if (liveUrl.length) {
            //2、播流
        }
    }];
    
    
    [currentCell.rtcSuperView addSubview:self.rtcView];
    [self.rtcView.videoView start];
    [UIView animateWithDuration:0.5 animations:^{
        currentCell.rtcSuperView.alpha = 1;
    }];
    self.lastPlayVideoCell = currentCell;
}


#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeScrollVideoGuaideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BidLiveHomeScrollVideoGuaideCell" forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.item];
//    cell.rtcSuperView.hidden = YES;
    cell.rtcSuperView.alpha = 0;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.cellClickBlock?:self.cellClickBlock(self.dataList[indexPath.item]);
}

#pragma mark - lazy
-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(kItemWidth, kCollectionViewHeight);
        _layout.minimumLineSpacing = 12;
        _layout.minimumInteritemSpacing = 0;
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-15*2, kCollectionViewHeight) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        [_collectionView registerClass:BidLiveHomeScrollVideoGuaideCell.class forCellWithReuseIdentifier:@"BidLiveHomeScrollVideoGuaideCell"];
    }
    return _collectionView;
}

-(WebRtcView *)rtcView {
    if (!_rtcView) {
        _rtcView = [[WebRtcView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kCollectionViewHeight*4/7)];
        _rtcView.videoView.liveEBURL = @"webrtc://5664.liveplay.myqcloud.com/live/5664_harchar1";
        [_rtcView.videoView setAudioMute:YES];
    }
    return _rtcView;
}
@end
