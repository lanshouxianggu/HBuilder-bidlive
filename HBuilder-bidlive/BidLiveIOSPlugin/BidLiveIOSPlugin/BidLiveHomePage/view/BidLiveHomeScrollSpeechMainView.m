//
//  BidLiveHomeScrollSpeechMainView.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScrollSpeechMainView.h"
#import "Masonry.h"
#import "LCConfig.h"
#import "BidLiveBundleRecourseManager.h"
#import "DCSVProgressHUD.h"
#import "BidLiveHomeScrollSpeechCell.h"
#import "BidLiveHomeScrollLiveBtnView.h"

@interface BidLiveHomeScrollSpeechMainView () <UITableViewDelegate,UITableViewDataSource>
///是否点击了更多
@property (nonatomic, assign) BOOL isClickMore;
///点击更多次数，点击更多两次，只显示收起按钮
@property (nonatomic, assign) NSInteger clickMoreTimes;
///是否点击了收起
@property (nonatomic, assign) BOOL isClickBack;
@end

@implementation BidLiveHomeScrollSpeechMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.videosArray = [NSMutableArray array];
        self.isClickBack = YES;
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

-(void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videosArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (SCREEN_WIDTH-30)*405.5/537;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 90;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [UIView new];
    headView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    
    UIImage *image = [BidLiveBundleRecourseManager getBundleImage:@"indexBlock4" type:@"png"];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    [headView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.mas_equalTo(44*3.23);
        make.height.mas_equalTo(44);
    }];
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [UIView new];
    footView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    WS(weakSelf)
    if (self.clickMoreTimes==0) {
        BidLiveHomeScrollLiveBtnView *rightView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"更多" direction:ArrowDirectionDown];
        [rightView setClickBock:^{
            weakSelf.isClickMore = YES;
            weakSelf.isClickBack = NO;
            weakSelf.clickMoreTimes++;
            [DCSVProgressHUD showInfoWithStatus:@"更多"];
            !weakSelf.moreClickBlock?:weakSelf.moreClickBlock();
        }];
        
        [footView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
            make.centerX.offset(-2);
            make.bottom.offset(-10);
        }];
    }else if (self.clickMoreTimes>0 && self.clickMoreTimes<2) {
        BidLiveHomeScrollLiveBtnView *leftView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"收起" direction:ArrowDirectionUp];
        [leftView setClickBock:^{
            [DCSVProgressHUD showInfoWithStatus:@"收起"];
            weakSelf.isClickBack = YES;
            weakSelf.isClickMore = NO;
            weakSelf.clickMoreTimes = 0;
            !weakSelf.retractingClickBlock?:weakSelf.retractingClickBlock();
        }];
        [footView addSubview:leftView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
            make.bottom.offset(-10);
            make.centerX.offset(-40);
        }];
        
        BidLiveHomeScrollLiveBtnView *rightView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"更多" direction:ArrowDirectionDown];
        [rightView setClickBock:^{
            weakSelf.isClickMore = YES;
            weakSelf.isClickBack = NO;
            weakSelf.clickMoreTimes++;
            [DCSVProgressHUD showInfoWithStatus:@"更多"];
            !weakSelf.moreClickBlock?:weakSelf.moreClickBlock();
        }];
        
        [footView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
            make.centerX.offset(40);
            make.bottom.offset(-10);
        }];
    }else {
        BidLiveHomeScrollLiveBtnView *rightView = [[BidLiveHomeScrollLiveBtnView alloc] initWithFrame:CGRectZero title:@"收起" direction:ArrowDirectionUp];
        [rightView setClickBock:^{
            weakSelf.isClickMore = YES;
            weakSelf.isClickBack = NO;
            weakSelf.clickMoreTimes=0;
            [DCSVProgressHUD showInfoWithStatus:@"收起"];
            !weakSelf.retractingClickBlock?:weakSelf.retractingClickBlock();
        }];
        
        [footView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
            make.centerX.offset(-2);
            make.bottom.offset(-10);
        }];
    }
    
    
    return footView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BidLiveHomeScrollSpeechCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BidLiveHomeScrollSpeechCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xf8f8f8);
    cell.model = self.videosArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.cellClickBlock?:self.cellClickBlock(self.videosArray[indexPath.row]);
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
        UINib *nib = [BidLiveBundleRecourseManager getBundleNib:@"BidLiveHomeScrollSpeechCell" type:@"nib"];
        [_tableView registerNib:nib forCellReuseIdentifier:@"BidLiveHomeScrollSpeechCell"];
    }
    return _tableView;
}

@end
