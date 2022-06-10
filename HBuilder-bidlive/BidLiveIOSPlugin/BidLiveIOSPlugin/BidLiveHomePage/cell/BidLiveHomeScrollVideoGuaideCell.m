//
//  BidLiveHomeScrollVideoGuaideCell.m
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import "BidLiveHomeScrollVideoGuaideCell.h"
#import "BidLiveBundleRecourseManager.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "LCConfig.h"

@interface BidLiveHomeScrollVideoGuaideCell ()
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *videoTitleLabel;
@end

@implementation BidLiveHomeScrollVideoGuaideCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *topView = [UIView new];
    topView.layer.masksToBounds = YES;
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(self.frame.size.height*4/7);
    }];
    
    [topView addSubview:self.videoImageView];
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIImage *image = [BidLiveBundleRecourseManager getBundleImage:@"lianpaijiangtangvideobg" type:@"png"];
    
    UIImageView *iconImageV = [[UIImageView alloc] initWithImage:image];
    [topView addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.center.offset(0);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(self.frame.size.height*3/7);
    }];
    
    [bottomView addSubview:self.videoTitleLabel];
    [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.right.offset(-8);
        make.top.offset(12);
        make.bottom.offset(-12);
    }];
}

#pragma mark - setter
-(void)setModel:(BidLiveHomeVideoGuaideListModel *)model {
    _model = model;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:nil];
    self.videoTitleLabel.text = model.name;
}

#pragma mark - lazy
-(UIImageView *)videoImageView {
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _videoImageView;
}

-(UILabel *)videoTitleLabel {
    if (!_videoTitleLabel) {
        _videoTitleLabel = [UILabel new];
        _videoTitleLabel.textColor = UIColorFromRGB(0x3b3b3b);
        _videoTitleLabel.font = [UIFont systemFontOfSize:13];
        _videoTitleLabel.numberOfLines = 2;
        _videoTitleLabel.text = @"精彩亚洲艺术专拍上线 艾德预展现场打卡打卡打卡打卡打卡打卡";
    }
    return _videoTitleLabel;
}
@end
