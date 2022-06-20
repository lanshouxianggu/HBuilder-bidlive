//
//  BidLiveHomeViewController.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveHomeViewController.h"
#import "BidLiveHomeMainView.h"
#import "BidLiveHomeScrollMainView.h"
#import "LCConfig.h"
#import <AVKit/AVKit.h>

@interface BidLiveHomeViewController () <AVPictureInPictureControllerDelegate>
@property (nonatomic, strong) BidLiveHomeMainView *mainView;
@property (nonatomic, strong) BidLiveHomeScrollMainView *mainScrollView;


@property (nonatomic, strong) AVPictureInPictureController *pipVC;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property(nonatomic,strong) AVPlayerItem *playItem;
@end

@implementation BidLiveHomeViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    [self.mainScrollView loadData];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.mainScrollView destroyTimer];
    [self.mainScrollView stopPlayVideo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self.view addSubview:self.mainView];
    [self.view addSubview:self.mainScrollView];
    
//    [self startPip];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openOrClose) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)startPip {
    NSString *videoUrl = @"webrtc://5664.liveplay.myqcloud.com/live/5664_harchar1";
    videoUrl = @"https://fileoss.fdzq.com/go_fd_co/fd-1587373158-9t0y5n.mp4";
//    videoUrl = @"https://qiniu.hongwan.com.cn/hongwan/v/990g76sj2wvedbs53vji.mp4";
//    videoUrl = @"https://qiniu.hongwan.com.cn/hongwan/v/1982wi5b4690f4rqbd9kk.mp4";
    
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionOrientationBack error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    self.playItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:videoUrl]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.playItem];
//    self.player = [AVPlayer playerWithURL:[NSURL URLWithString:videoUrl]];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.backgroundColor = (__bridge CGColorRef _Nullable)(UIColor.blackColor);
    self.playerLayer.frame = CGRectMake(100, 80, 100, 200);
    [self.player play];
    [self.view.layer addSublayer:self.playerLayer];
    //1.判断是否支持画中画功能
    if ([AVPictureInPictureController isPictureInPictureSupported]) {
        //2.开启权限
        @try {
            NSError *error = nil;
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeMoviePlayback options:AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers error:&error];
            // 为什么注释掉这里？你会发现有时 AVAudioSession 会有开启失败的情况。故用上面的方法
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionOrientationBack error:&error];
            [[AVAudioSession sharedInstance] setActive:YES error:&error];
        } @catch (NSException *exception) {
            NSLog(@"AVAudioSession发生错误");
        }
        self.pipVC = [[AVPictureInPictureController alloc] initWithPlayerLayer:self.playerLayer];
        self.pipVC.delegate = self;
    }
}

- (void)openOrClose {
    if (self.pipVC.isPictureInPictureActive) {
        [self.pipVC stopPictureInPicture];
    } else {
        [self.pipVC startPictureInPicture];
    }
}

//各种代理
// 即将开启画中画
- (void)pictureInPictureControllerWillStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"");
}
// 已经开启画中画
- (void)pictureInPictureControllerDidStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"");
}
// 开启画中画失败
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController failedToStartPictureInPictureWithError:(NSError *)error {
    NSLog(@"%@", error);
}
// 即将关闭画中画
- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"");
}
// 已经关闭画中画
- (void)pictureInPictureControllerDidStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"");
}
// 关闭画中画且恢复播放界面
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler {
    NSLog(@"");
}

-(BidLiveHomeMainView *)mainView {
    CGFloat tabBarHeight = [UIDevice vg_tabBarFullHeight];
    if (!_mainView) {
        _mainView = [[BidLiveHomeMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-tabBarHeight)];
    }
    return _mainView;
}

-(BidLiveHomeScrollMainView *)mainScrollView {
    CGFloat tabBarHeight = [UIDevice vg_tabBarFullHeight];
    if (!_mainScrollView) {
        _mainScrollView = [[BidLiveHomeScrollMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-tabBarHeight)];
        WS(weakSelf)
        [_mainScrollView setSearchClickBlock:^{
            !weakSelf.searchClickBlock?:weakSelf.searchClickBlock();
        }];
        [_mainScrollView setGlobalSaleClickBlock:^{
            !weakSelf.globalSaleClickBlock?:weakSelf.globalSaleClickBlock();
        }];
        [_mainScrollView setCountrySaleClickBlock:^{
            !weakSelf.countrySaleClickBlock?:weakSelf.countrySaleClickBlock();
        }];
        [_mainScrollView setSpeechClassClickBlock:^{
            !weakSelf.speechClassClickBlock?:weakSelf.speechClassClickBlock();
        }];
        [_mainScrollView setAppraisalClickBlock:^{
            !weakSelf.appraisalClickBlock?:weakSelf.appraisalClickBlock();
        }];
        [_mainScrollView setSendClickBlock:^{
            !weakSelf.sendClickBlock?:weakSelf.sendClickBlock();
        }];
        [_mainScrollView setInformationClickBlock:^{
            !weakSelf.informationClickBlock?:weakSelf.informationClickBlock();
        }];
        [_mainScrollView setLiveRoomClickBlock:^{
            !weakSelf.liveRoomClickBlock?:weakSelf.liveRoomClickBlock();
        }];
        [_mainScrollView setCmsArticleClickBlock:^(BidLiveHomeCMSArticleModel * _Nonnull model) {
            !weakSelf.cmsArticleClickBlock?:weakSelf.cmsArticleClickBlock(model);
        }];
        [_mainScrollView setBannerClick:^(BidLiveHomeBannerModel * _Nonnull model) {
            !weakSelf.bannerClick?:weakSelf.bannerClick(model);
        }];
        [_mainScrollView setGlobalLiveCellClickBlock:^(BidLiveHomeGlobalLiveModel * _Nonnull model) {
            !weakSelf.globalLiveCellClickBlock?:weakSelf.globalLiveCellClickBlock(model);
        }];
        [_mainScrollView setVideoGuaideCellClickBlock:^(BidLiveHomeVideoGuaideListModel * _Nonnull model) {
            !weakSelf.videoGuaideCellClickBlock?:weakSelf.videoGuaideCellClickBlock(model);
        }];
        [_mainScrollView setAbroadClickBlock:^{
            !weakSelf.abroadClickBlock?:weakSelf.abroadClickBlock();
        }];
        [_mainScrollView setInternalClickBlock:^{
            !weakSelf.internalClickBlock?:weakSelf.internalClickBlock();
        }];
        [_mainScrollView setSpeechTopMoreClickBlock:^{
            !weakSelf.speechTopMoreClickBlock?:weakSelf.speechTopMoreClickBlock();
        }];
        [_mainScrollView setSpeechCellClickBlock:^(BidLiveHomeHotCourseListModel * _Nonnull model) {
            !weakSelf.speechCellClickBlock?:weakSelf.speechCellClickBlock(model);
        }];
        [_mainScrollView setHighlightLotsCellClickBlock:^(BidLiveHomeHighlightLotsListModel * _Nonnull model) {
            !weakSelf.highlightLotsCellClickBlock?:weakSelf.highlightLotsCellClickBlock(model);
        }];
        [_mainScrollView setGuessYouLikeCellClickBlock:^(BidLiveHomeGuessYouLikeListModel * _Nonnull model) {
            !weakSelf.guessYouLikeCellClickBlock?:weakSelf.guessYouLikeCellClickBlock(model);
        }];
        [_mainScrollView setGuessYouLikeBannerClickBlock:^(BidLiveHomeBannerModel * _Nonnull model) {
            !weakSelf.guessYouLikeBannerClickBlock?:weakSelf.guessYouLikeBannerClickBlock(model);
        }];
        [_mainScrollView setAnchorCellClickBlock:^(BidLiveHomeAnchorListModel * _Nonnull model) {
            !weakSelf.anchorCellClickBlock?:weakSelf.anchorCellClickBlock(model);
        }];
        
        [_mainScrollView setToNewAuctionClickBlock:^{
//            !weakSelf.toNewAuctionClickBlock?:weakSelf.toNewAuctionClickBlock();
            [weakSelf openOrClose];
        }];
    }
    return _mainScrollView;
}

@end
