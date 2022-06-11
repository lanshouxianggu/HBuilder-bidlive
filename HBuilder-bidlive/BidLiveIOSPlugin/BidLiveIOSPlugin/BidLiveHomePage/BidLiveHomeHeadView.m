//
//  BidLiveHomeHeadView.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveHomeHeadView.h"
#import "Masonry.h"
#import "LCConfig.h"
#import "DCSVProgressHUD.h"
#import "BidLiveBundleRecourseManager.h"

@interface BidLiveHomeHeadView ()

@end

@implementation BidLiveHomeHeadView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGBA(0xf2f2f2, 0);
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *searchView = [UIView new];
    searchView.backgroundColor = UIColor.whiteColor;
    searchView.layer.cornerRadius = 15;
    searchView.layer.masksToBounds = YES;
    
    [self addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.bottom.offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *lab = [UILabel new];
    lab.text = @"请输入关键字搜索";
    lab.textColor = UIColorFromRGB(0x666666);
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    
    [searchView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.centerX.offset(10);
    }];
    
    UIImage *image = [BidLiveBundleRecourseManager getBundleImage:@"iconfont-sousuo" type:@"png"];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    
    [searchView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15);
        make.centerY.offset(0);
        make.right.equalTo(lab.mas_left).offset(-8);
    }];
    
    UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchBtn addTarget:self action:@selector(touchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:touchBtn];
    [touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

-(void)touchBtnAction {
    !self.searchClickBlock?:self.searchClickBlock();
}

@end
