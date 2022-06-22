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
@property (weak, nonatomic) IBOutlet UIImageView *liveIcon;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) long long startTime;
@property (nonatomic, assign) BOOL timerHasStarted;

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
    self.liveBtn.layer.cornerRadius = 3;
    self.liveBtn.layer.masksToBounds = YES;
    
    UIImage *liveIconImage = [BidLiveBundleResourceManager getBundleImage:@"videolive" type:@"png"];
    self.liveIcon.image = liveIconImage;
}

-(void)setModel:(BidLiveHomeGlobalLiveModel *)model {
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.AuctionUrl] placeholderImage:nil];
    self.mainTitleLabel.text = model.CompanyName;
    self.subTitleLabel.text = model.SpecialName;
    self.detailLabel.text = model.LotRange;
    self.liveIcon.hidden = !model.IsVideoLive;
    
    if (model.Status==4) {
        [self.liveBtn setTitle:@"正在直播" forState:UIControlStateNormal];
        self.liveBtn.backgroundColor = UIColorFromRGB(0xD56C68);
        self.changeLabel.text = [NSString stringWithFormat:@"第%ld件/%ld件",model.NowItemCount,model.AuctionItemCount];
        self.changeLabel.textColor = UIColorFromRGB(0xD56C68);
    }else if (model.Status==3) {
        [self.liveBtn setTitle:@"即将开拍" forState:UIControlStateNormal];
        self.liveBtn.backgroundColor = UIColorFromRGB(0x69B2D2);
//        self.changeLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
//            make.text(@"距开拍 ").foregroundColor(UIColorFromRGB(0x666666));
//            make.text(@""[model.RemainTime]).foregroundColor(UIColorFromRGB(0x7BB1CF));
//        }];
        
        WS(weakSelf)
        [self getHtmlRemainTime:model.StartTime prefix:@"距开拍  " completion:^(NSAttributedString *resultAttrStr) {
            weakSelf.changeLabel.attributedText = resultAttrStr;
            //到60分中时开始倒计时
            long long startTime = [NSDate dateWithTimeIntervalSince1970:model.StartTime*1000].timeIntervalSince1970;
            long long nowTime = [NSDate date].timeIntervalSince1970*1000;
            long long timeDiff = startTime-nowTime;
            if (timeDiff > 0 && timeDiff <= 60*60*1000 && !weakSelf.timerHasStarted) {
                [weakSelf startTimer];
                weakSelf.timerHasStarted = YES;
            }else {
                [weakSelf endTimer];
                weakSelf.timerHasStarted = NO;
            }
        }];
        
        
        self.detailLabel.text = [NSString stringWithFormat:@"共%ld场 %ld件",model.AuctionCount,model.AuctionItemCount];
    }
}

-(void)startTimer {
    if (!_timer) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
        WS(weakSelf);
        dispatch_source_set_event_handler(_timer, ^{
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (weakSelf.model.StartTime>0) {
                     [weakSelf getHtmlRemainTime:weakSelf.model.StartTime prefix:@"距开拍  " completion:^(NSAttributedString *resultAttrStr) {
                         weakSelf.changeLabel.attributedText = resultAttrStr;
                     }];
                 }else {
                     [weakSelf endTimer];
                     [weakSelf.liveBtn setTitle:@"正在直播" forState:UIControlStateNormal];
                     weakSelf.liveBtn.backgroundColor = UIColorFromRGB(0xD56C68);
                     weakSelf.changeLabel.text = [NSString stringWithFormat:@"第%ld件/%ld件",weakSelf.model.NowItemCount,weakSelf.model.AuctionItemCount];
                     weakSelf.changeLabel.textColor = UIColorFromRGB(0xD56C68);
                 }
             });
         });
         //开启计时器
         dispatch_resume(_timer);
    }
}

-(void)endTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(void)getHtmlRemainTime:(NSInteger)rowTime prefix:(NSString *)prefix completion:(void (^)(NSAttributedString *resultAttrStr))completion {
    long long startTime = [NSDate dateWithTimeIntervalSince1970:rowTime*1000].timeIntervalSince1970;
    long long nowTime = [NSDate date].timeIntervalSince1970*1000;
    long long timeDiff = startTime-nowTime;
    [self setAuctionTimer:timeDiff auctionStartTime:startTime prefix:prefix completion:^(NSAttributedString *resultAttrStr) {
        !completion?:completion(resultAttrStr);
    }];
}

-(void)setAuctionTimer:(NSInteger)timeDiff auctionStartTime:(NSInteger)auctionStartTime prefix:(NSString *)prefix completion:(void (^)(NSAttributedString *resultAttrStr))completion{
    if (timeDiff >= 60*60*1000 && timeDiff < 24*60*60*1000) {
        [self getRemainTime:timeDiff type:@"h" prefix:prefix completion:^(NSAttributedString *resultAttrStr) {
            !completion?:completion(resultAttrStr);
        }];
    }else if (timeDiff >= 60*1000 && timeDiff < 60*60*1000) {
        [self getRemainTime:timeDiff type:@"m" prefix:prefix completion:^(NSAttributedString *resultAttrStr) {
            !completion?:completion(resultAttrStr);
        }];
    }else if (timeDiff >= 1000 && timeDiff < 60*1000) {
        [self getRemainTime:timeDiff type:@"s" prefix:prefix completion:^(NSAttributedString *resultAttrStr) {
            !completion?:completion(resultAttrStr);
        }];
    }else {
//        result = new Date(auctionStartTime).format('MM月dd日 HH:mm');
    }
}

-(void)getRemainTime:(NSInteger)timeDiff type:(NSString *)type prefix:(NSString *)prefix completion:(void (^)(NSAttributedString *resultAttrStr))completion{
    NSAttributedString *result = [[NSAttributedString alloc] init];
    if ([type isEqualToString:@"h"]) {
        NSString *hour = [NSString stringWithFormat:@"%.0f", floor(timeDiff/(1000*60*60))];
        NSString *min = [NSString stringWithFormat:@"%.0f", floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60))];
        NSLog(@"%@",@"距开拍："[hour][@"时"][min][@"分"]);
        result = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(prefix).foregroundColor(UIColorFromRGB(0x666666));
            make.text(hour).foregroundColor(UIColorFromRGB(0x69B2D2)).font([UIFont systemFontOfSize:13 weight:UIFontWeightBold]);
            make.text(@"时").foregroundColor(UIColorFromRGB(0x666666));
            make.text(min).foregroundColor(UIColorFromRGB(0x69B2D2)).font([UIFont systemFontOfSize:13 weight:UIFontWeightBold]);;
            make.text(@"分").foregroundColor(UIColorFromRGB(0x666666));
        }];
        
    }else if ([type isEqualToString:@"m"]) {
        NSString *min = [NSString stringWithFormat:@"%.0f", floor(timeDiff / (1000 * 60))];
        NSString *sec = [NSString stringWithFormat:@"%.0f", floor((timeDiff % (1000 *60)) /(1000))];
        NSLog(@"%@",@"距开拍："[min][@"分"][sec][@"秒"]);
        result = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(prefix).foregroundColor(UIColorFromRGB(0x666666));
            make.text(min).foregroundColor(UIColorFromRGB(0x69B2D2)).font([UIFont systemFontOfSize:13 weight:UIFontWeightBold]);;
            make.text(@"分").foregroundColor(UIColorFromRGB(0x666666));
            make.text(sec).foregroundColor(UIColorFromRGB(0x69B2D2)).font([UIFont systemFontOfSize:13 weight:UIFontWeightBold]);;
            make.text(@"秒").foregroundColor(UIColorFromRGB(0x666666));
        }];
    }else if ([type isEqualToString:@"秒"]) {
        NSString *sec = [NSString stringWithFormat:@"%.0f", floor(timeDiff / 1000)];
        NSLog(@"%@",@"距开拍："[sec][@"秒"]);
        result = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(prefix).foregroundColor(UIColorFromRGB(0x666666));
            make.text(sec).foregroundColor(UIColorFromRGB(0x69B2D2)).font([UIFont systemFontOfSize:13 weight:UIFontWeightBold]);;
            make.text(@"秒").foregroundColor(UIColorFromRGB(0x666666));
        }];
    }
    !completion?:completion(result);
}

- (IBAction)liveBtnAction:(id)sender {
}

-(void)dealloc {
    [self endTimer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
