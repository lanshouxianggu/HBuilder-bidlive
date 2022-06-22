//
//  BidLiveHomeScrollVideoGuaideCell.m
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import "BidLiveHomeScrollVideoGuaideCell.h"
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
    
    [topView addSubview:self.livingView];
    
    UIImage *image = [BidLiveBundleResourceManager getBundleImage:@"iconicon-play" type:@"png"];
    
    UIImageView *iconImageV = [[UIImageView alloc] initWithImage:image];
    [topView addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.center.offset(0);
    }];
    
    [topView addSubview:self.rtcSuperView];
    
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
    self.livingView.hidden = !(model.isLiveroom && model.roomType==2);
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

-(BidLiveLivingView *)livingView {
    if (!_livingView) {
        _livingView = [[BidLiveLivingView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.4, self.frame.size.height*0.13)];
        _livingView.backgroundColor = UIColor.cyanColor;
    }
    return _livingView;
}

-(UIView *)rtcSuperView {
    if (!_rtcSuperView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*4/7);
        _rtcSuperView = [[UIView alloc] initWithFrame:frame];
//        _rtcSuperView.hidden = YES;
        _rtcSuperView.alpha = 0;
    }
    return _rtcSuperView;
}

@end


@implementation BidLiveLivingView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self gradientFromColor:UIColorFromRGB(0xF8523B) toColor:UIColorFromRGB(0xF9B194) directionType:GradientDirectionToRight];
            [self addRoundedCorners:UIRectCornerBottomRight withSize:CGSizeMake(8, 8)];
//        });
    }
    return self;
}

-(void)setupUI {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"BidLiveBundle" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [bundle pathForResource:@"animation_live" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *gifImage = [UIImage sd_imageWithGIFData:imageData];
    
    YFGIFImageView *imageV = [[YFGIFImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    imageV.image = gifImage;
    imageV.gifData = imageData;
    [imageV startGIF];
    self.animationImageView = imageV;
    [self addSubview:imageV];
    
    UILabel *lab = [UILabel new];
    lab.text = @"直播中";
    lab.textColor = UIColor.whiteColor;
    lab.font = [UIFont systemFontOfSize:11];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(imageV.mas_right);
    }];
}
@end
