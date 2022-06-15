//
//  NSAttributedString+LLMake.m
//  ChatClub
//
//  Created by ArcherMind on 2020/6/28.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "NSAttributedString+LLMake.h"

@implementation NSAttributedString (LLMake)

+(NSAttributedString *)makeAttributedString:(void (NS_NOESCAPE^)(LLAttributedStringMaker * _Nonnull))block {
    LLAttributedStringMaker *make = [[LLAttributedStringMaker alloc] init];
    block(make);
    return [make install];
}

@end

@interface LLAttributedStringMaker()
@property (nonatomic, strong) LLAttributedStringChain *chain;
@end

@implementation LLAttributedStringMaker

-(LLAttributedStringChain * _Nonnull (^)(NSString * _Nonnull))text {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *text) {
        if (text.length == 0) {
            return @" ";
        }
        __strong typeof(self) self = weakSelf;
        self.chain.text = text;
        [self.chain buildSubAttributedString];
        return self.chain;
    };
}

-(NSAttributedString *)install {
    NSMutableAttributedString *mutableAttrStr = [[NSMutableAttributedString alloc] init];
    NSArray<NSMutableAttributedString *> *attributedStrings = [self.chain.attributedStrings copy];
    for (NSMutableAttributedString *attrStr in attributedStrings) {
        [mutableAttrStr appendAttributedString:attrStr.copy];
    }
    return mutableAttrStr.copy;
}


-(LLAttributedStringChain *)chain {
    if (!_chain) {
        _chain = [[LLAttributedStringChain alloc] init];
    }
    return _chain;
}

@end

@interface LLAttributedStringChain()
@property (nonatomic, strong) NSMutableArray<NSMutableAttributedString *> *attributedStrings;
@property (nonatomic, strong) NSMutableAttributedString *currentAttributedString;
 
@end

@implementation LLAttributedStringChain

- (NSMutableArray<NSMutableAttributedString *> *)attributedStrings {
    if (!_attributedStrings) {
        _attributedStrings = [NSMutableArray array];
    }
    return _attributedStrings;
}

- (void)buildSubAttributedString {
    if (!self.text) { return; }
    self.currentAttributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [self.attributedStrings addObject:self.currentAttributedString];
}

- (LLAttributedStringChain *)addAttribute:(NSAttributedStringKey)key value:(id)value {
    [self.currentAttributedString addAttribute:key value:value range:NSMakeRange(0, self.text.length)];
    return self;
}

-(LLAttributedStringChain * _Nonnull (^)(UIColor * _Nonnull))foregroundColor {
    return ^id(UIColor *color) {
        return [self addAttribute:NSForegroundColorAttributeName value:color];
    };
}

-(LLAttributedStringChain * _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^id(UIColor *color) {
        return [self addAttribute:NSBackgroundColorAttributeName value:color];
    };
}

-(LLAttributedStringChain * _Nonnull (^)(UIFont * _Nonnull))font {
    return ^id(UIFont *font) {
        return [self addAttribute:NSFontAttributeName value:font];
    };
}

- (LLAttributedStringChain * (^)(NSUnderlineStyle))underline {
    return ^id(NSUnderlineStyle style) {
        return [self addAttribute:NSUnderlineStyleAttributeName value:@(style)];
    };
}

- (LLAttributedStringChain * (^)(UIColor *))underlineColor {
    return ^id(UIColor *color) {
        return [self addAttribute:NSUnderlineColorAttributeName value:color];
    };
}

- (LLAttributedStringChain * (^)(CGFloat))baseline {
    return ^id(CGFloat offset) {
        return [self addAttribute:NSBaselineOffsetAttributeName value:@(offset)];
    };
}

- (LLAttributedStringChain * (^)(NSUnderlineStyle))strike {
    return ^id(NSUnderlineStyle style) {
        return [self addAttribute:NSStrikethroughStyleAttributeName value:@(style)];
    };
}

- (LLAttributedStringChain * (^)(UIColor *))strikeColor {
    return ^id(UIColor *color) {
        return [self addAttribute:NSStrikethroughColorAttributeName value:color];
    };
}

- (LLAttributedStringChain * (^)(NSParagraphStyle *))paragraphStyle {
    return ^id(NSParagraphStyle *style) {
        return [self addAttribute:NSParagraphStyleAttributeName value:style];
    };
}

- (LLAttributedStringChain * _Nonnull (^)(NSString * _Nonnull))link {
    return ^id(NSString *link) {
        return [self addAttribute:NSLinkAttributeName value:link];
    };
}

@end
