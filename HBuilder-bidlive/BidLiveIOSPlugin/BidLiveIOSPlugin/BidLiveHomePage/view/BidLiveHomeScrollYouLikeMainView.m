//
//  BidLiveHomeScrollYouLikeMainView.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/31.
//

#import "BidLiveHomeScrollYouLikeMainView.h"
#import "BidLiveHomeScrollYouLikeCell.h"
#import "LCConfig.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface BidLiveHomeScrollYouLikeMainView () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation BidLiveHomeScrollYouLikeMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.likesArray = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
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
    if (kind==UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableHeadView = nil;
        if (!reusableHeadView) {
            reusableHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1" forIndexPath:indexPath];
            reusableHeadView.backgroundColor = UIColorFromRGB(0xf8f8f8);
            for (UIView *view in reusableHeadView.subviews) {
                [view removeFromSuperview];
            }
            if (indexPath.section==0) {
                UILabel *label = (UILabel *)[reusableHeadView viewWithTag:100];
                if (!label) {
                    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 60)];
                    label.tag = 100;
                    label.text = @"猜 你 喜 欢";
                    label.textAlignment = NSTextAlignmentCenter;
                    label.textColor = UIColor.blackColor;
                    label.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];

                    [reusableHeadView addSubview:label];
                }
            }else {
                UIView *view = (UIView *)[reusableHeadView viewWithTag:101];
                if (!view) {
                    view = [[UIView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, (SCREEN_WIDTH-30)*138.5/537)];
                    view.backgroundColor = UIColorFromRGB(0xf8f8f8);
                    view.tag = 101;
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, (SCREEN_WIDTH-30)*138.5/537)];
                    if (indexPath.section-1<self.bannerArray.count) {
                        BidLiveHomeBannerModel *model = self.bannerArray[indexPath.section-1];
                        if (model) {
                            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
                        }
                        [view addSubview:imageView];
                    }
                    
                    [reusableHeadView addSubview:view];
                }
            }
        }
        return reusableHeadView;
    }
    return [UICollectionReusableView new];
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeScrollYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BidLiveHomeScrollYouLikeCell" forIndexPath:indexPath];
    NSArray<BidLiveHomeGuessYouLikeListModel *> *array = self.likesArray[indexPath.section];
    cell.model = array[indexPath.item];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.contentOffset.y<0) {
//        self.collectionView.scrollEnabled = NO;
//        !self.youLikeViewScrollToTopBlock?:self.youLikeViewScrollToTopBlock();
//    }
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
        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH-30)*138.5/537+20);
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColorFromRGB(0xf8f8f8);
//        _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:BidLiveHomeScrollYouLikeCell.class forCellWithReuseIdentifier:@"BidLiveHomeScrollYouLikeCell"];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1"];
        
//        WS(weakSelf)
//        MJRefreshAutoNormalFooter *refreshFoot = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            !weakSelf.loadMoreGuessYouLikeDataBlock?:weakSelf.loadMoreGuessYouLikeDataBlock();
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf.collectionView.mj_footer endRefreshing];
//            });
//        }];
//        refreshFoot.refreshingTitleHidden = YES;
//        refreshFoot.onlyRefreshPerDrag = YES;
//        _collectionView.mj_footer = refreshFoot;
    }
    return _collectionView;
}

-(NSMutableArray<BidLiveHomeBannerModel *> *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray<BidLiveHomeBannerModel*> array];
    }
    return _bannerArray;
}
@end
