//
//  BidLiveHomeFirstCell.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveHomeFirstCell.h"
#import "BidLiveTopBannerView.h"
#import "SGAdvertScrollView.h"
#import "LCConfig.h"

@interface BidLiveHomeFirstCell () <SGAdvertScrollViewDelegate>
@property (nonatomic, strong) BidLiveTopBannerView *bannerView;
@property (nonatomic, strong) NSArray *imageArray;

@property (weak, nonatomic) IBOutlet UIView *topBannerView;

@property (weak, nonatomic) IBOutlet SGAdvertScrollView *scrollTitleView;
@end

@implementation BidLiveHomeFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.imageArray = @[UIColor.cyanColor,UIColor.blueColor,UIColor.yellowColor,UIColor.redColor];
    
    [self.topBannerView addSubview:self.bannerView];
//    [self.scrollTitleView addSubview:self.shufflingLableView];
//    [self.shufflingLableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsZero);
//    }];
    self.scrollTitleView.titles = @[@"1.上岛咖啡就是看劳动法就是盛开的积分是劳动法",
                                    @"2.SDK和索拉卡的附近是了的开发房贷",
                                    @"3.收快递费就SDK废旧塑料的发三楼的靠近非塑料袋开发计算量大开发就"];
    self.scrollTitleView.titleColor = UIColorFromRGB(0x3b3b3b);
    self.scrollTitleView.titleFont = [UIFont systemFontOfSize:14];
    self.scrollTitleView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)domesticAuctionAction:(id)sender {
    
}

- (IBAction)sendAuctionAction:(id)sender {
    
}


- (IBAction)lectureRoomAction:(id)sender {
    
}

- (IBAction)globalAuctionAction:(id)sender {
    
}

- (IBAction)appraisalAction:(id)sender {
    
}

- (IBAction)informationAction:(id)sender {
    
}

#pragma mark - SGAdvertScrollViewDelegate
-(void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    
}

#pragma mark - lazy
-(BidLiveTopBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[BidLiveTopBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.topBannerView.frame)) imgArray:self.imageArray];
    }
    return _bannerView;
}

@end
