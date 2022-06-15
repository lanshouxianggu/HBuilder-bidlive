//
//  NSAttributedString+LLMake.h
//  ChatClub
//
//  Created by ArcherMind on 2020/6/28.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LLAttributedStringChain : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableAttributedString*> *attributedStrings;

- (LLAttributedStringChain *(^)(UIColor *color))foregroundColor;
- (LLAttributedStringChain *(^)(UIColor *color))backgroundColor;
- (LLAttributedStringChain *(^)(UIFont *font))font;
- (LLAttributedStringChain *(^)(NSUnderlineStyle style))underline;
- (LLAttributedStringChain *(^)(UIColor *color))underlineColor;
- (LLAttributedStringChain *(^)(CGFloat offset))baseline;
- (LLAttributedStringChain *(^)(NSUnderlineStyle style))strike;
- (LLAttributedStringChain *(^)(UIColor *color))strikeColor;
- (LLAttributedStringChain *(^)(NSParagraphStyle *style))paragraphStyle;
- (LLAttributedStringChain *(^)(NSString *link))link;

-(void)buildSubAttributedString;

@end

@interface LLAttributedStringMaker : NSObject
- (LLAttributedStringChain *(^)(NSString *text))text;
- (NSAttributedString *)install;
@end

@interface NSAttributedString (LLMake)
+ (NSAttributedString *)makeAttributedString:(void(NS_NOESCAPE ^)(LLAttributedStringMaker *make))block;
@end

NS_ASSUME_NONNULL_END
