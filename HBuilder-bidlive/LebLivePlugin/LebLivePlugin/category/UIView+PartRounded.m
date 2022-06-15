//
//  UIView+PartRounded.m
//  YFLive2018
//
//  Created by YF on 2019/6/5.
//  Copyright © 2019 liushong. All rights reserved.
//

#import "UIView+PartRounded.h"

@implementation UIView (PartRounded)

- (void)addRoundedCorners:(UIRectCorner)corners withSize:(CGSize)size {
    
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

- (void)addRoundedCorners:(UIRectCorner)corners withSize:(CGSize)size viewRect:(CGRect)rect {
    
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

@end
