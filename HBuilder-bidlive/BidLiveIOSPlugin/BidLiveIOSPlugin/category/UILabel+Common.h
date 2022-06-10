//
//  UILabel+Common.h
//  ChatClub
//
//  Created by ArcherMind on 2020/6/18.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Common)
+(NSInteger)getLineCountOfStringInLabel:(UILabel *)label;
+(CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
