//
//  BidLiveHomeMainView.m
//  LiveFloatPlugin
//
//  Created by bidlive on 2022/5/26.
//

#import "BidLiveHomeMainView.h"
#import "BidLiveHomeHeadView.h"
#import "BidLiveHomeFirstCell.h"
#import "BidLiveHomeFirstTableViewCell.h"
#import "BidLiveHomeFloatView.h"
#import "Masonry.h"
#import "LCConfig.h"
#import "BidLiveBundleRecourseManager.h"
#import "BidLiveHomeScrollYouLikeMainView.h"

#define kTopMainBannerViewHeight (UIApplication.sharedApplication.statusBarFrame.size.height>20?210:180)

#define kAnimationViewHeight (SCREEN_WIDTH*72/585)
#define kTopMainViewHeight (kTopMainBannerViewHeight+100+10+kAnimationViewHeight+10+SCREEN_HEIGHT*0.18)

#define kLiveNormalCellHeight ((SCREEN_WIDTH-30)*218.5/537)
#define kLiveCenterImageCellHeight ((SCREEN_WIDTH-30)*138.5/537)
//#define kLiveMainViewHeight (140*8+90+90+70+110)
#define kLiveMainViewHeight (kLiveNormalCellHeight*8+90+kLiveCenterImageCellHeight+10+70+kLiveCenterImageCellHeight)

#define kAnchorCellHeight ((SCREEN_WIDTH-30)*11/18-10)

#define kAnchorMainViewHeight (90+4*kAnchorCellHeight+60)

#define kSpeechCellHeight (SCREEN_WIDTH-30)*405.5/537
#define kSpeechMainViewHeight (70+kSpeechCellHeight+60)

#define kYouLikeHeadViewHeight ((SCREEN_WIDTH-30)*138.5/537+20)
//#define kYouLikeMainViewHeight (110+5*280+4*10)
#define kYouLikeMainViewHeight (kYouLikeHeadViewHeight+5*280+4*10)

#define kHightlightLotsMainViewHeight (SCREEN_WIDTH*0.689+90)

@interface BidLiveHomeMainView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BidLiveHomeHeadView *topSearchView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BidLiveHomeFloatView *floatView;
///猜你喜欢
@property (nonatomic, strong) BidLiveHomeScrollYouLikeMainView *youlikeMainView;

///猜你喜欢当前页码(无序)
@property (nonatomic, assign) int youlikePageIndex;
///猜你喜欢当前页码(有序)
@property (nonatomic, assign) int youlikePageNormalIndex;
@property (nonatomic, strong) NSMutableArray *youlikePageIndexArray;
@property (nonatomic, strong) NSArray *youlikeBannerArray;
@property (nonatomic, assign) CGFloat youlikeContainAllBannersHeight;
///是否下拉刷新
@property (nonatomic, assign) BOOL isPullRefresh;
@end

@implementation BidLiveHomeMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0xf8f8f8);
        [self initData];
        [self setupUI];
        [self loadData];
    }
    return self;
}


-(void)setupUI {
    [self addSubview:self.tableView];
    //用@available方法在编译库打包的时候会报错Undefined symbols "__isPlatformVersionAtLeast"
//    if (@available(iOS 15.0, *)) {
//        self.tableView.sectionHeaderTopPadding = 0;
//    } else {
//        // Fallback on earlier versions
//    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 15.0) {
        self.tableView.sectionHeaderTopPadding = 0;
    }
    [self addSubview:self.topSearchView];
    
    [self addSubview:self.floatView];
}

#pragma mark - 初始化
-(void)initData {
//    self.speechPageIndex = 1;
//    self.anchorPageIndex = 1;
    self.youlikePageIndex = 0;
    self.youlikePageNormalIndex = 0;
    self.youlikeContainAllBannersHeight = 0.0;
    self.youlikePageIndexArray = [NSMutableArray array];
}

#pragma mark - 加载数据
-(void)loadData {
    [self loadBannerData];
//    [self loadCMSArticleData];
//    [self loadGlobalLiveData];
//    [self loadHomeHotCourseData];
//    [self loadHomeVideoGuaideData];
//    [self loadHomeAnchorListData];
    [self loadGuessYouLikeListData];
//    [self loadHomeHighliahtLotsListData];
}

#pragma mark - 加载广告轮播数据
-(void)loadBannerData {
    WS(weakSelf)
    //顶部banner
    [BidLiveHomeNetworkModel getHomePageBannerList:11 client:@"wx" completion:^(NSArray<BidLiveHomeBannerModel *> * _Nonnull bannerList) {
//        [weakSelf.topMainView updateBanners:bannerList];
    }];
    
    //全球直播banner
    [BidLiveHomeNetworkModel getHomePageBannerList:12 client:@"wx" completion:^(NSArray<BidLiveHomeBannerModel *> * _Nonnull bannerList) {
//        [weakSelf.liveMainView updateBannerArray:bannerList];
    }];
    
    //猜你喜欢banner
    [BidLiveHomeNetworkModel getHomePageBannerList:22 client:@"app" completion:^(NSArray<BidLiveHomeBannerModel *> * _Nonnull bannerList) {
        weakSelf.youlikeBannerArray = bannerList;
    }];
}

#pragma mark - 加载更多猜你喜欢数据
-(void)loadMoreData {
    if (self.youlikePageIndexArray.firstObject) {
        int currentPage = [[self.youlikePageIndexArray firstObject] intValue];
        self.youlikePageIndex = currentPage;
        [self loadGuessYouLikeListData];
//        [self.youlikePageIndexArray removeObjectAtIndex:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
    }
}

#pragma mark - 加载猜你喜欢列表数据
-(void)loadGuessYouLikeListData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageGuessYouLikeList:self.youlikePageIndex completion:^(BidLiveHomeGuessYouLikeModel * _Nonnull model) {
        NSLog(@"猜你喜欢列表数据加载：%d 随机下标：%d",weakSelf.youlikePageNormalIndex,weakSelf.youlikePageIndex);
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:model.list];
        CGFloat origionHight = CGRectGetHeight(weakSelf.youlikeMainView.frame);
        if (weakSelf.isPullRefresh) {
            [weakSelf.youlikeMainView.likesArray removeAllObjects];
        }
        
        NSInteger firstPageIndex = model.pageIndex;
        NSMutableArray *tempPageArr = [NSMutableArray array];
        for (int i=1; i<= model.pageCount; i++) {
            if (i != firstPageIndex) {
                [tempPageArr addObject:@(i)];
            }
        }
        NSArray *sortedArr = [weakSelf shuffle:tempPageArr];
        if (weakSelf.youlikePageIndexArray.count <= 1) {
            [weakSelf.youlikePageIndexArray addObjectsFromArray:sortedArr];
        }
        
        if (weakSelf.youlikePageIndex==0 && model.list.count>10) {
            [weakSelf.youlikeMainView.likesArray removeAllObjects];
            NSRange range1 = NSMakeRange(0, 10);
            NSRange range2 = NSMakeRange(10, model.list.count-10);
            NSArray *array1 = [tempArray subarrayWithRange:range1];
            NSArray *array2 = [tempArray subarrayWithRange:range2];
            [weakSelf.youlikeMainView.likesArray addObject:array1];
            [weakSelf.youlikeMainView.likesArray addObject:array2];
            weakSelf.youlikePageNormalIndex = 1;
            if (weakSelf.youlikeBannerArray.count) {
                [weakSelf.youlikeMainView.bannerArray addObject:weakSelf.youlikeBannerArray[weakSelf.youlikePageNormalIndex]];
            }
        }else {
            if (model.list) {
                if (weakSelf.youlikePageNormalIndex < weakSelf.youlikeBannerArray.count) {
                    [weakSelf.youlikeMainView.bannerArray addObject:weakSelf.youlikeBannerArray[weakSelf.youlikePageNormalIndex]];
                    [weakSelf.youlikeMainView.likesArray addObject:model.list];
                }else {
                    NSArray *lastPageIndexArray = [weakSelf.youlikeMainView.likesArray lastObject];
                    NSMutableArray *lastArray = [NSMutableArray arrayWithArray:lastPageIndexArray];
                    [lastArray addObjectsFromArray:model.list];
//                    weakSelf.youlikeMainView.likesArray[weakSelf.youlikePageNormalIndex] = lastArray;
                    if (lastPageIndexArray) {
                        NSInteger lastIndex = weakSelf.youlikeMainView.likesArray.count-1;
                        [weakSelf.youlikeMainView.likesArray replaceObjectAtIndex:lastIndex withObject:lastArray];
                    }else {
                        [weakSelf.youlikeMainView.likesArray addObject:model.list];
                    }
                }
            }
            origionHight+= (kYouLikeHeadViewHeight+(model.list.count/2)*280+4*10);
        }
//        CGFloat youlikeViewMinY = CGRectGetMinY(self.youlikeMainView.frame);
//        CGFloat youlikeViewMaxY = CGRectGetMaxY(self.youlikeMainView.frame);
        
        
        NSInteger likesArrayCount = weakSelf.youlikeMainView.likesArray.count;
        NSInteger likesBannerCount = weakSelf.youlikeBannerArray.count;
        CGFloat height = 0;
        if (weakSelf.youlikePageNormalIndex < likesBannerCount) {
            height = (likesArrayCount*kYouLikeMainViewHeight)+20;
            NSLog(@"hight before:%f",height);
            [weakSelf.youlikeMainView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            weakSelf.youlikeContainAllBannersHeight = height;
        }else {
            NSInteger moreCount = weakSelf.youlikePageNormalIndex+1-likesBannerCount;
            height = weakSelf.youlikeContainAllBannersHeight + (moreCount*(5*280+4*10))+20;
            NSLog(@"hight after:%f",height);
            [weakSelf.youlikeMainView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
        }
        weakSelf.youlikePageNormalIndex++;
        [weakSelf.youlikePageIndexArray removeObjectAtIndex:0];
        
//        CGPoint offset = weakSelf.youlikeMainView.collectionView.contentOffset;
//        [weakSelf.youlikeMainView.collectionView reloadData];
//        [weakSelf.youlikeMainView.layout invalidateLayout];
//        [weakSelf.youlikeMainView.collectionView layoutIfNeeded];
//        [weakSelf.youlikeMainView.collectionView setContentOffset:offset];
        
        [CATransaction setDisableActions:YES];
        [weakSelf.youlikeMainView.collectionView reloadData];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
        [weakSelf.tableView reloadData];
        [CATransaction commit];
    }];
}

-(NSArray *)shuffle:(NSMutableArray *)array {
    NSArray *tempArr = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return 1;
        }else {
            return -1;
        }
    }];
    return tempArr;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return kTopMainViewHeight;
    }
    if (indexPath.section==1) {
        return 200;
    }
    if (indexPath.section==3) {
        return UITableViewAutomaticDimension;
    }
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    }
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [UIView new];
    headView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    
    if (section==1 || section==2) {
        UIImage *image = [BidLiveBundleRecourseManager getBundleImage:section==1?@"special":@"classroom" type:@"png"];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
        [headView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.width.mas_equalTo(44*3.35);
            make.height.mas_equalTo(44);
        }];
    }
    if (section==3) {
        UILabel *label = (UILabel *)[headView viewWithTag:100];
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 60)];
            label.tag = 100;
            label.text = @"猜 你 喜 欢";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColor.blackColor;
            label.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];

            [headView addSubview:label];
        }
    }
    
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        BidLiveHomeFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BidLiveHomeFirstCell" forIndexPath:indexPath];
//        BidLiveHomeFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BidLiveHomeFirstTableViewCell" forIndexPath:indexPath];
//        if (!cell) {
//            cell = [[BidLiveHomeFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BidLiveHomeFirstTableViewCell"];
//        }
//        WS(weakSelf)
//        [cell setGlobalSaleClickBlock:^{
//            !weakSelf.globalSaleClickBlock?:weakSelf.globalSaleClickBlock();
//        }];
//
//        [cell setAppraisalClickBlock:^{
//            !weakSelf.appraisalClickBlock?:weakSelf.appraisalClickBlock();
//        }];
//
//        [cell setCountrySaleClickBlock:^{
//            !weakSelf.countrySaleClickBlock?:weakSelf.countrySaleClickBlock();
//        }];
//
//        [cell setSendClickBlock:^{
//            !weakSelf.sendClickBlock?:weakSelf.sendClickBlock();
//        }];
//
//        [cell setSpeechClassClickBlock:^{
//            !weakSelf.speechClassClickBlock?:weakSelf.speechClassClickBlock();
//        }];
//
//        [cell setInformationClickBlock:^{
//            !weakSelf.informationClickBlock?:weakSelf.informationClickBlock();
//        }];
        return cell;
    }
    if (indexPath.section==3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.contentView addSubview:self.youlikeMainView];
        [self.youlikeMainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<CGRectGetHeight(self.topSearchView.frame)) {
        CGFloat alpha = offsetY/CGRectGetHeight(self.topSearchView.frame);
        NSLog(@"alpha = %f",alpha);
        self.topSearchView.backgroundColor = UIColorFromRGBA(0xf2f2f2, alpha);
    }else {
        self.topSearchView.backgroundColor = UIColorFromRGBA(0xf2f2f2,1);
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.15 animations:^{
        self.floatView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
       [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
       // 停止类型3
       BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
       if (dragToDragStop) {
          [self scrollViewDidEndScroll];
       }
  }
}

#pragma mark - scrollView 停止滚动监测
- (void)scrollViewDidEndScroll {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.15 animations:^{
            self.floatView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    });
}


#pragma mark - lazy
-(UITableView *)tableView {
    if (!_tableView) {
        CGFloat origionY = 0;
        if (UIApplication.sharedApplication.statusBarFrame.size.height>20) {
            origionY = -UIApplication.sharedApplication.statusBarFrame.size.height;
        }
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, origionY, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:BidLiveHomeFirstTableViewCell.class forCellReuseIdentifier:@"BidLiveHomeFirstTableViewCell"];
    
        UINib *nib = [BidLiveBundleRecourseManager getBundleNib:@"BidLiveHomeFirstCell" type:@"nib"];
        
        [_tableView registerNib:nib forCellReuseIdentifier:@"BidLiveHomeFirstCell"];
        
        WS(weakSelf)
        MJRefreshNormalHeader *refreshHead = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.isPullRefresh = YES;
//            [weakSelf refreshData];
        }];
        refreshHead.backgroundColor = [UIColor clearColor];
        
        refreshHead.lastUpdatedTimeLabel.hidden = YES;
        refreshHead.stateLabel.hidden = YES;
        _tableView.mj_header = refreshHead;
        
        MJRefreshAutoFooter *refreshFoot = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            weakSelf.isPullRefresh = NO;
            [weakSelf loadMoreData];
        }];
        refreshFoot.triggerAutomaticallyRefreshPercent = -50;
        refreshFoot.onlyRefreshPerDrag = YES;
        _tableView.mj_footer = refreshFoot;
    }
    return _tableView;
}

-(BidLiveHomeHeadView *)topSearchView {
    if (!_topSearchView) {
        _topSearchView = [[BidLiveHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _topSearchView;
}

-(BidLiveHomeFloatView *)floatView {
    if (!_floatView) {
        _floatView = [[BidLiveHomeFloatView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-30, SCREEN_HEIGHT-130, 60, 60)];
    }
    return _floatView;
}

-(BidLiveHomeScrollYouLikeMainView *)youlikeMainView {
    if (!_youlikeMainView) {
        _youlikeMainView = [[BidLiveHomeScrollYouLikeMainView alloc] initWithFrame:CGRectZero];
        _youlikeMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        WS(weakSelf)
        [_youlikeMainView setLoadMoreGuessYouLikeDataBlock:^{
//            [weakSelf loadMoreData];
        }];
        
//        [_youlikeMainView setYouLikeViewScrollToTopBlock:^{
//            weakSelf.superCanScroll = YES;
//            weakSelf.mainScrollView.showsVerticalScrollIndicator = YES;
//        }];
    }
    return _youlikeMainView;
}
@end
