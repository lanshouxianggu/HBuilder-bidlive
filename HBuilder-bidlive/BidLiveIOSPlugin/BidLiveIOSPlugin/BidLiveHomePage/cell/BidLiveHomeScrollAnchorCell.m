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

@interface BidLiveHomeScrollAnchorCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
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
    
//    self.coverImageView.backgroundColor = UIColor.cyanColor;
    
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bottomCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.topView.backgroundColor = UIColor.clearColor;
    self.topView.layer.cornerRadius = 4;
    self.topView.layer.masksToBounds = YES;
    self.topRightLabel.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    
    self.bottomCoverImageView.backgroundColor = UIColor.cyanColor;
    self.bottomCoverImageView.layer.cornerRadius = 25;
    self.bottomCoverImageView.layer.masksToBounds = YES;
    self.bottomView.backgroundColor = UIColor.clearColor;
    self.bottomView.frame = CGRectMake(0, self.frame.size.height, SCREEN_WIDTH-30, 72);
        
    //设置渐变
    UIColor *one = UIColorFromRGBA(0x3b3b3b, 0);
    UIColor *two = UIColorFromRGBA(0x3b3b3b, 1);
    NSArray *colors = [NSArray arrayWithObjects:(id)one.CGColor,two.CGColor, nil];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(0, 1);
    gradient.colors = colors;
    gradient.frame = self.bottomView.bounds;
    
    [self.bottomView.layer insertSublayer:gradient atIndex:0];
}

-(void)setModel:(BidLiveHomeAnchorListModel *)model {
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImage] placeholderImage:nil];
    if (model.liveStatus==5) {
        self.topLeftLabel.text = @"预告";
    }else if (model.liveStatus==0) {
        self.topLeftLabel.text = @"预展";
    }
    self.topRightLabel.text = @""[model.liveDateTimeStr][@" 开播"];
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
