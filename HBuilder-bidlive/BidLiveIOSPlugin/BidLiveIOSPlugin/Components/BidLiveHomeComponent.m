//
//  BidLiveHomeComponent.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/27.
//

#import "BidLiveHomeComponent.h"
#import "BidLiveHomeScrollMainView.h"
#import "BidLiveHomeViewController.h"
#import "DCSVProgressHUD.h"
#import "LCConfig.h"

#define sOnEventGlobalSaleClicked @"onEventGlobalSaleClicked"
#define sOnTurnPageEvent @"onTurnPage"

@interface BidLiveHomeComponent ()
@property (nonatomic, strong) BidLiveHomeScrollMainView *mainScrollView;
@property (nonatomic, assign) BOOL onTurnPage;
@property (nonatomic, strong) BidLiveHomeViewController *homeVC;
@end

@implementation BidLiveHomeComponent

-(void)onCreateComponentWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events uniInstance:(DCUniSDKInstance *)uniInstance
{
}

- (UIView *)loadView {
    return self.homeVC.view;
//    return self.mainScrollView;
}

-(void)viewDidLoad {
    
}

-(void)addEvent:(NSString *)eventName {
    if ([eventName isEqualToString:sOnTurnPageEvent]) {
        self.onTurnPage = YES;
    }
}

-(void)removeEvent:(NSString *)eventName {
    if ([eventName isEqualToString:sOnTurnPageEvent]) {
        self.onTurnPage = NO;
    }
}

#pragma mark - lazy
-(BidLiveHomeViewController *)homeVC {
    if (!_homeVC) {
        _homeVC = [[BidLiveHomeViewController alloc] init];
        WS(weakSelf)
#pragma mark - 搜索点击事件
        [_homeVC setSearchClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/auction/search/index?areas=other"}} domChanges:nil];
            }
        }];
#pragma mark - 全球拍卖点击事件
        [_homeVC setGlobalSaleClickBlock:^{
            [DCSVProgressHUD showInfoWithStatus:@"全球拍卖"];
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@""}} domChanges:nil];
            }
        }];
#pragma mark - 鉴定点击事件
        [_homeVC setAppraisalClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@""}} domChanges:nil];
            }
        }];
#pragma mark - 国内拍卖点击事件
        [_homeVC setCountrySaleClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@""}} domChanges:nil];
            }
        }];
#pragma mark - 送拍点击事件
        [_homeVC setSendClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@""}} domChanges:nil];
            }
        }];
#pragma mark - 讲堂点击事件
        [_homeVC setSpeechClassClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@""}} domChanges:nil];
            }
        }];
#pragma mark - 资讯点击事件
        [_homeVC setInformationClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@""}} domChanges:nil];
            }
        }];
    }
    return _homeVC;
}
-(BidLiveHomeScrollMainView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[BidLiveHomeScrollMainView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        _mainScrollView.backgroundColor = UIColor.cyanColor;
       
    }
    return _mainScrollView;
}

@end


