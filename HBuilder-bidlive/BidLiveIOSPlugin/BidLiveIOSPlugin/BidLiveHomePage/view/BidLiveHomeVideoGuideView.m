//
//  BidLiveHomeVideoGuideView.m
//  OCTools
//
//  Created by bidlive on 2022/6/8.
//

#import "BidLiveHomeVideoGuideView.h"
#import "LCConfig.h"
#import "Masonry.h"
#import "BidliveBundleRecourseManager.h"
#import "BidLiveHomeScrollVideoGuaideCell.h"
#import "BidLiveHomeVideoGuaideModel.h"

#define kCollectionViewHeight (SCREEN_HEIGHT*0.18)
#define kItemWidth (SCREEN_WIDTH-15*2-12*2)/2.25

@interface BidLiveHomeVideoGuideView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray <BidLiveHomeVideoGuaideListModel *> *dataList;
@end

@implementation BidLiveHomeVideoGuideView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.collectionView];
}

-(void)updateVideoGuideList:(NSArray<BidLiveHomeVideoGuaideListModel *> *)list {
    self.dataList = list;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeScrollVideoGuaideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BidLiveHomeScrollVideoGuaideCell" forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.item];
    return cell;
}

#pragma mark - lazy
-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(kItemWidth, kCollectionViewHeight);
        _layout.minimumLineSpacing = 12;
        _layout.minimumInteritemSpacing = 0;
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-15*2, kCollectionViewHeight) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:BidLiveHomeScrollVideoGuaideCell.class forCellWithReuseIdentifier:@"BidLiveHomeScrollVideoGuaideCell"];
    }
    return _collectionView;
}
@end
