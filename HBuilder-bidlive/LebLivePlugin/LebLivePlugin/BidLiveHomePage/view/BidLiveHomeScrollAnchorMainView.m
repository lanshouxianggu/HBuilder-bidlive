//
//  BidLiveHomeScrollAnchorMainView.m
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import "BidLiveHomeScrollAnchorMainView.h"
#import "LCConfig.h"
#import "BidLiveBundleResourceManager.h"
#import "BidLiveHomeScrollAnchorCell.h"
#import "BidLiveHomeScrollLiveBtnView.h"
#import <LiveEB_IOS/LiveEBManager.h>
#import "WebRtcView.h"

@interface BidLiveHomeScrollAnchorMainView ()<UITableViewDelegate,UITableViewDataSource,LiveEBVideoViewDelegate>
///是否点击了更多
@property (nonatomic, assign) BOOL isClickMore;
///是否点击了收起
@property (nonatomic, assign) BOOL isClickBack;

@property (nonatomic, strong) BidLiveHomeScrollAnchorCell *lastPlayVideoCell;
@property (nonatomic, strong) WebRtcView *rtcView;
@property (nonatomic, assign) BOOL isPlayVideo;
@property (nonatomic, strong) UIView *footerView;
@end

@implementation BidLiveHomeScrollAnchorMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.anchorsArray = [NSMutableArray array];
        self.isClickBack = YES;
        self.clickMoreTimes = 0;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 40, 0));
    }];
    
    [self addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [self addSubviewToFooterView:self.clickMoreTimes];
}

-(void)addSubviewToFooterView:(NSInteger)clickMoreTimes {
    for (UIView *view in self.footerView.subviews) {
        [view removeFromSuperview];
    }
    WS(weakSelf)
    if (clickMoreTimes==0) {
        BidLiveHomeScrollLiveBtnView *rightView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"更多" direction:ArrowDirectionDown];
        [rightView setClickBock:^{
            weakSelf.isClickMore = YES;
            weakSelf.isClickBack = NO;
            weakSelf.clickMoreTimes++;
            !weakSelf.moreClickBlock?:weakSelf.moreClickBlock();
            [weakSelf addSubviewToFooterView:weakSelf.clickMoreTimes];
        }];
        
        [weakSelf.footerView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
            make.centerX.offset(-2);
            make.bottom.offset(0);
        }];
    }
//    else if (self.clickMoreTimes>0 && self.clickMoreTimes<2) {
//        BidLiveHomeScrollLiveBtnView *leftView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"收起" direction:ArrowDirectionUp];
//        [leftView setClickBock:^{
//            weakSelf.isClickBack = YES;
//            weakSelf.isClickMore = NO;
//            weakSelf.clickMoreTimes = 0;
//            !weakSelf.retractingClickBlock?:weakSelf.retractingClickBlock();
//        }];
//        [footView addSubview:leftView];
//        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(70);
//            make.height.mas_equalTo(30);
//            make.bottom.offset(-10);
//            make.centerX.offset(-40);
//        }];
//
//        BidLiveHomeScrollLiveBtnView *rightView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"更多" direction:ArrowDirectionDown];
//        [rightView setClickBock:^{
//            weakSelf.isClickMore = YES;
//            weakSelf.isClickBack = NO;
//            weakSelf.clickMoreTimes++;
//            !weakSelf.moreClickBlock?:weakSelf.moreClickBlock();
//        }];
//
//        [footView addSubview:rightView];
//        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(70);
//            make.height.mas_equalTo(30);
//            make.centerX.offset(40);
//            make.bottom.offset(-10);
//        }];
//    }
    else {
        BidLiveHomeScrollLiveBtnView *rightView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"收起" direction:ArrowDirectionUp];
        [rightView setClickBock:^{
            weakSelf.isClickMore = YES;
            weakSelf.isClickBack = NO;
            weakSelf.clickMoreTimes=0;
            !weakSelf.retractingClickBlock?:weakSelf.retractingClickBlock();
            [weakSelf addSubviewToFooterView:weakSelf.clickMoreTimes];
        }];
        
        [weakSelf.footerView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
            make.centerX.offset(-2);
            make.bottom.offset(0);
        }];
    }
}

-(void)reloadData {
    [self.tableView reloadData];
}

-(void)anchorMoreBtnAction {
    !self.arrowClickBlock?:self.arrowClickBlock();
}

#pragma mark - 停止播放
-(void)stopPlayVideo {
    [self.rtcView.videoView stop];
    [_rtcView removeFromSuperview];
    _rtcView = nil;
    self.lastPlayVideoCell.rtcSuperView.alpha = 0;
    self.lastPlayVideoCell = nil;
    [[LiveEBManager sharedManager] finitSDK];
    
//    [self.rtcView.videoView stop];
//    self.lastPlayVideoCell.rtcSuperView.alpha = 0;
//    [[LiveEBManager sharedManager] finitSDK];
}

#pragma mark - 开始播放
-(void)startPlayVideo {
    [self playStream:self.lastPlayVideoCell];
}

//#pragma mark - 播放第一个
-(void)startPlayFirstCell {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    BidLiveHomeScrollAnchorCell *firstCell = (BidLiveHomeScrollAnchorCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if ([firstCell isEqual:self.lastPlayVideoCell]) {
        return;
    }
    [self stopPlayVideo];
    [self playStream:firstCell];
}

#pragma mark - scrollView 停止滚动监测
//中间位置的cell播放视频流
- (void)scrollViewDidEndScroll:(CGFloat)offsetY {
    NSIndexPath *indexPath = nil;
    BidLiveHomeScrollAnchorCell *currentCell = nil;
    if (offsetY==0) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        currentCell = (BidLiveHomeScrollAnchorCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    }else {
        indexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(0, offsetY+SCREEN_HEIGHT/2)];
        currentCell = (BidLiveHomeScrollAnchorCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    }
    if (currentCell==nil) {
        return;
    }
    if ([currentCell isEqual:self.lastPlayVideoCell]) {
        return;
    }
            
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopPlayVideo];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self playStream:currentCell];
        });
    });
    self.lastOffsetY = offsetY;
}

-(void)playStream:(BidLiveHomeScrollAnchorCell *)currentCell {
    if ([currentCell isEqual:self.lastPlayVideoCell]) {
        return;
    }
    /** 测试代码*/
//    [currentCell.rtcSuperView addSubview:self.rtcView];
//    self.rtcView.videoView.liveEBURL = @""[currentCell.model.liveUrl];
//    [self.rtcView.videoView start];
//    [UIView animateWithDuration:0.5 animations:^{
//        currentCell.rtcSuperView.alpha = 1;
//    }];
//    self.lastPlayVideoCell = currentCell;
    /** 测试代码*/
    
    if (currentCell.model.liveStatus!=1) {
        return;
    }
    NSInteger playType = 1;//直播间
    if (currentCell.model.roomType==2) {
        //anchorType 1看展 0公开课
        playType = currentCell.model.anchorType==1?3:2;
    }
    //1、请求接口获取播流地址
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageGetTXTtpPlayUrl:playType domain:@"" streamName:@""[currentCell.model.id] appName:@"" key:@"" secondsTime:1 completion:^(NSString * _Nonnull liveUrl) {
        if (liveUrl.length) {
            //2、播流
            [currentCell.rtcSuperView addSubview:weakSelf.rtcView];
            weakSelf.rtcView.videoView.liveEBURL = @""[liveUrl];
            [weakSelf.rtcView.videoView start];
            [UIView animateWithDuration:0.5 animations:^{
                currentCell.rtcSuperView.alpha = 1;
            }];
            weakSelf.lastPlayVideoCell = currentCell;
        }
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.anchorsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (SCREEN_WIDTH-30)*11/18-10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [UIView new];
    headView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    
    UIImage *image = [BidLiveBundleResourceManager getBundleImage:@"indexBlock3" type:@"png"];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    [headView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(5);
        make.width.mas_equalTo(44*3.23);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *moreImage = [BidLiveBundleResourceManager getBundleImage:@"indexBlockMore" type:@"png"];
    [btn setImage:moreImage forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [btn addTarget:self action:@selector(anchorMoreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-8);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(40);
    }];
    
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeScrollAnchorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BidLiveHomeScrollAnchorCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xf8f8f8);
    BidLiveHomeAnchorListModel *model = self.anchorsArray[indexPath.row];
    
    //测试代码
//    if (indexPath.row%2==0) {
//        model.liveUrl = @"webrtc://5664.liveplay.myqcloud.com/live/5664_harchar";
//    }else {
//        model.liveUrl = @"webrtc://5664.liveplay.myqcloud.com/live/5664_harchar1";
//    }
    
    cell.model = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.cellClickBlock?:self.cellClickBlock(self.anchorsArray[indexPath.row]);
}

#pragma mark - LiveEBVideoViewDelegate
-(void)onCompletion:(LiveEBVideoView *)videoView {
    [self stopPlayVideo];
}

- (void)videoView:(LiveEBVideoView *)videoView didError:(NSError *)error {
    [self stopPlayVideo];
}

-(void)videoView:(LiveEBVideoView *)videoView didChangeVideoSize:(CGSize)size {
    
}


#pragma mark - lazy
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 15.0) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        
        
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        UINib *nib = [BidLiveBundleResourceManager getBundleNib:@"BidLiveHomeScrollAnchorCell" type:@"nib"];
        [_tableView registerNib:nib forCellReuseIdentifier:@"BidLiveHomeScrollAnchorCell"];
    }
    return _tableView;
}

-(WebRtcView *)rtcView {
    if (!_rtcView) {
        _rtcView = [[WebRtcView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, (SCREEN_WIDTH-30)*11/18-10)];
//        _rtcView.videoView.liveEBURL = @"webrtc://5664.liveplay.myqcloud.com/live/5664_harchar";
        [_rtcView.videoView setAudioMute:YES];
        _rtcView.videoView.delegate = self;
//        [_rtcView.videoView setRenderMode:LEBVideoRenderMode_ScaleAspect_FIT];
    }
    return _rtcView;
}

-(UIView *)footerView {
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _footerView;
}
@end
