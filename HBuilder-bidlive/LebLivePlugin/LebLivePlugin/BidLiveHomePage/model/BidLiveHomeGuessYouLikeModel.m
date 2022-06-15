//
//  BidLiveHomeGuessYouLikeModel.m
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import "BidLiveHomeGuessYouLikeModel.h"
#import "MJExtension.h"

@implementation BidLiveHomeGuessYouLikeModel

+(NSDictionary *)mj_objectClassInArray {
    return @{@"list":[BidLiveHomeGuessYouLikeListModel class]};
}

@end

@implementation BidLiveHomeGuessYouLikeListModel

@end
