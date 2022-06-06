//
//  BidLiveHomeScollLiveNormalCell.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScollLiveNormalCell.h"
#import "LCConfig.h"

@interface BidLiveHomeScollLiveNormalCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;
@property (weak, nonatomic) IBOutlet UIButton *liveBtn;

@end

@implementation BidLiveHomeScollLiveNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mainView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.mainView.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainView.layer.shadowRadius = 5;
    self.mainView.layer.shadowOpacity = 0.05;
    
    self.imageV.backgroundColor = UIColorFromRGB(0xf8f8f8);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)liveBtnAction:(id)sender {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
