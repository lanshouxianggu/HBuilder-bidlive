//
//  BidLiveHomeScrollLiveBtnView.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ArrowDirectionRight,
    ArrowDirectionUp,
    ArrowDirectionDown,
    ArrowDirectionLeft,
} ArrowDirection;

@interface BidLiveHomeScrollLiveBtnView : UIView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title direction:(ArrowDirection)arrowDirection;
@property (nonatomic, copy) void (^clickBock)(void);
@end

NS_ASSUME_NONNULL_END
