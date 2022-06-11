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

@interface BidLiveHomeViewController ()
@property (nonatomic, strong) BidLiveHomeMainView *mainView;
@property (nonatomic, strong) BidLiveHomeScrollMainView *mainScrollView;
@end

@implementation BidLiveHomeViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self.view addSubview:self.mainView];
    [self.view addSubview:self.mainScrollView];
}

-(BidLiveHomeMainView *)mainView {
    if (!_mainView) {
        _mainView = [[BidLiveHomeMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    }
    return _mainView;
}

-(BidLiveHomeScrollMainView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[BidLiveHomeScrollMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
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
        [_mainScrollView setBannerClick:^(BidLiveHomeBannerModel * _Nonnull model) {
            !weakSelf.bannerClick?:weakSelf.bannerClick(model);
        }];
        [_mainScrollView setToNewAuctionClickBlock:^{
            !weakSelf.toNewAuctionClickBlock?:weakSelf.toNewAuctionClickBlock();
        }];
    }
    return _mainScrollView;
}

@end
