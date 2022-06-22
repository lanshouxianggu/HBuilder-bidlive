//
//  BidLiveBundleResourceManager.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/28.
//

#import "BidLiveBundleResourceManager.h"

@implementation BidLiveBundleResourceManager
+(UIImage *)getBundleImage:(NSString *)imageName type:(NSString *)type {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"BidLiveBundle" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [bundle pathForResource:imageName ofType:type];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    
    return [UIImage imageWithData:imageData];
}

+(UINib *)getBundleNib:(NSString *)nibName type:(NSString *)type {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"BidLiveBundle" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *nibPath = [bundle pathForResource:nibName ofType:type];
    NSData *nibData = [NSData dataWithContentsOfFile:nibPath];
    UINib *nib = [UINib nibWithData:nibData bundle:nil];
    
    return nib;
}
@end
