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
@end

@implementation BidLiveHomeScrollHighlightLotsCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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
        make.edges.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = UIColor.whiteColor;
    
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(topView.mas_bottom);
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
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
    }];
    
    [bottomView addSubview:self.remainTimeLabel];
    [self.remainTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.right.offset(-8);
        make.bottom.offset(-10);
    }];
}

#pragma mark - setter
-(void)setModel:(BidLiveHomeHighlightLotsListModel *)model {
    _model = model;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
    self.titleLabel.text = @""[model.title];
    self.startingPriceLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
        make.text(@"起拍价 ").foregroundColor(UIColorFromRGB(0x666666));
        make.text(@""[model.strStartingPrice]).foregroundColor(UIColorFromRGB(0x5E98CB));
    }];
    self.remainTimeLabel.text = @"距开拍 "[model.strRemainTime];
}

#pragma mark - lazy
-(UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.backgroundColor = UIColor.cyanColor;
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
        _startingPriceLabel.textColor = UIColorFromRGB(0x666666);
        _startingPriceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _startingPriceLabel;
}

-(UILabel *)remainTimeLabel {
    if (!_remainTimeLabel) {
        _remainTimeLabel = [UILabel new];
        _remainTimeLabel.textColor = UIColorFromRGB(0x666666);
        _remainTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _remainTimeLabel;
}
@end
