//
//  BidLiveHomeScrollAnchorCell.m
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import "BidLiveHomeScrollAnchorCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+LLStringConnection.h"
#import "LCConfig.h"
#import "UIView+GradientColor.h"

@interface BidLiveHomeScrollAnchorCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIView *topRightView;
@property (weak, nonatomic) IBOutlet UIView *topLeftView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *topLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *topRightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bottomCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *bottomTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomSubTitleLabel;

@end

@implementation BidLiveHomeScrollAnchorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.coverImageView.backgroundColor = UIColor.cyanColor;
    
    self.rtcSuperView.layer.masksToBounds = YES;
    self.rtcSuperView.backgroundColor = UIColor.blackColor;
//    self.rtcSuperView.hidden = YES;
    self.rtcSuperView.alpha = 0;
//    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bottomCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.topView.backgroundColor = UIColor.clearColor;
    self.topView.layer.cornerRadius = 4;
    self.topView.layer.masksToBounds = YES;
    self.topRightView.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    
    self.bottomCoverImageView.backgroundColor = UIColor.cyanColor;
    self.bottomCoverImageView.layer.cornerRadius = 25;
    self.bottomCoverImageView.layer.masksToBounds = YES;
    self.bottomView.backgroundColor = UIColor.clearColor;
    self.bottomView.frame = CGRectMake(0, self.frame.size.height, SCREEN_WIDTH-30, 72);
        
    self.topLeftView.layer.masksToBounds = YES;
    //设置渐变
    [self.bottomView gradientFromColor:UIColorFromRGBA(0x3b3b3b, 0) toColor:UIColorFromRGBA(0x3b3b3b, 1) directionType:GradientDirectionToDown];
}

-(void)setModel:(BidLiveHomeAnchorListModel *)model {
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImage] placeholderImage:nil];
    self.topRightLabel.text = @""[model.liveDateTimeStr][@" 开播"];

    
    if (model.liveStatus==5) {
        self.topLeftLabel.text = @"预告";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.topLeftView gradientFromColor:UIColorFromRGB(0x7590F6) toColor:UIColorFromRGB(0x88D3F2) directionType:GradientDirectionToRight];
        });
    }else if (model.liveStatus==0) {
        self.topLeftLabel.text = @"预展";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.topLeftView gradientFromColor:UIColorFromRGB(0x7590F6) toColor:UIColorFromRGB(0x88D3F2) directionType:GradientDirectionToRight];
        });
    }else if (model.liveStatus==1) {
        self.topLeftLabel.text = @"直播中";
        self.topRightLabel.text = @""[@(model.watchCount)][@"热度"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.topLeftView gradientFromColor:UIColorFromRGB(0xF8523B) toColor:UIColorFromRGB(0xF9B194) directionType:GradientDirectionToRight];
        });
    }
    
    self.bottomView.hidden = !model.isShowAvater;
    if (model.isShowAvater) {
        [self.bottomCoverImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:nil];
        self.bottomTitleLabel.text = @""[model.storeName];
        self.bottomSubTitleLabel.text = @""[model.subjectName];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
