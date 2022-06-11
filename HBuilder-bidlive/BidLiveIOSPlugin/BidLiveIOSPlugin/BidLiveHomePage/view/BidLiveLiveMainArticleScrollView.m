//
//  BidLiveLiveMainArticleScrollView.m
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import "BidLiveLiveMainArticleScrollView.h"
#import "UIImageView+WebCache.h"

@interface BidLiveLiveMainArticleScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *__nullable timer;

@end

@implementation BidLiveLiveMainArticleScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imgArray = [NSMutableArray array];
        
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(frame.size.width, 0);
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
        self.pageControl.hidden = YES;
        [self addSubview:self.pageControl];
    }
    return self;
}

-(void)updateBannerArray:(NSArray<BidLiveHomeCMSArticleModel *> *)bannerArray {
    if (bannerArray.count==0) {
        return;
    }
    [self.imgArray removeAllObjects];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.imgArray addObject:[bannerArray lastObject]];
    [self.imgArray addObjectsFromArray:bannerArray];
    [self.imgArray addObject:[bannerArray firstObject]];
    
    self.contentSize = CGSizeMake(self.frame.size.width*self.imgArray.count, self.frame.size.height);
    for (int i = 0; i<self.imgArray.count; i++) {
        BidLiveHomeCMSArticleModel *mode = self.imgArray[i];
        CGRect imgFrame = CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
//        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.tag = i;
        [imgView sd_setImageWithURL:[NSURL URLWithString:mode.ImageUrl] placeholderImage:nil];
        [self addSubview:imgView];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = imgFrame;
        [btn addTarget:self action:@selector(imageViewTapGes:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }

    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.pageControl.numberOfPages = bannerArray.count;
    self.pageControl.currentPage = 0;
    self.pageControl.tintColor = UIColor.whiteColor;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(scrollIamge) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)imageViewTapGes:(UIButton *)btn {
    !self.bannerClick?:self.bannerClick(self.imgArray[btn.tag]);
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
        CGFloat contentSizeWidth = self.contentSize.width;
        CGFloat scrollWidth = self.frame.size.width;
        //当滑倒3后面的1时
        if (offset.x >= contentSizeWidth-scrollWidth) {
            [self setContentOffset:CGPointMake(self.frame.size.width, 0)];
            self.pageControl.currentPage = 0;
        }
        //当滑倒1前面的3时
        else if (offset.x <= 0) {
            [self setContentOffset:CGPointMake(self.contentSize.width-2*self.frame.size.width, 0)];
            self.pageControl.currentPage = self.pageControl.numberOfPages-1;
        }
    }
}

-(void)scrollIamge {
    NSInteger page = [self.pageControl currentPage];
    page++;
    CGFloat offsetX = page*self.frame.size.width+self.frame.size.width;
    [self setContentOffset:CGPointMake(offsetX, 0) animated:NO];
}

-(void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
