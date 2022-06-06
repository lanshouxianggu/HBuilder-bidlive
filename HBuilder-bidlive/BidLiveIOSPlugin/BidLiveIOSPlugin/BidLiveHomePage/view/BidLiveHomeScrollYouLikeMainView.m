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

@interface BidLiveHomeScrollYouLikeMainView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation BidLiveHomeScrollYouLikeMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.likesArray = [NSMutableArray arrayWithArray:@[@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]]];
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
                    view = [[UIView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 90)];
                    view.backgroundColor = UIColor.orangeColor;
                    view.tag = 101;
                    
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
    
    return cell;
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
        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 110);
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
        [_collectionView registerClass:BidLiveHomeScrollYouLikeCell.class forCellWithReuseIdentifier:@"BidLiveHomeScrollYouLikeCell"];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1"];
    }
    return _collectionView;
}
@end
