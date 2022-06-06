//
//  BidLiveHomeComponent.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/27.
//

#import "BidLiveHomeComponent.h"
#import "BidLiveHomeMainView.h"
#import "BidLiveHomeScrollMainView.h"
#import "DCSVProgressHUD.h"
#import "LCConfig.h"

#define sOnEventGlobalSaleClicked @"onEventGlobalSaleClicked"
#define sOnEventSearchClicked @"onEventSearchClicked"

@interface BidLiveHomeComponent ()
@property (nonatomic, strong) BidLiveHomeMainView *mainView;
@property (nonatomic, strong) BidLiveHomeScrollMainView *mainScrollView;
@property (nonatomic, assign) BOOL onGlobalSaleClickEvent;
@property (nonatomic, assign) BOOL onSearchClickEvent;
@end

@implementation BidLiveHomeComponent

#pragma mark - 暴露给前端的方法
UNI_EXPORT_METHOD(@selector(updateFrameWithWidth:height:))

-(void)onCreateComponentWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events uniInstance:(DCUniSDKInstance *)uniInstance
{
}

- (UIView *)loadView {
//    return self.mainView;
    return self.mainScrollView;
}

-(void)viewDidLoad {
    
}

-(void)updateFrameWithWidth:(CGFloat)width height:(CGFloat)height {
    NSLog(@"width=%f, height=%f",width,height);
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame = self.view.frame;
        frame.size.width = width;
        frame.size.height = height;
        self.view.frame = frame;
        BidLiveHomeMainView *mainView = [[BidLiveHomeMainView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        [self.view addSubview:mainView];
    });
}

-(void)addEvent:(NSString *)eventName {
    if ([eventName isEqualToString:sOnEventGlobalSaleClicked]) {
        self.onGlobalSaleClickEvent = YES;
    }
    if ([eventName isEqualToString:sOnEventSearchClicked]) {
        self.onSearchClickEvent = YES;
    }
}

-(void)removeEvent:(NSString *)eventName {
    if ([eventName isEqualToString:sOnEventGlobalSaleClicked]) {
        self.onGlobalSaleClickEvent = NO;
    }
    if ([eventName isEqualToString:sOnEventSearchClicked]) {
        self.onSearchClickEvent = NO;
    }
}

#pragma mark - lazy
-(BidLiveHomeMainView *)mainView {
    DCSVProgressHUD *hud = [[DCSVProgressHUD alloc] init];
    hud.maximumDismissTimeInterval = 1;
    if (!_mainView) {
        _mainView = [[BidLiveHomeMainView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        WS(weakSelf)
        [_mainView setGlobalSaleClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"全球拍卖"];
            if (weakSelf.onGlobalSaleClickEvent) {
                [weakSelf fireEvent:sOnEventGlobalSaleClicked params:@{@"detail":@{@"desc":@"全球拍卖"}} domChanges:nil];
            }
        }];
        
        [_mainView setAppraisalClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"鉴定"];
        }];
        
        [_mainView setCountrySaleClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"国内拍卖"];
        }];
        
        [_mainView setSendClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"送拍"];
        }];
        
        [_mainView setSpeechClassClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"讲堂"];
        }];
        
        [_mainView setInformationClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"资讯"];
        }];
    }
    return _mainView;
}

-(BidLiveHomeScrollMainView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[BidLiveHomeScrollMainView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        _mainScrollView.backgroundColor = UIColor.cyanColor;
        WS(weakSelf)
#pragma mark - 搜索点击事件
        [_mainScrollView setSearchClickBlock:^{
            if (weakSelf.onSearchClickEvent) {
                [weakSelf fireEvent:sOnEventSearchClicked params:@{@"detail":@{@"desc":@"搜索"}} domChanges:nil];
            }
        }];
#pragma mark - 全球拍卖点击事件
        [_mainScrollView setGlobalSaleClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"全球拍卖"];
            if (weakSelf.onGlobalSaleClickEvent) {
                [weakSelf fireEvent:sOnEventGlobalSaleClicked params:@{@"detail":@{@"desc":@"全球拍卖"}} domChanges:nil];
            }
        }];
#pragma mark - 鉴定点击事件
        [_mainScrollView setAppraisalClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"鉴定"];
        }];
#pragma mark - 国内拍卖点击事件
        [_mainScrollView setCountrySaleClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"国内拍卖"];
        }];
#pragma mark - 送拍点击事件
        [_mainScrollView setSendClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"送拍"];
        }];
#pragma mark - 讲堂点击事件
        [_mainScrollView setSpeechClassClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"讲堂"];
        }];
#pragma mark - 资讯点击事件
        [_mainScrollView setInformationClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"资讯"];
        }];
    }
    return _mainScrollView;
}

@end


