//
//  BidLiveHomeScrollYouLikeCell.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/31.
//

#import "BidLiveHomeScrollYouLikeCell.h"
#import "LCConfig.h"

@interface BidLiveHomeScrollYouLikeCell ()
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *stateLabel;
@end

@implementation BidLiveHomeScrollYouLikeCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(190);
    }];
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.topImageView.mas_bottom);
    }];
}

-(void)setModel:(BidLiveHomeGuessYouLikeListModel *)model {
    _model = model;
    @autoreleasepool {
        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
    }
    
    self.nameLabel.text = @""[model.auctionItemName];
    
    self.priceLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
        make.text(@"起拍价 ").foregroundColor(UIColorFromRGB(0x999999));
        make.text(model.strStartingPrice).foregroundColor(UIColorFromRGB(0x5E98CB));
    }];
    if (model.auctionStatus==4) {
        [self.stateLabel setTitle:@"正在直播" forState:UIControlStateNormal];
        [self.stateLabel setTitleColor:UIColorFromRGB(0xC6746C) forState:UIControlStateNormal];
        self.dateLabel.text = @""[model.sellerName];
    }else {
        [self.stateLabel setTitle:@"预展中" forState:UIControlStateNormal];
        [self.stateLabel setTitleColor:UIColorFromRGB(0x5E98CB) forState:UIControlStateNormal];
        self.dateLabel.text = @"距开拍 "[model.strRemainTime];
    }
}

-(void)livingAction:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"正在直播"]) {
        !self.livingTapBlock?:self.livingTapBlock(self.model);
    }
}

#pragma mark - lazy
-(UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [UIImageView new];
        _topImageView.backgroundColor = UIColor.whiteColor;
        _topImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _topImageView;
}

-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = UIColor.whiteColor;
        [_bottomView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(8);
            make.top.offset(13);
            make.right.offset(-8);
        }];
        
        [_bottomView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(8);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
            make.right.offset(-8);
        }];
        
        [_bottomView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(8);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
            make.right.offset(-60);
        }];
        
        [_bottomView addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-8);
            make.centerY.equalTo(self.dateLabel);
        }];
    }
    return _bottomView;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"清 青花人物纹纹杯";
        _nameLabel.textColor = UIColorFromRGB(0x3b3b3b);
        _nameLabel.font = FONT_SIZE_REGULAR(15);
    }
    return _nameLabel;
}

-(UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.text = @"起拍价 2万日元";
        _priceLabel.textColor = UIColorFromRGB(0x999999);
        _priceLabel.font = FONT_SIZE_REGULAR(12);
    }
    return _priceLabel;
}

-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.text = @"距开拍 5天3时";
        _dateLabel.textColor = UIColorFromRGB(0x999999);
        _dateLabel.font = FONT_SIZE_REGULAR(12);
    }
    return _dateLabel;
}

-(UIButton *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stateLabel setTitle:@"预展中" forState:UIControlStateNormal];
        _stateLabel.titleLabel.textAlignment = NSTextAlignmentRight;
        [_stateLabel setTitleColor:UIColorFromRGB(0x5E98CB) forState:UIControlStateNormal];
        _stateLabel.titleLabel.font = FONT_SIZE_REGULAR(13);
        [_stateLabel addTarget:self action:@selector(livingAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stateLabel;
}
@end
