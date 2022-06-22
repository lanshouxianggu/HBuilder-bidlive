//
//  BidLiveHomeScrollTopMainView.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScrollTopMainView.h"
#import "BidLiveTopBannerView.h"
#import "SGAdvertScrollView.h"
#import "BidLiveHomeBtnItemsView.h"
#import "BidLiveHomeCMSArticleModel.h"
#import "BidLiveHomeVideoGuideView.h"
#import "LCConfig.h"
#import "Masonry.h"
#import "BidLiveBundleResourceManager.h"

#define kMainViewHeihgt (SCREEN_WIDTH*72/585)

@interface BidLiveHomeScrollTopMainView () <SGAdvertScrollViewDelegate>
@property (nonatomic, strong) BidLiveTopBannerView *bannerView;
@property (nonatomic, strong) BidLiveHomeBtnItemsView *itemsView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIView *scrollTitleSuperView;
@property (strong, nonatomic) SGAdvertScrollView *scrollTitleView;
@property (nonatomic, strong) BidLiveHomeVideoGuideView *videoGuideView;
@property (nonatomic, strong) NSArray <BidLiveHomeCMSArticleModel *> *cmsArticleArray;

@end

@implementation BidLiveHomeScrollTopMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageArray = @[];
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
        
        [self.itemsView setLiveRoomClickBlock:^{
            !weakSelf.liveRoomClickBlock?:weakSelf.liveRoomClickBlock();
        }];
        
        [self.videoGuideView setCellClickBlock:^(BidLiveHomeVideoGuaideListModel * _Nonnull model) {
            !weakSelf.videoGuaideCellClickBlock?:weakSelf.videoGuaideCellClickBlock(model);
        }];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.bannerView];
    [self addSubview:self.itemsView];
    [self addSubview:self.scrollTitleSuperView];
    [self addSubview:self.videoGuideView];
}

-(void)videoGuaideViewBackToStartFrame {
    [self.videoGuideView backToStartFrame];
}

-(void)updateBanners:(NSArray<BidLiveHomeBannerModel *> *)banners {
    [self.bannerView updateBannerArray:banners];
}

-(void)updateCMSArticleList:(NSArray<BidLiveHomeCMSArticleModel *> *)list {
    NSMutableArray *titles = [NSMutableArray array];
    self.cmsArticleArray = list;
    [list enumerateObjectsUsingBlock:^(BidLiveHomeCMSArticleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titles addObject:obj.Title];
    }];
    self.scrollTitleView.titles = titles;
}

-(void)updateVideoGuaideList:(NSArray<BidLiveHomeVideoGuaideListModel *> *)list {
    [self.videoGuideView updateVideoGuideList:list];
}

-(void)stopVideoPlay {
    [self.videoGuideView stopPlayVideo];
}

-(void)startVideoPlay {
    [self.videoGuideView startPlayVideo];
}

#pragma mark - SGAdvertScrollViewDelegate
-(void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    !self.cmsArticleClickBlock?:self.cmsArticleClickBlock(self.cmsArticleArray[index]);
}

-(void)destroyTimer {
    [self.bannerView destroyTimer];
}

#pragma mark - lazy
-(BidLiveTopBannerView *)bannerView {
    if (!_bannerView) {
        CGFloat height = 180;
        if (UIApplication.sharedApplication.statusBarFrame.size.height>20) {
            height = 210;
        }
        _bannerView = [[BidLiveTopBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) imgArray:self.imageArray];
        WS(weakSelf)
        [_bannerView setBannerClick:^(BidLiveHomeBannerModel * _Nonnull model) {
            !weakSelf.bannerClick?:weakSelf.bannerClick(model);
        }];
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
        _scrollTitleSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.itemsView.frame)+10, SCREEN_WIDTH, kMainViewHeihgt)];
        _scrollTitleSuperView.backgroundColor = UIColor.whiteColor;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, kMainViewHeihgt)];
        lab.text = @"[动态]";
        lab.textColor = UIColorFromRGB(0x999999);
        lab.font = [UIFont systemFontOfSize:14];
        [_scrollTitleSuperView addSubview:lab];
        [_scrollTitleSuperView addSubview:self.scrollTitleView];
        
        UIImage *arrow = [BidLiveBundleResourceManager getBundleImage:@"arrow-dark-right" type:@"png"];
        UIImageView *imageV = [[UIImageView alloc] initWithImage:arrow];
        [_scrollTitleSuperView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.offset(0);
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(12);
        }];
    }
    return _scrollTitleSuperView;
}

-(SGAdvertScrollView *)scrollTitleView {
    if (!_scrollTitleView) {
        _scrollTitleView = [[SGAdvertScrollView alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-85, kMainViewHeihgt)];
        _scrollTitleView.delegate = self;
        _scrollTitleView.scrollTimeInterval = 2;
    }
    return _scrollTitleView;
}

-(BidLiveHomeVideoGuideView *)videoGuideView {
    if (!_videoGuideView) {
        _videoGuideView = [[BidLiveHomeVideoGuideView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollTitleSuperView.frame)+10, SCREEN_WIDTH-30, SCREEN_HEIGHT*0.18)];
        _videoGuideView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _videoGuideView;
}

@end
