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
#import "BidLiveHomeBannerModel.h"
#import "BidLiveHomeCMSArticleModel.h"
#import "BidLiveHomeGlobalLiveModel.h"
#import "BidLiveHomeHotCourseModel.h"
#import "BidLiveHomeHighlightLotsModel.h"
#import "BidLiveHomeGuessYouLikeModel.h"

#import "MJExtension.h"
#import "NSString+LLStringConnection.h"

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
#pragma mark - 顶部图片广告点击事件
        [_homeVC setBannerClick:^(BidLiveHomeBannerModel * _Nonnull model) {
            if (weakSelf.onTurnPage) {
                NSDictionary *advDic = [model mj_keyValues];
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"banner",@"adv":advDic}} domChanges:nil];
            }
        }];
#pragma mark - 全球拍卖点击事件
        [_homeVC setGlobalSaleClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/auctionHome/index?source=en"}} domChanges:nil];
            }
        }];
#pragma mark - 鉴定点击事件
        [_homeVC setAppraisalClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/identification/expertList"}} domChanges:nil];
            }
        }];
#pragma mark - 国内拍卖点击事件
        [_homeVC setCountrySaleClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/auctionHome/index?source=cn"}} domChanges:nil];
            }
        }];
#pragma mark - 送拍点击事件
        [_homeVC setSendClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/sendPhotos/sendPhotos"}} domChanges:nil];
            }
        }];
#pragma mark - 讲堂点击事件
        [_homeVC setSpeechClassClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/news/index"}} domChanges:nil];
            }
        }];
#pragma mark - 资讯点击事件
        [_homeVC setInformationClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/news/newsHome?p_id=99"}} domChanges:nil];
            }
        }];
#pragma mark - 直播间点击事件
        [_homeVC setLiveRoomClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/live/home/index"}} domChanges:nil];
            }
        }];
#pragma mark - 动态点击事件
        [_homeVC setCmsArticleClickBlock:^(BidLiveHomeCMSArticleModel * _Nonnull model) {
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@""[@"/pages/home/newsDetail?id="][@(model.Id)]}} domChanges:nil];
            }
        }];
#pragma mark - 全球直播cell点击事件
        [_homeVC setGlobalLiveCellClickBlock:^(BidLiveHomeGlobalLiveModel * _Nonnull model) {
            if (weakSelf.onTurnPage) {
                NSString *pageStr = @"";
                if (model.Status==4||model.AuctionCount==1) {
                    pageStr = @""[@"/pages/auction/itemList?id="][@(model.Id)];
                }else if (model.AuctionCount>1) {
                    pageStr = @""[@"/pages/auction/companyAuctionList?id="][@(model.SellerId)];
                }
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":pageStr}} domChanges:nil];
            }
        }];
#pragma mark - 全球直播海外点击事件
        [_homeVC setAbroadClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/auctionHome/index?source=en"}} domChanges:nil];
            }
        }];
#pragma mark - 全球直播国内点击事件
        [_homeVC setInternalClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/auctionHome/index?source=cn"}} domChanges:nil];
            }
        }];
#pragma mark - 名家讲堂cell点击事件
        [_homeVC setSpeechCellClickBlock:^(BidLiveHomeHotCourseListModel * _Nonnull model) {
            if (weakSelf.onTurnPage) {
                NSString *pageStr = @""[@"/pages/lectureHall/videoDetails/videoDetails?courseId="][@(model.courseId)][@"&coverUrl="][model.coverUrl];
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":pageStr}} domChanges:nil];
            }
        }];
#pragma mark - 焦点拍品cell点击事件
        [_homeVC setHighlightLotsCellClickBlock:^(BidLiveHomeHighlightLotsListModel * _Nonnull model) {
            if (weakSelf.onTurnPage) {
                NSString *pageStr = @""[@"/pages/auction/item?auctionItemId="][@(model.id)];
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":pageStr}} domChanges:nil];
            }
        }];
#pragma mark - 猜你喜欢cell点击事件
        [_homeVC setGuessYouLikeCellClickBlock:^(BidLiveHomeGuessYouLikeListModel * _Nonnull model) {
            [weakSelf guessYouLikeCellClickAction:model];
        }];
#pragma mark - 猜你喜欢banner点击事件
        [_homeVC setGuessYouLikeBannerClickBlock:^(BidLiveHomeBannerModel * _Nonnull model) {
            [weakSelf guessYouLikeBannerClickAction:model];
        }];
#pragma mark - 新上拍场点击事件
        [_homeVC setToNewAuctionClickBlock:^{
            if (weakSelf.onTurnPage) {
                [weakSelf fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":@"/pages/auctionHome/newAuctions?source=en"}} domChanges:nil];
            }
        }];
    }
    return _homeVC;
}

-(void)guessYouLikeCellClickAction:(BidLiveHomeGuessYouLikeListModel *)model {
    NSString *pageStr = @"/pages/auction/item?auctionItemId="[@(model.id)];
    if (self.onTurnPage) {
        [self fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":pageStr}} domChanges:nil];
    }
}

-(void)guessYouLikeBannerClickAction:(BidLiveHomeBannerModel *)model {
    NSString *pageStr = @"";
    if ([model.adUrl isEqualToString:@"cn"] || [model.adUrl isEqualToString:@"en"]) {
        pageStr = @"/pages/auction/itemList?id="[model.tag];
    }else if ([model.adUrl isEqualToString:@"cnseller"] || [model.adUrl isEqualToString:@"enseller"]) {
        pageStr = @"/pages/auction/companyAuctionList?id="[model.tag];
    }else if ([model.adUrl isEqualToString:@"jd"]) {
        pageStr = @"/pages/identification/expertDetail?expertId="[model.tag];
    }else if ([model.adUrl isEqualToString:@"sp"]) {
        pageStr = @"/pages/sendPhotos/consignationDetails?id="[model.tag];
    }else if ([model.adUrl isEqualToString:@"recommend"]) {
        pageStr = @"/pages/auctionHome/recommend?id="[model.tag];
    }else if ([model.adUrl isEqualToString:@"jdindex"]) {
        pageStr = @"/pages/identification/expertList";
    }else if ([model.adUrl isEqualToString:@"jtindex"]) {
        pageStr = @"/pages/news/index";
    }else if ([model.adUrl isEqualToString:@"h5"]) {
        //adv.tag.toLocaleLowerCase().indexOf('auctionhome/recommend') > -1
        if (model.tag && [[model.tag lowercaseString] containsString:@"auctionhome/recommend"]) {
            pageStr = @""[model.tag];
        }else {
//            var url = encodeURI(adv.tag)
            pageStr = @"/pages/home/winH5?url="[model.tag];
        }
    }else if ([model.adUrl isEqualToString:@"spindex"]) {
        pageStr = @"/pages/sendPhotos/sendPhotos";
    }else if ([[model.adUrl lowercaseString] hasPrefix:@"http"]) {
//        pageStr = @""[model.adUrl];
        pageStr = @"/pages/home/winH5?url="[model.adUrl];
    }else if ([model.adUrl isEqualToString:@"liveroom"]) {
        ///TODO:
    }else if ([model.adUrl isEqualToString:@"classroom"]) {
        pageStr = @"/pages/lectureHall/videoDetails/videoDetails?courseId="[model.tag][@"&courseContentId=0"];
    }else if ([model.adUrl isEqualToString:@"liveindex"]) {
        pageStr = @"/pages/live/home/index";
    }
    
    if (self.onTurnPage) {
        [self fireEvent:sOnTurnPageEvent params:@{@"detail":@{@"type":@"h5",@"page":pageStr}} domChanges:nil];
    }
}

#pragma mark - lazy
-(BidLiveHomeScrollMainView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[BidLiveHomeScrollMainView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        _mainScrollView.backgroundColor = UIColor.cyanColor;
       
    }
    return _mainScrollView;
}

@end


