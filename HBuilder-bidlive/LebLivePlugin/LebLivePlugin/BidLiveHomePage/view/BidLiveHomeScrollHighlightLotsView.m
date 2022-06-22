//
//  BidLiveHomeScrollHighlightLotsView.m
//  OCTools
//
//  Created by bidlive on 2022/6/9.
//

#import "BidLiveHomeScrollHighlightLotsView.h"
#import "BidLiveHomeScrollHighlightLotsCell.h"
#import "LCConfig.h"
#import "Masonry.h"
#import "BidLiveBundleResourceManager.h"
#import "BidLiveHomeHighlightLotsModel.h"

#define kTopViewHeight 70
#define kItemWidth (SCREEN_WIDTH-15*2-12*2)/2.25
#define kBottomViewHeight (SCREEN_WIDTH*0.689)

@interface BidLiveHomeScrollHighlightLotsView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray <BidLiveHomeHighlightLotsListModel *> *dataList;
@property (nonatomic, assign) BOOL isScrollToRight;
@end

@implementation BidLiveHomeScrollHighlightLotsView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(kTopViewHeight);
    }];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(kTopViewHeight);
        make.bottom.offset(0);
    }];
}

-(void)loadMoreData {
    !self.scrollToRightBlock?:self.scrollToRightBlock();
}

-(void)updateHighlightLotsList:(NSArray<BidLiveHomeHighlightLotsListModel *> *)list {
    self.dataList = list;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeScrollHighlightLotsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BidLiveHomeScrollHighlightLotsCell" forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeHighlightLotsListModel *model = self.dataList[indexPath.item];
    !self.cellClickBlock?:self.cellClickBlock(model);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isScrollToRight) {
        return;
    }
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    CGFloat distanceFromRight = scrollView.contentSize.width-offsetX;
    if (distanceFromRight<=width) {
        [self loadMoreData];
        self.isScrollToRight = YES;
    }
}

#pragma mark - lazy
-(UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectZero];
        _topView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        UIImage *image = [BidLiveBundleResourceManager getBundleImage:@"indexBlock5" type:@"png"];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
        [_topView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.width.mas_equalTo(44*3.23);
            make.height.mas_equalTo(44);
        }];
    }
    return _topView;
}

-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(kItemWidth, kBottomViewHeight);
        _layout.minimumLineSpacing = 12;
        _layout.minimumInteritemSpacing = 0;
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        [_collectionView registerClass:BidLiveHomeScrollHighlightLotsCell.class forCellWithReuseIdentifier:@"BidLiveHomeScrollHighlightLotsCell"];
    }
    return _collectionView;
}

@end
