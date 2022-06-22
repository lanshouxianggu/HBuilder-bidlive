//
//  BidLiveHomeScrollSpeechCell.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScrollSpeechCell.h"
#import "BidLiveBundleResourceManager.h"
#import "UIImageView+WebCache.h"

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
    
    UIImage *image = [BidLiveBundleResourceManager getBundleImage:@"iconicon-play" type:@"png"];
    self.videoIconImageView.image = image;
    self.videoImageView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setModel:(BidLiveHomeHotCourseListModel *)model {
    _model = model;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:nil];
    self.videoNameLabel.text = model.courseSubjectName;
    self.authNameLabel.text = model.anchorName;
    if (model.updatedCount<model.contentCount) {
        self.countLabel.text = [NSString stringWithFormat:@"更新至%ld期 · 共%ld期  |  %ld观看",model.updatedCount,model.contentCount,model.playCount];
    }else {
        self.countLabel.text = [NSString stringWithFormat:@"共%ld期全  |  %ld观看",model.contentCount,model.playCount];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
