//
//  BidLiveHomeScrollHighlightLotsCell.m
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import "BidLiveHomeScrollHighlightLotsCell.h"
#import "Masonry.h"
#import "NSString+LLStringConnection.h"
#import "NSAttributedString+LLMake.h"
#import "LCConfig.h"
#import "UIImageView+WebCache.h"

@interface BidLiveHomeScrollHighlightLotsCell ()
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *startingPriceLabel;
@property (nonatomic, strong) UILabel *remainTimeLabel;
@property (nonatomic, strong) UILabel *livingLabel;
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
        make.bottom.offset(-12);
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
        //已拍
        self.startingPriceLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(@"落槌价 ").foregroundColor(UIColorFromRGB(0x999999));
            make.text(@""[model.strDealPrice]).foregroundColor(UIColorFromRGB(0x69B2D2));
        }];
        self.remainTimeLabel.text = @""[model.companyName];
    }else if (model.status==4) {
        //正在直播
        self.startingPriceLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(@"起拍价 ").foregroundColor(UIColorFromRGB(0x999999));
            make.text(@""[model.strStartingPrice]).foregroundColor(UIColorFromRGB(0x69B2D2));
        }];
        self.remainTimeLabel.text = @""[model.companyName];
        self.livingLabel.hidden = NO;
        [self.remainTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.livingLabel.mas_left).offset(-5);
        }];
    }else if (model.status==5/* || model.status==2*/) {
        //流拍、已结束
        self.startingPriceLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(@"起拍价 ").foregroundColor(UIColorFromRGB(0x999999));
            make.text(@""[model.strStartingPrice]).foregroundColor(UIColorFromRGB(0x69B2D2));
        }];
        self.remainTimeLabel.text = @""[model.companyName];
    }else {
        //预展中
        self.startingPriceLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(@"起拍价 ").foregroundColor(UIColorFromRGB(0x999999));
            make.text(@""[model.strStartingPrice]).foregroundColor(UIColorFromRGB(0x69B2D2));
        }];
        self.remainTimeLabel.text = @"距开拍 "[model.strRemainTime];
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
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

-(UILabel *)startingPriceLabel {
    if (!_startingPriceLabel) {
        _startingPriceLabel = [UILabel new];
        _startingPriceLabel.textColor = UIColorFromRGB(0x999999);
        _startingPriceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _startingPriceLabel;
}

-(UILabel *)remainTimeLabel {
    if (!_remainTimeLabel) {
        _remainTimeLabel = [UILabel new];
        _remainTimeLabel.textColor = UIColorFromRGB(0x999999);
        _remainTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _remainTimeLabel;
}

-(UILabel *)livingLabel {
    if (!_livingLabel) {
        _livingLabel = [UILabel new];
        _livingLabel.text = @"正在直播";
        _livingLabel.textColor = UIColorFromRGB(0xD56C68);
        _livingLabel.font = [UIFont systemFontOfSize:12];
//        _livingLabel.hidden = YES;
    }
    return _livingLabel;
}
@end
