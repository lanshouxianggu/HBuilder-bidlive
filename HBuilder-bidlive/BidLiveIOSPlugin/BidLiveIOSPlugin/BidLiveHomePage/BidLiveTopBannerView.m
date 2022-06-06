//
//  BidLiveTopBannerView.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveTopBannerView.h"

@interface BidLiveTopBannerView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *__nullable timer;
@end

@implementation BidLiveTopBannerView

-(instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)array {
    if (self = [super initWithFrame:frame]) {
        self.imgArray = [NSMutableArray array];
        [self.imgArray addObject:[array lastObject]];
        [self.imgArray addObjectsFromArray:array];
        [self.imgArray addObject:[array firstObject]];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.contentSize = CGSizeMake(frame.size.width*self.imgArray.count, frame.size.height);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.contentOffset = CGPointMake(frame.size.width, 0);
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
        for (int i = 0; i<self.imgArray.count; i++) {
            CGRect imgFrame = CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height);
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
            imgView.backgroundColor = self.imgArray[i];
            [self.scrollView addSubview:imgView];
        }
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
        self.pageControl.numberOfPages = array.count;
        self.pageControl.currentPage = 0;
        self.pageControl.tintColor = UIColor.whiteColor;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollIamge) userInfo:nil repeats:YES];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    offsetX+=scrollView.frame.size.width*0.5;
    
    //因为最前面还有一个imgView
    int page = offsetX/scrollView.frame.size.width-1;
    self.pageControl.currentPage=page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollIamge) userInfo:nil repeats:YES];
    
    //优先级 设置到当前的runloop中
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
        //当滑倒3后面的1时
        if (offset.x >= self.scrollView.contentSize.width-self.scrollView.frame.size.width) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
            self.pageControl.currentPage = 0;
        }
        //当滑倒1前面的3时
        else if (offset.x <= 0) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width-2*self.scrollView.frame.size.width, 0)];
            self.pageControl.currentPage = self.pageControl.numberOfPages-1;
        }
    }
}

-(void)scrollIamge {
    NSInteger page = [self.pageControl currentPage];
    page++;
    CGFloat offsetX = page*self.scrollView.frame.size.width+self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

-(void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end
