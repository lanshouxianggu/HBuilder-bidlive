//
//  BidLiveBundleRecourseManager.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveBundleRecourseManager : NSObject
+(UIImage *)getBundleImage:(NSString *)imageName type:(NSString *)type;
+(UINib *)getBundleNib:(NSString *)nibName type:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
