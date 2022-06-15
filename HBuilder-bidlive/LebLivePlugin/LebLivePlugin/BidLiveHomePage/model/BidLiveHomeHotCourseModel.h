//
//  BidLiveHomeHotCourseModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeHotCourseListModel : NSObject
@property (nonatomic, copy) NSString *courseSubjectName;
@property (nonatomic, copy) NSString *coverUrl;
@property (nonatomic, copy) NSString *anchorName;
@property (nonatomic, copy) NSString *anchorCompany;
@property (nonatomic, assign) NSInteger courseId;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, assign) NSInteger contentCount;
@property (nonatomic, assign) NSInteger updatedCount;
@end

@interface BidLiveHomeHotCourseModel : NSObject
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSArray <BidLiveHomeHotCourseListModel *> *list;
@end

NS_ASSUME_NONNULL_END
