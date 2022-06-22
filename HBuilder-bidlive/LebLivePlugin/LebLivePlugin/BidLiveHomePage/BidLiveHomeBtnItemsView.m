//
//  BidLiveHomeBtnItemsView.m
//  OCTools
//
//  Created by bidlive on 2022/5/27.
//

#import "BidLiveHomeBtnItemsView.h"
#import "LCConfig.h"
#import "Masonry.h"
#import "BidLiveBundleResourceManager.h"

@interface BidLiveHomeBtnItemsView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *titlesArr;
@property (nonatomic, strong) NSArray *imagesArr;
@end

@implementation BidLiveHomeBtnItemsView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titlesArr = @[@"全球专场",@"鉴  定",@"国内专场",@"送  拍",@"直播间",@"讲  堂"];
        
        UIImage *image1 = [BidLiveBundleResourceManager getBundleImage:@"quanqiupai" type:@"png"];
        UIImage *image2 = [BidLiveBundleResourceManager getBundleImage:@"jianding" type:@"png"];
        UIImage *image3 = [BidLiveBundleResourceManager getBundleImage:@"guoneipai" type:@"png"];
        UIImage *image4 = [BidLiveBundleResourceManager getBundleImage:@"songpai" type:@"png"];
        UIImage *image5 = [BidLiveBundleResourceManager getBundleImage:@"zhibojian" type:@"png"];
        UIImage *image6 = [BidLiveBundleResourceManager getBundleImage:@"lianpaijiangtang" type:@"png"];
        self.imagesArr = @[image1,image2,image3,image4,image5,image6];
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titlesArr.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeBtnItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BidLiveHomeBtnItemCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.whiteColor;
    cell.imageView.image = self.imagesArr[indexPath.item];
    cell.titleLable.text = self.titlesArr[indexPath.item];
    cell.leftLine.hidden = cell.rightLine.hidden = YES;
    if (indexPath.item==2||indexPath.item==3) {
        cell.leftLine.hidden = cell.rightLine.hidden = NO;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.item) {
        case 0:!self.globalSaleClickBlock?:self.globalSaleClickBlock();break;
        case 1:!self.appraisalClickBlock?:self.appraisalClickBlock();break;
        case 2:!self.countrySaleClickBlock?:self.countrySaleClickBlock();break;
        case 3:!self.sendClickBlock?:self.sendClickBlock();break;
//        case 4:!self.speechClassClickBlock?:self.speechClassClickBlock();break;
//        case 5:!self.informationClickBlock?:self.informationClickBlock();break;
        case 4:!self.liveRoomClickBlock?:self.liveRoomClickBlock();break;
        case 5:!self.speechClassClickBlock?:self.speechClassClickBlock();break;
        default:
            break;
    }
}

#pragma mark - lazy
-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (SCREEN_WIDTH-10*2-2)/3;
        CGFloat height = (CGRectGetHeight(self.frame)-15*2)/2;
        _layout.itemSize = CGSizeMake(width, height);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 1;
        _layout.minimumInteritemSpacing = 0;
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-10*2, CGRectGetHeight(self.frame)-15*2) collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        
        [_collectionView registerClass:BidLiveHomeBtnItemCell.class forCellWithReuseIdentifier:@"BidLiveHomeBtnItemCell"];
    }
    return _collectionView;
}
@end

@interface BidLiveHomeBtnItemCell ()

@end

@implementation BidLiveHomeBtnItemCell
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(18);
    }];
    
    [self.contentView addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(5);
        make.centerY.offset(0);
        make.right.offset(-10);
    }];
    
    [self.contentView addSubview:self.leftLine];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(15);
        make.centerY.offset(0);
    }];
    
    [self.contentView addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(15);
        make.centerY.offset(0);
    }];
}

#pragma mark - lazy
-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.textColor = UIColorFromRGB(0x3b3b3b);
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

-(UIView *)leftLine {
    if (!_leftLine) {
        _leftLine = [UIView new];
        _leftLine.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _leftLine;
}

-(UIView *)rightLine {
    if (!_rightLine) {
        _rightLine = [UIView new];
        _rightLine.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _rightLine;
}
@end
