//
//  BidLiveHomeScrollSpeechCell.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScrollSpeechCell.h"
#import "BidLiveBundleRecourseManager.h"

@interface BidLiveHomeScrollSpeechCell ()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoIconImageView;

@end

@implementation BidLiveHomeScrollSpeechCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImage *image = [BidLiveBundleRecourseManager getBundleImage:@"lianpaijiangtangvideobg" type:@"png"];
    self.videoIconImageView.image = image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
