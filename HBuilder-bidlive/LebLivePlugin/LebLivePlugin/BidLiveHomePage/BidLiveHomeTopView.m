//
//  BidLiveHomeTopView.m
//  LebLivePlugin
//
//  Created by bidlive on 2022/6/24.
//

#import "BidLiveHomeTopView.h"


@interface BidLiveHomeTopView ()

@end

@implementation BidLiveHomeTopView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置UI
-(void)setupUI {
    [self addSubview:self.topMainView];
    [self.topMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(kTopMainViewHeight);
    }];
    
    [self addSubview:self.liveMainView];
    [self.liveMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.topMainView.mas_bottom);
//        make.height.mas_equalTo(kLiveMainViewHeight);
        make.height.mas_equalTo(0);
    }];
    
    [self addSubview:self.anchorMainView];
    [self.anchorMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.liveMainView.mas_bottom);
//        make.height.mas_equalTo(kAnchorMainViewHeight);
        make.height.mas_equalTo(0);
    }];
    
    [self addSubview:self.speechMainView];
    [self.speechMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.anchorMainView.mas_bottom);
//        make.height.mas_equalTo(kSpeechMainViewHeight);
        make.height.mas_equalTo(0);
    }];
    
    [self addSubview:self.highlightLotsMainView];
    [self.highlightLotsMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.speechMainView.mas_bottom);
//        make.height.mas_equalTo(kHightlightLotsMainViewHeight);
        make.height.mas_equalTo(0);
    }];
    
    [self addSubview:self.youlikeHeadTitleView];
    [self.youlikeHeadTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(80);
        make.top.equalTo(self.highlightLotsMainView.mas_bottom).offset(0);
    }];
}

#pragma mark - lazy
-(BidLiveHomeScrollTopMainView *)topMainView {
    if (!_topMainView) {
        _topMainView  = [[BidLiveHomeScrollTopMainView alloc] initWithFrame:CGRectZero];
        _topMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
//        WS(weakSelf)
//        [_topMainView setBannerClick:^(BidLiveHomeBannerModel * _Nonnull model) {
//            !weakSelf.bannerClick?:weakSelf.bannerClick(model);
//        }];
    }
    return _topMainView;
}

-(BidLiveHomeScrollLiveMainView *)liveMainView {
    if (!_liveMainView) {
        _liveMainView = [[BidLiveHomeScrollLiveMainView alloc] initWithFrame:CGRectZero];
        _liveMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _liveMainView;
}

-(BidLiveHomeScrollAnchorMainView *)anchorMainView {
    if (!_anchorMainView) {
        _anchorMainView = [[BidLiveHomeScrollAnchorMainView alloc] initWithFrame:CGRectZero];
        _anchorMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _anchorMainView;
}

-(BidLiveHomeScrollSpeechMainView *)speechMainView {
    if (!_speechMainView) {
        _speechMainView = [[BidLiveHomeScrollSpeechMainView alloc] initWithFrame:CGRectZero];
        _speechMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _speechMainView;
}

-(BidLiveHomeScrollHighlightLotsView *)highlightLotsMainView {
    if (!_highlightLotsMainView) {
        _highlightLotsMainView = [[BidLiveHomeScrollHighlightLotsView alloc] initWithFrame:CGRectZero];
        _highlightLotsMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
//        WS(weakSelf)
//        [_highlightLotsMainView setScrollToRightBlock:^{
//            weakSelf.highlightLotsPageIndex++;
//            [weakSelf loadHomeHighliahtLotsListData];
//        }];
    }
    return _highlightLotsMainView;
}

-(UIView *)youlikeHeadTitleView {
    if (!_youlikeHeadTitleView) {
        _youlikeHeadTitleView = [UIView new];
        _youlikeHeadTitleView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 100;
        label.text = @"猜 你 喜 欢";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.blackColor;
        label.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];

        [_youlikeHeadTitleView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
    }
    return _youlikeHeadTitleView;
}
@end
