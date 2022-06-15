//
//  BidLiveHomeScrollLiveBtnView.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScrollLiveBtnView.h"
#import "LCConfig.h"
#import "Masonry.h"
#import "BidLiveBundleRecourseManager.h"

@interface BidLiveHomeScrollLiveBtnView ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation BidLiveHomeScrollLiveBtnView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title direction:(ArrowDirection)arrowDirection {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 15;
        UILabel *label = [UILabel new];
        label.text = title;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGB(0x666666);
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(13);
        }];
        
        UIImage *image = [BidLiveBundleRecourseManager getBundleImage:@"more" type:@"png"];
        UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
        self.imageView = imageV;
        [self addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.right.offset(-10);
            make.width.height.mas_equalTo(14);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        
        CGFloat angle = 0;
        switch (arrowDirection) {
            case ArrowDirectionRight:angle=0;break;
            case ArrowDirectionUp:angle=-M_PI_2;break;
            case ArrowDirectionDown:angle=M_PI_2;break;
            case ArrowDirectionLeft:angle=M_PI;
            default:
                break;
        }
        [self setImageViewRotate:angle];
    }
    return self;
}

-(void)setImageViewRotate:(CGFloat)angle {
    self.imageView.transform = CGAffineTransformMakeRotation(angle);
}

-(void)btnAction {
    !self.clickBock?:self.clickBock();
}

@end
