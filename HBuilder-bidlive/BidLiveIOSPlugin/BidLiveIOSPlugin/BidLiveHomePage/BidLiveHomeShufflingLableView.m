//
//  BidLiveHomeShufflingLableView.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveHomeShufflingLableView.h"

@interface BidLiveHomeShufflingLableView () <UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *subViewArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, copy) NSArray  *labelArray;
@property (nonatomic, strong) NSTimer *__nullable timer;
@property (nonatomic, assign) SHRollingDirection direction;
@end

@implementation BidLiveHomeShufflingLableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentPage = 0;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self removeGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

- (void)setTextArray:(NSArray<NSString *> *)dataArray InteralTime:(NSTimeInterval)time Direction:(SHRollingDirection)direction
{
    if (dataArray.count == 0) return;
    _direction = direction;
    _labelArray = dataArray;            ///初始化控件
    if (_labelArray.count == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.text = _labelArray.lastObject;
        label.font = [UIFont boldSystemFontOfSize:13];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panClick)]];
        [self addSubview:label];
    }else{
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*3);
//        [self setContentOffset:CGPointMake(0, self.frame.size.height)];
        [self.subViewArray removeAllObjects];
        for (NSInteger i = 0; i < 3; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*i, self.frame.size.width, self.frame.size.height)];
            label.text = _labelArray[i == 0 ? [self getLessNum] : i == 1 ? self.currentPage : [self getMoreNum]];
            label.userInteractionEnabled = YES;
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panClick)]];
            [self addSubview:label];
            [self.subViewArray addObject:label];
        }
        if (_labelArray.count > 1 && time > 0) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];
            NSRunLoop *runloop = [NSRunLoop currentRunLoop];
            [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
    }
}

-(void)scrollAction {
    [self setContentOffset:CGPointMake(0, self.direction == SHRollingDirectionUp ? self.frame.size.height*2 : 0) animated:YES];
}

- (void)panClick{
    !self.didSelect ? : self.didSelect(self.currentPage,self.labelArray[_currentPage]);
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x == 2 * self.frame.size.width) {
        [self layoutSubview];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x == 2 * self.frame.size.width) {
        [self layoutSubview];
    }
}
- (void)layoutSubview
{
    if (self.contentOffset.y == 0) {
        _currentPage = [self getLessNum];
        [self.subViewArray exchangeObjectAtIndex:0 withObjectAtIndex:self.subViewArray.count-1];
        [self.subViewArray exchangeObjectAtIndex:1 withObjectAtIndex:self.subViewArray.count-1];
        UILabel *label = self.subViewArray.firstObject;
        label.text = self.labelArray[[self getLessNum]];
    }else{
        _currentPage = [self getMoreNum];
        [self.subViewArray exchangeObjectAtIndex:1 withObjectAtIndex:self.subViewArray.count-1];
        [self.subViewArray exchangeObjectAtIndex:0 withObjectAtIndex:self.subViewArray.count-1];
        UILabel *label = self.subViewArray.lastObject;
        label.text = self.labelArray[[self getMoreNum]];
    }
    NSInteger coun = self.subViewArray.count;
    for (NSInteger i = 0; i < coun; i++) {
        UILabel *label = self.subViewArray[i];
        label.frame = CGRectMake(0, self.frame.size.height*i, self.frame.size.width, self.frame.size.height);
    }
    [self setContentOffset:CGPointMake(0, self.frame.size.height)];
}

-(void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - lazy
- (NSMutableArray *)subViewArray
{
    if (!_subViewArray) {
        _subViewArray = [NSMutableArray array];
    }
    return _subViewArray;
}
#pragma mark - customMetod
- (NSInteger)getMoreNum{
    return _currentPage == _labelArray.count-1 ? 0 : _currentPage+1;
}
- (NSInteger)getLessNum{
    return _currentPage == 0 ? _labelArray.count-1 : _currentPage-1;
}

@end
