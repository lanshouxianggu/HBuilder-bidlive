//
//  BidLiveSimultaneouslyScrollView.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/6/15.
//

#import "BidLiveSimultaneouslyScrollView.h"

@interface BidLiveSimultaneouslyScrollView () <UIGestureRecognizerDelegate>

@end

@implementation BidLiveSimultaneouslyScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}
@end
