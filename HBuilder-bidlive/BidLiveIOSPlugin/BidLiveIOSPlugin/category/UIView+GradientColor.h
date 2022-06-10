//
//  UIView+GradientColor.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/6/10.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ///上-->下
    GradientDirectionToDown,
    ///左-->右
    GradientDirectionToRight,
    ///左上-->右下
    GradientDirectionToLowerLeft,
    ///右上至左下
    GradientDirectionToLowerRight,
} GradientDirectionType;

@interface UIView (GradientColor)
-(void)gradientFromColor:(UIColor *)fromColr toColor:(UIColor *)toColor directionType:(GradientDirectionType)directionType;
@end

NS_ASSUME_NONNULL_END
