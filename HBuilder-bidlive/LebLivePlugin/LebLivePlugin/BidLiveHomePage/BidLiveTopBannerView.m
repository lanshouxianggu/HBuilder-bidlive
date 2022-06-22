//
//  BidLiveTopBannerView.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveTopBannerView.h"
#import "LCConfig.h"

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
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.contentOffset = CGPointMake(frame.size.width, 0);
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        self.pageControl.currentPage = 0;
        self.pageControl.pageIndicatorTintColor = UIColorFromRGB(0x666666);
        self.pageControl.currentPageIndicatorTintColor = UIColorFromRGB(0x69B2D2);
        self.pageControl.userInteractionEnabled = NO;
        
        [self startTimer];
    }
    return self;
}

-(void)startTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollIamge) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)updateBannerArray:(NSArray<BidLiveHomeBannerModel *> *)bannerArray {
    [self.imgArray removeAllObjects];
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.imgArray addObject:[bannerArray lastObject]];
    [self.imgArray addObjectsFromArray:bannerArray];
    [self.imgArray addObject:[bannerArray firstObject]];
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*self.imgArray.count, self.frame.size.height);
    UIImage *placeholderImage = [BidLiveBundleResourceManager getBundleImage:@"banner_lodding" type:@"png"];
    for (int i = 0; i<self.imgArray.count; i++) {
        BidLiveHomeBannerModel *mode = self.imgArray[i];
        CGRect imgFrame = CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
        [imgView sd_setImageWithURL:[NSURL URLWithString:mode.imageUrl] placeholderImage:placeholderImage];
        [self.scrollView addSubview:imgView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = imgFrame;
        [btn addTarget:self action:@selector(imageViewTapGes:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
    }
    self.pageControl.numberOfPages = bannerArray.count;
    
    [self startTimer];
}

-(void)destroyTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)resumeTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollIamge) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - banner点击
-(void)imageViewTapGes:(UIButton *)btn {
    !self.bannerClick?:self.bannerClick(self.imgArray[btn.tag]);
}

#pragma mark - UIScrollViewDelegate
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
