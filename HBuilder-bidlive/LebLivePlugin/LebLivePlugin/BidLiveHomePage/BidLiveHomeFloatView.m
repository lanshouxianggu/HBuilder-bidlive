//
//  BidLiveHomeFloatView.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveHomeFloatView.h"
#import "LCConfig.h"

@implementation BidLiveHomeFloatView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
//    self.layer.cornerRadius = 30;
//    self.layer.shadowColor = UIColor.blackColor.CGColor;
//    self.layer.shadowOffset = CGSizeMake(0, 0);
//    self.layer.shadowRadius = 6;
//    self.layer.shadowOpacity = 0.4;
    
    UIView *mainView = [UIView new];
    mainView.layer.cornerRadius = 30;
    mainView.layer.masksToBounds = YES;
    [self addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIImage *image = [BidLiveBundleResourceManager getBundleImage:@"newauctionicon" type:@"png"];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    [mainView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
    
    [mainView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

-(void)touchAction {
    !self.toNewAuctionClickBlock?:self.toNewAuctionClickBlock();
}

@end
