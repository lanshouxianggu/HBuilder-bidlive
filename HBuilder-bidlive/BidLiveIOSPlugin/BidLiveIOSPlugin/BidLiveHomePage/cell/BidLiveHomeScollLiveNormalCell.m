//
//  BidLiveHomeScollLiveNormalCell.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScollLiveNormalCell.h"
#import "LCConfig.h"
#import "UIImageView+WebCache.h"
#import "NSAttributedString+LLMake.h"
#import "NSString+LLStringConnection.h"

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
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.liveBtn.layer.cornerRadius = 4;
    self.liveBtn.layer.masksToBounds = YES;
}

-(void)setModel:(BidLiveHomeGlobalLiveModel *)model {
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.AuctionUrl] placeholderImage:nil];
    self.mainTitleLabel.text = model.CompanyName;
    self.subTitleLabel.text = model.SpecialName;
    self.detailLabel.text = model.LotRange;
    
    if (model.Status==4) {
        [self.liveBtn setTitle:@"正在直播" forState:UIControlStateNormal];
        self.liveBtn.backgroundColor = UIColorFromRGB(0xC6746C);
        self.changeLabel.text = [NSString stringWithFormat:@"第%ld件/%ld件",model.NowItemCount,model.AuctionItemCount];
        self.changeLabel.textColor = UIColorFromRGB(0xC6746C);
    }else if (model.Status==3) {
        [self.liveBtn setTitle:@"即将开拍" forState:UIControlStateNormal];
        self.liveBtn.backgroundColor = UIColorFromRGB(0x7BB1CF);
        self.changeLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(@"距开拍 ").foregroundColor(UIColorFromRGB(0x666666));
            make.text(@""[model.RemainTime]).foregroundColor(UIColorFromRGB(0x7BB1CF));
        }];
        self.detailLabel.text = [NSString stringWithFormat:@"共%ld场 %ld件",model.AuctionCount,model.AuctionItemCount];
    }
}

- (IBAction)liveBtnAction:(id)sender {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
