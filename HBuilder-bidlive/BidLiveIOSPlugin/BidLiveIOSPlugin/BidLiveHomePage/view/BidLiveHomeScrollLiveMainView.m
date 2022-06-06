//
//  BidLiveHomeScrollLiveMainView.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScrollLiveMainView.h"
#import "Masonry.h"
#import "LCConfig.h"
#import "BidLiveBundleRecourseManager.h"
#import "BidLiveHomeScollLiveNormalCell.h"
#import "DCSVProgressHUD.h"
#import "BidLiveHomeScrollLiveBtnView.h"

@interface BidLiveHomeScrollLiveMainView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BidLiveHomeScrollLiveMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.firstPartLiveArray = @[@"",@"",@"",@""];
        self.secondPartLiveArray = @[@"",@"",@"",@""];
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.firstPartLiveArray.count;
    }
    if (section==1) {
        return self.secondPartLiveArray.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0||indexPath.section==1) {
        return 140;
    }
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0||section==1) {
        return 90;
    }
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [UIView new];
    headView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    WS(weakSelf)
    if (section==0) {
        UIImage *image = [BidLiveBundleRecourseManager getBundleImage:@"special" type:@"png"];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
        [headView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.width.mas_equalTo(44*3.35);
            make.height.mas_equalTo(44);
        }];
    }
    if (section==1) {
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.orangeColor;
        [headView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-15);
            make.top.offset(5);
            make.bottom.offset(-5);
        }];
    }
    if (section==2) {
        BidLiveHomeScrollLiveBtnView *leftView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"海外" direction:ArrowDirectionRight];
        [leftView setClickBock:^{
            [DCSVProgressHUD showInfoWithStatus:@"海外"];
            !weakSelf.abroadClickBlock?:weakSelf.abroadClickBlock();
        }];
        [headView addSubview:leftView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
            make.centerY.offset(-2);
            make.centerX.offset(-40);
        }];
        
        BidLiveHomeScrollLiveBtnView *rightView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"国内" direction:ArrowDirectionRight];
        [rightView setClickBock:^{
            [DCSVProgressHUD showInfoWithStatus:@"国内"];
            !weakSelf.internalClickBlock?:weakSelf.internalClickBlock();
        }];
        
        [headView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
            make.centerY.offset(-2);
            make.centerX.offset(40);
        }];
    }
    
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0||indexPath.section==1) {
        BidLiveHomeScollLiveNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BidLiveHomeScollLiveNormalCell" forIndexPath:indexPath];
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xf8f8f8);
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    UIView *cellMainView = [UIView new];
    cellMainView.backgroundColor = UIColor.cyanColor;
    [cell.contentView addSubview:cellMainView];
    [cellMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.bottom.offset(0);
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [DCSVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"item：%ld",indexPath.item]];
}


#pragma mark - lazy
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 15.0) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        
        
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        UINib *nib = [BidLiveBundleRecourseManager getBundleNib:@"BidLiveHomeScollLiveNormalCell" type:@"nib"];
        [_tableView registerNib:nib forCellReuseIdentifier:@"BidLiveHomeScollLiveNormalCell"];
    }
    return _tableView;
}
@end

