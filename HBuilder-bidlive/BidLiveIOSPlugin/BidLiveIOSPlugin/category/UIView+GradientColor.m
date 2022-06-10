//
//  UIView+GradientColor.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/6/10.
//

#import "UIView+GradientColor.h"

@implementation UIView (GradientColor)
-(void)gradientFromColor:(UIColor *)fromColr toColor:(UIColor *)toColor directionType:(GradientDirectionType)directionType {
    NSArray *colors = [NSArray arrayWithObjects:(id)fromColr.CGColor,toColor.CGColor, nil];
    
    CAGradientLayer *gradientBG = [CAGradientLayer layer];
    if (directionType == GradientDirectionToRight) {
        gradientBG.startPoint = CGPointMake(0.0, 0);
        gradientBG.endPoint = CGPointMake(1, 0);
    } else if (directionType == GradientDirectionToDown) {
        gradientBG.startPoint = CGPointMake(0.0, 0);
        gradientBG.endPoint = CGPointMake(0.0, 1.0);
    } else if (directionType == GradientDirectionToLowerRight) {
        gradientBG.startPoint = CGPointMake(0.0, 0);
        gradientBG.endPoint = CGPointMake(1.0, 1.0);
    } else if (directionType == GradientDirectionToLowerLeft) {
        gradientBG.startPoint = CGPointMake(1.0, 0);
        gradientBG.endPoint = CGPointMake(0, 1.0);
    }
    gradientBG.colors = colors;
    gradientBG.frame = self.bounds;
    
    [self.layer insertSublayer:gradientBG atIndex:0];
}
@end
