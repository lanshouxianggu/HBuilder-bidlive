//
//  BidLiveHomeMainViewV2.m
//  LebLivePlugin
//
//  Created by bidlive on 2022/6/24.
//

#import "BidLiveHomeMainViewV2.h"
#import "BidLiveHomeScrollYouLikeCell.h"
#import "BidLiveHomeHeadView.h"
#import "BidLiveHomeFloatView.h"
#import "BidLiveHomeTopView.h"
#import "LCConfig.h"

@interface BidLiveHomeMainViewV2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,assign) CGFloat currOffsetY;

@property (nonatomic, strong) BidLiveHomeHeadView *topSearchView;
@property (nonatomic, strong) BidLiveHomeFloatView *floatView;
@property (nonatomic, strong) BidLiveHomeTopView *headMainView;
@property (nonatomic, assign) CGSize headMainViewSize;

///上一次讲堂视频的数量
@property (nonatomic, assign) NSInteger lastVideosCount;
///名家讲堂当前页码
@property (nonatomic, assign) int speechPageIndex;
///第一页名家讲堂列表数据
@property (nonatomic, strong) NSArray *speechOrigionArray;

///上一次精选主播的数量
@property (nonatomic, assign) NSInteger lastAnchorsCount;
///精选主播当前页码
@property (nonatomic, assign) int anchorPageIndex;
///第一页精选主播列表数据
@property (nonatomic, strong) NSArray *anchorOrigionArray;

///焦点拍品当前页码
@property (nonatomic, assign) int highlightLotsPageIndex;
///焦点拍品列表
@property (nonatomic, strong) NSMutableArray *hightlightLotsList;

///猜你喜欢当前页码(无序)
@property (nonatomic, assign) int youlikePageIndex;
///猜你喜欢当前页码(有序)
@property (nonatomic, assign) int youlikePageNormalIndex;
@property (nonatomic, strong) NSMutableArray *youlikePageIndexArray;
@property (nonatomic, strong) NSArray *youlikeBannerArray;
@property (nonatomic, assign) CGFloat youlikeContainAllBannersHeight;

///是否下拉刷新
@property (nonatomic, assign) BOOL isPullRefresh;
///是否上拉加载
@property (nonatomic, assign) BOOL isLoadMoreData;
@end

@implementation BidLiveHomeMainViewV2

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.likesArray = [NSMutableArray array];
        [self initData];
        [self setupUI];
        [self registerEvent];
        [self loadData];
    }
    return self;
}

#pragma mark - 初始化
-(void)initData {
    self.speechPageIndex = 1;
    self.anchorPageIndex = 1;
    self.youlikePageIndex = 0;
    self.highlightLotsPageIndex = 1;
    self.youlikePageNormalIndex = 0;
//    self.superCanScroll = YES;
//    self.isFirstScroll = YES;
    self.isLoadMoreData = NO;
    self.youlikeContainAllBannersHeight = 0.0;
    self.youlikePageIndexArray = [NSMutableArray array];
    self.hightlightLotsList = [NSMutableArray array];
//    self.headMainViewSize = CGSizeMake(SCREEN_WIDTH, kTopMainViewHeight+80);
    self.headMainViewSize = CGSizeMake(SCREEN_WIDTH, kTopMainViewHeight+kVideoGuaideViewHeight+kLiveMainViewHeight+kAnchorMainViewHeight+kSpeechMainViewHeight+kHightlightLotsMainViewHeight+80);
}

-(void)registerEvent {
    WS(weakSelf)
#pragma mark - 全球拍卖点击事件
    [self.headMainView.topMainView setGlobalSaleClickBlock:^{
        !weakSelf.globalSaleClickBlock?:weakSelf.globalSaleClickBlock();
    }];
#pragma mark - 鉴定点击事件
    [self.headMainView.topMainView setAppraisalClickBlock:^{
        !weakSelf.appraisalClickBlock?:weakSelf.appraisalClickBlock();
    }];
#pragma mark - 国内拍卖点击事件
    [self.headMainView.topMainView setCountrySaleClickBlock:^{
        !weakSelf.countrySaleClickBlock?:weakSelf.countrySaleClickBlock();
    }];
#pragma mark - 送拍点击事件
    [self.headMainView.topMainView setSendClickBlock:^{
        !weakSelf.sendClickBlock?:weakSelf.sendClickBlock();
    }];
#pragma mark - 讲堂点击事件
    [self.headMainView.topMainView setSpeechClassClickBlock:^{
        !weakSelf.speechClassClickBlock?:weakSelf.speechClassClickBlock();
    }];
#pragma mark - 资讯点击事件
    [self.headMainView.topMainView setInformationClickBlock:^{
        !weakSelf.informationClickBlock?:weakSelf.informationClickBlock();
    }];
#pragma mark - 直播间点击事件
    [self.headMainView.topMainView setLiveRoomClickBlock:^{
        !weakSelf.liveRoomClickBlock?:weakSelf.liveRoomClickBlock();
    }];
#pragma mark - 动态点击事件
    [self.headMainView.topMainView setCmsArticleClickBlock:^(BidLiveHomeCMSArticleModel * _Nonnull model) {
        !weakSelf.cmsArticleClickBlock?:weakSelf.cmsArticleClickBlock(model);
    }];
#pragma mark - 视频导览cell点击事件
    [self.headMainView.topMainView setVideoGuaideCellClickBlock:^(BidLiveHomeVideoGuaideListModel * _Nonnull model) {
        !weakSelf.videoGuaideCellClickBlock?:weakSelf.videoGuaideCellClickBlock(model);
    }];
#pragma mark - 全球直播cell点击事件
    [self.headMainView.liveMainView setCellClickBlock:^(BidLiveHomeGlobalLiveModel * _Nonnull model) {
        !weakSelf.globalLiveCellClickBlock?:weakSelf.globalLiveCellClickBlock(model);
    }];
#pragma mark - 全球直播cell上的正在直播点击事件
    [self.headMainView.liveMainView setCellLivingBtnClickBlock:^(BidLiveHomeGlobalLiveModel * _Nonnull model) {
        !weakSelf.globalLiveCellLivingBtnClickBlock?:weakSelf.globalLiveCellLivingBtnClickBlock(model);
    }];
#pragma mark - 全球直播gif动画点击事件
    [self.headMainView.liveMainView setGifImageClickBlock:^(BidLiveHomeBannerModel * _Nonnull model) {
        !weakSelf.bannerClick?:weakSelf.bannerClick(model);
    }];
#pragma mark - 全球直播底部广告点击事件
    [self.headMainView.liveMainView setBottomImageClickBlock:^(BidLiveHomeBannerModel * _Nonnull model) {
        !weakSelf.bannerClick?:weakSelf.bannerClick(model);
    }];
#pragma mark - 全球直播海外点击事件
    [self.headMainView.liveMainView setAbroadClickBlock:^{
        !weakSelf.abroadClickBlock?:weakSelf.abroadClickBlock();
    }];
#pragma mark - 全球直播国内点击事件
    [self.headMainView.liveMainView setInternalClickBlock:^{
        !weakSelf.internalClickBlock?:weakSelf.internalClickBlock();
    }];
    
#pragma mark - 名家讲堂顶部箭头点击事件
    [self.headMainView.speechMainView setTopArrowClickBlock:^{
        !weakSelf.speechTopMoreClickBlock?:weakSelf.speechTopMoreClickBlock();
    }];
#pragma mark - 名家讲堂cell点击事件
    [self.headMainView.speechMainView setCellClickBlock:^(BidLiveHomeHotCourseListModel * _Nonnull model) {
        !weakSelf.speechCellClickBlock?:weakSelf.speechCellClickBlock(model);
    }];
#pragma mark - 名家讲堂更多点击事件
    [self.headMainView.speechMainView setMoreClickBlock:^{
        weakSelf.speechPageIndex++;
        weakSelf.isPullRefresh = NO;
        [weakSelf loadHomeHotCourseData];
//            NSInteger count = (weakSelf.speechMainView.clickMoreTimes+1)*4;
//            [weakSelf.speechMainView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(70+count*kAnchorCellHeight+40);
//            }];
    }];
#pragma mark - 名家讲堂收起点击事件
    [self.headMainView.speechMainView setRetractingClickBlock:^{
        weakSelf.speechPageIndex = 1;
        weakSelf.headMainView.speechMainView.videosArray = [NSMutableArray arrayWithArray:weakSelf.speechOrigionArray];
        weakSelf.headMainView.speechMainView.clickMoreTimes = 0;
        [weakSelf.headMainView.speechMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(70+weakSelf.headMainView.speechMainView.videosArray.count*kSpeechCellHeight+40);
        }];
//            CGRect frame = weakSelf.speechMainView.frame;
//            frame.size.height = 70+weakSelf.speechMainView.videosArray.count*kSpeechCellHeight+40;
//            weakSelf.speechMainView.frame = frame;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.headMainView.speechMainView.tableView reloadData];
            CGFloat offsetY = CGRectGetMinY(weakSelf.headMainView.speechMainView.frame)-150;
            [weakSelf.collectionView setContentOffset:CGPointMake(0, offsetY) animated:YES];
        });
        
    }];
#pragma mark - 精选主播更多点击事件
    [self.headMainView.anchorMainView setMoreClickBlock:^{
//            weakSelf.anchorPageIndex++;
//            weakSelf.isPullRefresh = NO;
//            [weakSelf loadHomeAnchorListData];
        [weakSelf.headMainView.anchorMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(70+weakSelf.headMainView.anchorMainView.anchorsArray.count*kAnchorCellHeight+40);
        }];
    }];
#pragma mark - 精选主播收起点击事件
    [self.headMainView.anchorMainView setRetractingClickBlock:^{
//            weakSelf.anchorPageIndex = 1;
//            weakSelf.anchorMainView.anchorsArray = [NSMutableArray arrayWithArray:weakSelf.anchorOrigionArray];
        [weakSelf.headMainView.anchorMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(70+(weakSelf.headMainView.anchorMainView.anchorsArray.count<=4?:4)*kAnchorCellHeight+40);
        }];
        [weakSelf.headMainView.anchorMainView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.headMainView.anchorMainView startPlayFirstCell];
        });
        
//            CGFloat offsetY = CGRectGetMaxY(weakSelf.liveMainView.frame)+(weakSelf.lastAnchorsCount-5)*kAnchorCellHeight-150;
        CGFloat offsetY = CGRectGetMinY(weakSelf.headMainView.anchorMainView.frame)-145;
        [weakSelf.collectionView setContentOffset:CGPointMake(0, offsetY) animated:YES];
    }];
#pragma mark - 精选主播箭头点击事件
    [self.headMainView.anchorMainView setArrowClickBlock:^{
        !weakSelf.liveRoomClickBlock?:weakSelf.liveRoomClickBlock();
    }];
#pragma mark - 精选主播cell点击事件
    [self.headMainView.anchorMainView setCellClickBlock:^(BidLiveHomeAnchorListModel * _Nonnull model) {
        !weakSelf.anchorCellClickBlock?:weakSelf.anchorCellClickBlock(model);
    }];
#pragma mark - 猜你喜欢cell点击事件
    [self setYoulikeCellClickBlock:^(BidLiveHomeGuessYouLikeListModel * _Nonnull model) {
        !weakSelf.guessYouLikeCellClickBlock?:weakSelf.guessYouLikeCellClickBlock(model);
    }];
#pragma mark - 猜你喜欢cell上的正在直播点击事件
    [self setYoulikeCellLivingClickBlock:^(BidLiveHomeGuessYouLikeListModel * _Nonnull model) {
        !weakSelf.guessYoulikeCellLivingClickBlock?:weakSelf.guessYoulikeCellLivingClickBlock(model);
    }];
#pragma mark - 猜你喜欢banner点击事件
    [self setYoulikeBannerClickBlock:^(BidLiveHomeBannerModel * _Nonnull model) {
        !weakSelf.guessYouLikeBannerClickBlock?:weakSelf.guessYouLikeBannerClickBlock(model);
    }];
#pragma mark - 焦点拍品cell点击事件
    [self.headMainView.highlightLotsMainView setCellClickBlock:^(BidLiveHomeHighlightLotsListModel * _Nonnull model) {
        !weakSelf.highlightLotsCellClickBlock?:weakSelf.highlightLotsCellClickBlock(model);
    }];
#pragma mark - 焦点拍品cell上的正在直播点击事件
    [self.headMainView.highlightLotsMainView setCellLivingLabelClickBlock:^(BidLiveHomeHighlightLotsListModel * _Nonnull model) {
        !weakSelf.highlightLotsCellLivinLabelClickBlock?:weakSelf.highlightLotsCellLivinLabelClickBlock(model);
    }];
}

#pragma mark - 加载数据
-(void)loadData {
    [self loadBannerData];
    [self loadCMSArticleData];
    [self loadGlobalLiveData];
    [self loadHomeHotCourseData];
    [self loadHomeVideoGuaideData];
    [self loadHomeAnchorListData];
    [self loadHomeHighliahtLotsListData];
    [self loadGuessYouLikeListData];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self startTimer];
//    });
}

-(void)updateHeadViewHeight:(CGFloat)height {
//    CGFloat headMainViewHeight = self.headMainViewSize.height;
//    headMainViewHeight+=kVideoGuaideViewHeight;
//    self.headMainViewSize = CGSizeMake(self.headMainViewSize.width, headMainViewHeight);
//    [self.collectionView reloadData];
}

#pragma mark - 加载广告轮播数据
-(void)loadBannerData {
    WS(weakSelf)
    //顶部banner
    [BidLiveHomeNetworkModel getHomePageBannerList:11 client:@"wx" completion:^(NSArray<BidLiveHomeBannerModel *> * _Nonnull bannerList) {
        [weakSelf.headMainView.topMainView updateBanners:bannerList];
    }];
    
    //全球直播banner
    [BidLiveHomeNetworkModel getHomePageBannerList:12 client:@"wx" completion:^(NSArray<BidLiveHomeBannerModel *> * _Nonnull bannerList) {
        [weakSelf.headMainView.liveMainView updateBannerArray:bannerList];
    }];
    
    //猜你喜欢banner
    [BidLiveHomeNetworkModel getHomePageBannerList:22 client:@"app" completion:^(NSArray<BidLiveHomeBannerModel *> * _Nonnull bannerList) {
        weakSelf.youlikeBannerArray = bannerList;
    }];
}

#pragma mark - 加载动态滚动数据
-(void)loadCMSArticleData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageArticleList:1 pageSize:5 completion:^(NSArray<BidLiveHomeCMSArticleModel *> * _Nonnull cmsArticleList) {
        [weakSelf.headMainView.topMainView updateCMSArticleList:cmsArticleList];
    }];
}

#pragma mark - 加载全球直播列表数据
-(void)loadGlobalLiveData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageGlobalLiveList:@"all" completion:^(NSArray<BidLiveHomeGlobalLiveModel *> * _Nonnull liveList) {
        NSMutableArray *totalArray = [NSMutableArray arrayWithArray:liveList];
        NSRange range1 = NSMakeRange(0, totalArray.count/2);
        NSRange range2 = NSMakeRange(totalArray.count/2, totalArray.count/2);
        NSArray *array1 = [totalArray subarrayWithRange:range1];
        NSArray *array2 = [totalArray subarrayWithRange:range2];
        weakSelf.headMainView.liveMainView.firstPartLiveArray = array1;
        weakSelf.headMainView.liveMainView.secondPartLiveArray = array2;
        
        CGFloat height = kLiveNormalCellHeight*liveList.count+70+kLiveCenterImageCellHeight+10+70+kLiveCenterImageCellHeight;
        [weakSelf.headMainView.liveMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            //kLiveNormalCellHeight*8+70+kLiveCenterImageCellHeight+10+70+kLiveCenterImageCellHeight
//            make.height.mas_equalTo(kLiveMainViewHeight);
            make.height.mas_equalTo(height);
        }];
        
        [weakSelf.headMainView.liveMainView reloadData];
        [weakSelf updateHeadViewHeight:height];
    }];
}

#pragma mark - 加载名家讲堂列表数据
-(void)loadHomeHotCourseData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageHotCourse:self.speechPageIndex pageSize:4 pageCount:0 completion:^(BidLiveHomeHotCourseModel * _Nonnull courseModel) {
        if (weakSelf.isPullRefresh) {
            [weakSelf.headMainView.speechMainView.videosArray removeAllObjects];
            weakSelf.headMainView.speechMainView.clickMoreTimes = 0;
            [weakSelf.headMainView.speechMainView addSubviewToFooterView:weakSelf.headMainView.anchorMainView.clickMoreTimes];
        }
        [weakSelf.headMainView.speechMainView.videosArray addObjectsFromArray:courseModel.list];
        if (weakSelf.speechPageIndex==1) {
            weakSelf.speechOrigionArray = courseModel.list;
        }
        CGFloat height = 70+weakSelf.headMainView.speechMainView.videosArray.count*kSpeechCellHeight+40;
        [weakSelf.headMainView.speechMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        weakSelf.lastVideosCount = weakSelf.headMainView.speechMainView.videosArray.count;
        [weakSelf.headMainView.speechMainView reloadData];
        
        [weakSelf updateHeadViewHeight:height];
    }];
}

#pragma mark - 加载视频导览列表数据
-(void)loadHomeVideoGuaideData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageVideoGuaideList:1 pageSize:20 isNoMore:false isLoad:true scrollLeft:@"" completion:^(BidLiveHomeVideoGuaideModel * _Nonnull courseModel) {
        if (weakSelf.isPullRefresh) {
            //视频导览列表回到原始位置
            [weakSelf.headMainView.topMainView videoGuaideViewBackToStartFrame];
        }
        [weakSelf.headMainView.topMainView updateVideoGuaideList:courseModel.list];
        CGFloat height = kTopMainViewHeight+kVideoGuaideViewHeight;
        [weakSelf.headMainView.topMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        [weakSelf updateHeadViewHeight:height];
    }];
}

#pragma mark - 加载精选主播列表数据
-(void)loadHomeAnchorListData {
    WS(weakSelf)
    
    [BidLiveHomeNetworkModel getHomePageAnchorList:self.anchorPageIndex pageSize:8 pageCount:0 isContainBeforePage:false completion:^(BidLiveHomeAnchorModel * _Nonnull model) {
        if (weakSelf.isPullRefresh) {
            [weakSelf.headMainView.anchorMainView.anchorsArray removeAllObjects];
            weakSelf.headMainView.anchorMainView.clickMoreTimes = 0;
            [weakSelf.headMainView.anchorMainView addSubviewToFooterView:weakSelf.headMainView.anchorMainView.clickMoreTimes];
        }
        
        [weakSelf.headMainView.anchorMainView.anchorsArray addObjectsFromArray:model.list];
        if (weakSelf.anchorPageIndex==1) {
            weakSelf.anchorOrigionArray = model.list;
        }
        CGFloat height = 70+(weakSelf.headMainView.anchorMainView.anchorsArray.count<=4?:4)*kAnchorCellHeight+40;
        [weakSelf.headMainView.anchorMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        weakSelf.lastAnchorsCount = weakSelf.headMainView.anchorMainView.anchorsArray.count;
        [weakSelf.headMainView.anchorMainView reloadData];
//        if (weakSelf.anchorPageIndex!=1) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf.anchorMainView scrollViewDidEndScroll:weakSelf.anchorMainView.lastOffsetY];
//            });
//        }
        
        [weakSelf updateHeadViewHeight:height];
    }];
}

#pragma mark - 加载焦点拍品列表数据
-(void)loadHomeHighliahtLotsListData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageHighlightLotsList:self.highlightLotsPageIndex pageSize:20 isNoMore:false isLoad:true scrollLeft:@"" completion:^(BidLiveHomeHighlightLotsModel * _Nonnull courseModel) {
        if (courseModel.list && courseModel.list.count) {
            [weakSelf.hightlightLotsList addObjectsFromArray:courseModel.list];
            [weakSelf.headMainView.highlightLotsMainView updateHighlightLotsList:weakSelf.hightlightLotsList];
            [weakSelf.headMainView.highlightLotsMainView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kHightlightLotsMainViewHeight);
            }];
        }
        [weakSelf updateHeadViewHeight:kHightlightLotsMainViewHeight];
    }];
}

#pragma mark - 加载更多猜你喜欢数据
-(void)loadMoreData {
    if (self.youlikePageIndexArray.firstObject) {
        int currentPage = [[self.youlikePageIndexArray firstObject] intValue];
        self.youlikePageIndex = currentPage;
        self.isLoadMoreData = YES;
        [self loadGuessYouLikeListData];
//        [self.youlikePageIndexArray removeObjectAtIndex:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_footer endRefreshing];
        });
    }else {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - 加载猜你喜欢列表数据
-(void)loadGuessYouLikeListData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageGuessYouLikeList:self.youlikePageIndex completion:^(BidLiveHomeGuessYouLikeModel * _Nonnull model) {
        NSLog(@"猜你喜欢列表数据加载：%d 随机下标：%d",weakSelf.youlikePageNormalIndex,weakSelf.youlikePageIndex);
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:model.list];
        if (weakSelf.isPullRefresh) {
            [weakSelf.likesArray removeAllObjects];
        }
        
        NSInteger firstPageIndex = model.pageIndex;
        NSMutableArray *tempPageArr = [NSMutableArray array];
        for (int i=1; i<= model.pageCount; i++) {
            if (i != firstPageIndex) {
                [tempPageArr addObject:@(i)];
            }
        }
        NSArray *sortedArr = [weakSelf shuffle:tempPageArr];

        if (!weakSelf.isLoadMoreData) {
            [weakSelf.youlikePageIndexArray setArray:sortedArr];
        }
        
        if (weakSelf.youlikePageIndex==0 && model.list.count>10) {
            [weakSelf.likesArray removeAllObjects];
            NSRange range1 = NSMakeRange(0, 10);
            NSRange range2 = NSMakeRange(10, model.list.count-10);
            NSArray *array1 = [tempArray subarrayWithRange:range1];
            NSArray *array2 = [tempArray subarrayWithRange:range2];
            [weakSelf.likesArray addObject:array1];
            if (array2.count%10==0) {
                [weakSelf.likesArray addObject:array2];
                weakSelf.youlikePageNormalIndex = 1;
            }
            
            if (weakSelf.youlikeBannerArray.count) {
                [weakSelf.bannerArray addObject:weakSelf.youlikeBannerArray[weakSelf.youlikePageNormalIndex]];
            }
        }else {
            if (model.list) {
                if (weakSelf.youlikePageNormalIndex <= weakSelf.youlikeBannerArray.count) {
                    if (weakSelf.youlikePageNormalIndex<weakSelf.youlikeBannerArray.count) {
                        [weakSelf.bannerArray addObject:weakSelf.youlikeBannerArray[weakSelf.youlikePageNormalIndex]];
                    }
                    [weakSelf.likesArray addObject:model.list];
                }else {
                    NSArray *lastPageIndexArray = [weakSelf.likesArray lastObject];
                    NSMutableArray *lastArray = [NSMutableArray arrayWithArray:lastPageIndexArray];
                    [lastArray addObjectsFromArray:model.list];
//                    weakSelf.youlikeMainView.likesArray[weakSelf.youlikePageNormalIndex] = lastArray;
                    if (lastPageIndexArray) {
                        NSInteger lastIndex = weakSelf.likesArray.count-1;
                        [weakSelf.likesArray replaceObjectAtIndex:lastIndex withObject:lastArray];
                    }else {
                        [weakSelf.likesArray addObject:model.list];
                    }
                }
            }
        }
        weakSelf.youlikePageNormalIndex++;
        if (weakSelf.youlikePageIndexArray.firstObject) {
            [weakSelf.youlikePageIndexArray removeObjectAtIndex:0];
        }
        
        [CATransaction setDisableActions:YES];
        [weakSelf.collectionView reloadData];
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

-(void)setupUI {
    [self addSubview:self.collectionView];
    CGFloat origionY = -UIApplication.sharedApplication.statusBarFrame.size.height;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(origionY, 0, 0, 0));
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [self addSubview:self.topSearchView];
    [self addSubview:self.floatView];
}

-(void)bannerClick:(UIButton *)btn {
    BidLiveHomeBannerModel *model = self.bannerArray[btn.tag];
    !self.youlikeBannerClickBlock?:self.youlikeBannerClickBlock(model);
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.likesArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *dataArray = self.likesArray[section];
    return dataArray.count;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind==UICollectionElementKindSectionFooter) {
        UICollectionReusableView *reusableHeadView = nil;
        if (!reusableHeadView) {
            reusableHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView1" forIndexPath:indexPath];
            reusableHeadView.backgroundColor = UIColorFromRGB(0xf8f8f8);
            for (UIView *view in reusableHeadView.subviews) {
                [view removeFromSuperview];
            }
//            if (indexPath.section==0) {
//                UILabel *label = (UILabel *)[reusableHeadView viewWithTag:100];
//                if (!label) {
//                    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 60)];
//                    label.tag = 100;
//                    label.text = @"猜 你 喜 欢";
//                    label.textAlignment = NSTextAlignmentCenter;
//                    label.textColor = UIColor.blackColor;
//                    label.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
//
//                    [reusableHeadView addSubview:label];
//                }
//            }else {
                UIView *view = (UIView *)[reusableHeadView viewWithTag:101];
                if (!view) {
                    view = [[UIView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, (SCREEN_WIDTH-30)*138.5/537)];
                    view.backgroundColor = UIColorFromRGB(0xf8f8f8);
                    view.tag = 101;
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, (SCREEN_WIDTH-30)*138.5/537)];
                    if (indexPath.section<self.bannerArray.count) {
                        BidLiveHomeBannerModel *model = self.bannerArray[indexPath.section];
                        if (model) {
                            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
                        }
                        [view addSubview:imageView];
                        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        btn.tag = indexPath.section-1;
                        btn.frame = imageView.frame;
                        [btn addTarget:self action:@selector(bannerClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [view addSubview:btn];
                    }
                    
                    [reusableHeadView addSubview:view];
                }
//            }
        }
        return reusableHeadView;
    }else if (kind==UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableHeadView = nil;
        if (indexPath.section==0) {
            if (!reusableHeadView) {
                reusableHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView2" forIndexPath:indexPath];
                reusableHeadView.backgroundColor = UIColor.cyanColor;
                for (UIView *view in reusableHeadView.subviews) {
                    [view removeFromSuperview];
                }
            }
            UIView *view = (UIView *)[reusableHeadView viewWithTag:102];
            if (!view) {
//                view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500)];
                view = self.headMainView;
                view.backgroundColor = UIColor.cyanColor;
                view.tag = 102;
                
                [reusableHeadView addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.insets(UIEdgeInsetsZero);
                }];
            }
        }
        return reusableHeadView;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (self.likesArray.count>1 && section==self.likesArray.count-1) {
        return CGSizeZero;
    }
    return CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH-30)*138.5/537+20);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return self.headMainViewSize;
    }
    return CGSizeZero;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeScrollYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BidLiveHomeScrollYouLikeCell" forIndexPath:indexPath];
    NSArray<BidLiveHomeGuessYouLikeListModel *> *array = self.likesArray[indexPath.section];
    cell.model = array[indexPath.item];
    BidLiveHomeGuessYouLikeListModel *model = array[indexPath.item];
    WS(weakSelf)
    [cell setLivingTapBlock:^(NSString * _Nonnull title) {
        if ([title isEqualToString:@"正在直播"]) {
            !weakSelf.youlikeCellLivingClickBlock?:weakSelf.youlikeCellLivingClickBlock(model);
        }else {
            !weakSelf.youlikeCellClickBlock?:weakSelf.youlikeCellClickBlock(model);
        }
        
    }];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<BidLiveHomeGuessYouLikeListModel *> *array = self.likesArray[indexPath.section];
    BidLiveHomeGuessYouLikeListModel *model = array[indexPath.item];
    !self.youlikeCellClickBlock?:self.youlikeCellClickBlock(model);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentYoffset = scrollView.contentOffset.y;
    if (contentYoffset <= 0) {
        NSLog(@"滚动到顶部了，移交滚动权限给主视图");
//        self.collectionView.scrollEnabled = NO;
//        !self.youLikeViewScrollToTopBlock?:self.youLikeViewScrollToTopBlock();
    }else {
//        CGFloat height = scrollView.frame.size.height;
//        CGFloat contentYoffset = scrollView.contentOffset.y;
//        CGFloat distanceFromBottom = height - contentYoffset-25;
//        if (distanceFromBottom <= height && !self.hasScrollToBottom) {
//            self.hasScrollToBottom = YES;
//            !self.loadMoreGuessYouLikeDataBlock?:self.loadMoreGuessYouLikeDataBlock();
//        }
        !self.youLikeViewDidScrollBlock?:self.youLikeViewDidScrollBlock();
    }
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
    !self.youLikeViewEndScrollBlock?:self.youLikeViewEndScrollBlock();
}

#pragma mark - lazy
-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake((SCREEN_WIDTH-15*2-10)/2, 280);
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _layout.minimumLineSpacing = 10;
        _layout.minimumInteritemSpacing = 0;
//        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH-30)*138.5/537+20);
//        _layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH-30)*138.5/537+20);
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColorFromRGB(0xf8f8f8);
//        _collectionView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
//        _collectionView.bounces = NO;
        _collectionView.alwaysBounceVertical = YES;
//        _collectionView.scrollsToTop = NO;
        [_collectionView registerClass:BidLiveHomeScrollYouLikeCell.class forCellWithReuseIdentifier:@"BidLiveHomeScrollYouLikeCell"];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView1"];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView2"];
        
        WS(weakSelf)
        MJRefreshAutoNormalFooter *refreshFoot = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            !weakSelf.loadMoreGuessYouLikeDataBlock?:weakSelf.loadMoreGuessYouLikeDataBlock();
            [weakSelf loadMoreData];
        }];
        refreshFoot.triggerAutomaticallyRefreshPercent = -50;
        refreshFoot.refreshingTitleHidden = YES;
        [refreshFoot setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
        refreshFoot.onlyRefreshPerDrag = YES;
        _collectionView.mj_footer = refreshFoot;
    }
    return _collectionView;
}

-(BidLiveHomeHeadView *)topSearchView {
    if (!_topSearchView) {
        CGFloat height = 80;
        if (UIApplication.sharedApplication.statusBarFrame.size.height>20) {
            height = 100;
        }
        _topSearchView = [[BidLiveHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        WS(weakSelf)
        [_topSearchView setSearchClickBlock:^{
            !weakSelf.searchClickBlock?:weakSelf.searchClickBlock();
        }];
    }
    return _topSearchView;
}

-(BidLiveHomeFloatView *)floatView {
    if (!_floatView) {
        _floatView = [[BidLiveHomeFloatView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-30, SCREEN_HEIGHT-[UIDevice vg_tabBarFullHeight]-25-60, 60, 60)];
        WS(weakSelf)
        [_floatView setToNewAuctionClickBlock:^{
            !weakSelf.toNewAuctionClickBlock?:weakSelf.toNewAuctionClickBlock();
        }];
    }
    return _floatView;
}

-(NSMutableArray<BidLiveHomeBannerModel *> *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray<BidLiveHomeBannerModel*> array];
    }
    return _bannerArray;
}

-(BidLiveHomeTopView *)headMainView {
    if (!_headMainView) {
        _headMainView = [[BidLiveHomeTopView alloc] initWithFrame:CGRectZero];
        _headMainView.layer.masksToBounds = YES;
    }
    return _headMainView;
}

@end
