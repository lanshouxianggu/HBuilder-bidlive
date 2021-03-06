//
//  BidLiveHomeScrollHighlightLotsCell.m
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import "BidLiveHomeScrollHighlightLotsCell.h"
#import "LCConfig.h"

@interface BidLiveHomeScrollHighlightLotsCell ()
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *startingPriceLabel;
@property (nonatomic, strong) UILabel *remainTimeLabel;
@property (nonatomic, strong) UIButton *livingLabel;
@end

@implementation BidLiveHomeScrollHighlightLotsCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *topView = [UIView new];
    topView.backgroundColor = UIColor.whiteColor;
    
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(self.frame.size.height*2/3);
    }];
    
    [topView addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = UIColor.whiteColor;
    
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(topView.mas_bottom).offset(8);
    }];
    
    [bottomView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(8);
        make.right.offset(-8);
    }];
    
    [bottomView addSubview:self.startingPriceLabel];
    [self.startingPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.right.offset(-8);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(6);
    }];
    
    [bottomView addSubview:self.livingLabel];
    [self.livingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-6);
        make.right.offset(-8);
        make.width.mas_equalTo(50);
    }];
    
    [bottomView addSubview:self.remainTimeLabel];
    [self.remainTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.right.offset(-8);
        make.bottom.offset(-12);
    }];
}

-(void)livingLableTapAction {
    !self.livingLabelTapBlock?:self.livingLabelTapBlock(self.model);
}

#pragma mark - setter
-(void)setModel:(BidLiveHomeHighlightLotsListModel *)model {
    _model = model;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
    self.titleLabel.text = @""[model.title];
    
    self.livingLabel.hidden = YES;
    [self.remainTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-8);
    }];
    
    if (model.status==3) {
        //??????
        self.startingPriceLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(@"????????? ").foregroundColor(UIColorFromRGB(0x999999));
            make.text(@""[model.strDealPrice]).foregroundColor(UIColorFromRGB(0x69B2D2));
        }];
    }else {
        self.startingPriceLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(@"????????? ").foregroundColor(UIColorFromRGB(0x999999));
            make.text(@""[model.strStartingPrice]).foregroundColor(UIColorFromRGB(0x69B2D2));
        }];
    }
    
    if (model.auctionStatus==3) {
        //?????????
//        [self.livingLabel setTitle:@"?????????" forState:UIControlStateNormal];
//        [self.livingLabel setTitleColor:UIColorFromRGB(0x69B2D2) forState:UIControlStateNormal];
//        self.livingLabel.hidden = NO;
//        [self.remainTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.livingLabel.mas_left).offset(-5);
//        }];
        self.remainTimeLabel.text = @"????????? "[model.strRemainTime];
    }else if (model.auctionStatus==4) {
        //?????????
//        [self.livingLabel setTitle:@"?????????" forState:UIControlStateNormal];
//        [self.livingLabel setTitleColor:UIColorFromRGB(0x69B2D2) forState:UIControlStateNormal];
//        self.livingLabel.hidden = NO;
//        [self.remainTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.livingLabel.mas_left).offset(-5);
//        }];
        self.remainTimeLabel.text = @"????????? "[model.strRemainTime];
    }else if (model.auctionStatus==5) {
        //?????????
        self.remainTimeLabel.text = @""[model.companyName];
    }else if (model.auctionStatus==100) {
        //?????????
        [self.livingLabel setTitle:@"????????????" forState:UIControlStateNormal];
        [self.livingLabel setTitleColor:UIColorFromRGB(0xD56C68) forState:UIControlStateNormal];
        self.livingLabel.hidden = NO;
        [self.remainTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.livingLabel.mas_left).offset(-5);
        }];
        self.remainTimeLabel.text = @""[model.companyName];
    }
}

#pragma mark - lazy
-(UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.backgroundColor = UIColor.whiteColor;
        _topImageView.contentMode = UIViewContentModeScaleAspectFit;
        _topImageView.layer.masksToBounds = YES;
    }
    return _topImageView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColorFromRGB(0x3b3b3b);
        _titleLabel.font = FONT_SIZE_REGULAR(14);
    }
    return _titleLabel;
}

-(UILabel *)startingPriceLabel {
    if (!_startingPriceLabel) {
        _startingPriceLabel = [UILabel new];
        _startingPriceLabel.textColor = UIColorFromRGB(0x999999);
        _startingPriceLabel.font = FONT_SIZE_REGULAR(12);
    }
    return _startingPriceLabel;
}

-(UILabel *)remainTimeLabel {
    if (!_remainTimeLabel) {
        _remainTimeLabel = [UILabel new];
        _remainTimeLabel.textColor = UIColorFromRGB(0x999999);
        _remainTimeLabel.font = FONT_SIZE_REGULAR(12);
    }
    return _remainTimeLabel;
}

-(UIButton *)livingLabel {
    if (!_livingLabel) {
        _livingLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_livingLabel setTitle:@"????????????" forState:UIControlStateNormal];
        [_livingLabel setTitleColor:UIColorFromRGB(0xD56C68) forState:UIControlStateNormal];
        _livingLabel.titleLabel.font = FONT_SIZE_REGULAR(12);
        [_livingLabel addTarget:self action:@selector(livingLableTapAction) forControlEvents:UIControlEventTouchUpInside];
//        _livingLabel.hidden = YES;
    }
    return _livingLabel;
}
@end
