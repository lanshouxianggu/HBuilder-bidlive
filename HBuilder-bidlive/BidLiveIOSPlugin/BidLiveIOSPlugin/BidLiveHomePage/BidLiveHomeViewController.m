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
    }
    return _mainScrollView;
}

@end
