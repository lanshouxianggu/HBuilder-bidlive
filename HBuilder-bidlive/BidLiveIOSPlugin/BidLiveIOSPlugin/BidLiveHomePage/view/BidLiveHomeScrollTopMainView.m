//
//  BidLiveHomeScrollTopMainView.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScrollTopMainView.h"
#import "BidLiveTopBannerView.h"
#import "BidLiveHomeShufflingLableView.h"
#import "SGAdvertScrollView.h"
#import "BidLiveHomeBtnItemsView.h"
#import "LCConfig.h"
#import "Masonry.h"

@interface BidLiveHomeScrollTopMainView () <SGAdvertScrollViewDelegate>
@property (nonatomic, strong) BidLiveTopBannerView *bannerView;
@property (nonatomic, strong) BidLiveHomeBtnItemsView *itemsView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIView *scrollTitleSuperView;
@property (strong, nonatomic) SGAdvertScrollView *scrollTitleView;
@property (nonatomic, strong) UIView *liveView;

@end

@implementation BidLiveHomeScrollTopMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageArray = @[UIColor.cyanColor,UIColor.blueColor,UIColor.yellowColor,UIColor.redColor];
        self.scrollTitleView.titles = @[@"1.上岛咖啡就是看劳动法就是盛开的积分是劳动法",
                                        @"2.SDK和索拉卡的附近是了的开发房贷",
                                        @"3.收快递费就SDK废旧塑料的发三楼的靠近非塑料袋开发计算量大开发就"];
        self.scrollTitleView.titleColor = UIColorFromRGB(0x3b3b3b);
        self.scrollTitleView.titleFont = [UIFont systemFontOfSize:14];
        self.scrollTitleView.delegate = self;
        
        [self setupUI];
        
        WS(weakSelf)
        [self.itemsView setGlobalSaleClickBlock:^{
            !weakSelf.globalSaleClickBlock?:weakSelf.globalSaleClickBlock();
        }];
        
        [self.itemsView setAppraisalClickBlock:^{
            !weakSelf.appraisalClickBlock?:weakSelf.appraisalClickBlock();
        }];
        
        [self.itemsView setCountrySaleClickBlock:^{
            !weakSelf.countrySaleClickBlock?:weakSelf.countrySaleClickBlock();
        }];
        
        [self.itemsView setSendClickBlock:^{
            !weakSelf.sendClickBlock?:weakSelf.sendClickBlock();
        }];
        
        [self.itemsView setSpeechClassClickBlock:^{
            !weakSelf.speechClassClickBlock?:weakSelf.speechClassClickBlock();
        }];
        
        [self.itemsView setInformationClickBlock:^{
            !weakSelf.informationClickBlock?:weakSelf.informationClickBlock();
        }];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.bannerView];
    [self addSubview:self.itemsView];
    [self addSubview:self.scrollTitleSuperView];
    [self addSubview:self.liveView];
}

#pragma mark - SGAdvertScrollViewDelegate
-(void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    
}

#pragma mark - lazy
-(BidLiveTopBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[BidLiveTopBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210) imgArray:self.imageArray];
    }
    return _bannerView;
}

-(BidLiveHomeBtnItemsView *)itemsView {
    if (!_itemsView) {
        _itemsView = [[BidLiveHomeBtnItemsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerView.frame), SCREEN_WIDTH, 100)];
        _itemsView.backgroundColor = UIColor.whiteColor;
    }
    return _itemsView;
}

-(UIView *)scrollTitleSuperView {
    if (!_scrollTitleSuperView) {
        _scrollTitleSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.itemsView.frame)+10, SCREEN_WIDTH, 44)];
        _scrollTitleSuperView.backgroundColor = UIColor.whiteColor;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 44)];
        lab.text = @"[动态]";
        lab.textColor = UIColorFromRGB(0x999999);
        lab.font = [UIFont systemFontOfSize:14];
        [_scrollTitleSuperView addSubview:lab];
        [_scrollTitleSuperView addSubview:self.scrollTitleView];
    }
    return _scrollTitleSuperView;
}

-(SGAdvertScrollView *)scrollTitleView {
    if (!_scrollTitleView) {
        _scrollTitleView = [[SGAdvertScrollView alloc] initWithFrame:CGRectMake(70, 0, SCREEN_WIDTH-100, 44)];
    }
    return _scrollTitleView;
}

-(UIView *)liveView {
    if (!_liveView) {
        _liveView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollTitleSuperView.frame)+10, SCREEN_WIDTH-30, 200)];
        _liveView.backgroundColor = UIColor.cyanColor;
    }
    return _liveView;
}

@end
