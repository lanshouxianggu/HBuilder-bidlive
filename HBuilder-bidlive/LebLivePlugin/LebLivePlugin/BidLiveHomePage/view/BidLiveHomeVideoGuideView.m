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

@interface BidLiveHomeVideoGuideView () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray <BidLiveHomeVideoGuaideListModel *> *dataList;
@property (nonatomic, strong) BidLiveHomeScrollVideoGuaideCell *lastPlayVideoCell;
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

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [UIView animateWithDuration:0.15 animations:^{
//        self.floatView.transform = CGAffineTransformMakeScale(0.001, 0.001);
//    }];
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
    CGFloat offsetX = self.collectionView.contentOffset.x;
    
    NSIndexPath *indexPath = nil;
    BidLiveHomeScrollVideoGuaideCell *currentCell = nil;
    if (offsetX==0) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        currentCell = (BidLiveHomeScrollVideoGuaideCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    }else {
        indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(offsetX+self.collectionView.frame.size.width/2, 0)];
        currentCell = (BidLiveHomeScrollVideoGuaideCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    }
    if ([currentCell isEqual:self.lastPlayVideoCell]) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.lastPlayVideoCell.rtcView.superview.hidden = YES;
        [self.lastPlayVideoCell.rtcView.videoView stop];

        [currentCell.rtcView.videoView start];
        currentCell.rtcView.superview.hidden = NO;
        self.lastPlayVideoCell = currentCell;
    });
    
    NSLog(@"当前位置：%f", offsetX);
}


#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeScrollVideoGuaideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BidLiveHomeScrollVideoGuaideCell" forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.item];

    cell.rtcView.superview.hidden = YES;
    [cell.rtcView.videoView stop];
    if (indexPath.item==0) {
        cell.rtcView.superview.hidden = NO;
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [cell.rtcView.videoView start];
//        });
        self.lastPlayVideoCell = cell;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.cellClickBlock?:self.cellClickBlock(self.dataList[indexPath.item]);
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
        _collectionView.scrollsToTop = NO;
        [_collectionView registerClass:BidLiveHomeScrollVideoGuaideCell.class forCellWithReuseIdentifier:@"BidLiveHomeScrollVideoGuaideCell"];
    }
    return _collectionView;
}
@end
