//
//  LCConfig.h
//  OCTools
//
//  Created by stray s on 2022/4/1.
//

#ifndef LCConfig_h
#define LCConfig_h

//弱引用
#define WEAK_SELF(weakeSelf) __weak typeof(self) weakeSelf = self
#define WEAK @weakify(self);

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//强引用
#define STRONG_SELF(strongself , weakSelf) __strong typeof(self) strongself = weakSelf;
#define STRONG @strongify(self);

//判断数据类型
#define IS_STRING(a)    (a && ![a isKindOfClass:[NSNull class]] && ![a isEqualToString:@"null"] && [a isKindOfClass:[NSString class]] && [(NSString *)a length])
#define IS_DIC(a)       (a && [a isKindOfClass:[NSDictionary class]])
#define IS_ARRAY(a)     (a && [a isKindOfClass:[NSArray class]] && a.count)

//  字体
#define MediumStr @"PingFangSC-Regular"
#define RegularStr  @"PingFangSC-Regular"
#define BoldStr  @"PingFangSC-Semibold"

#define isIPhoneX (iPhoneX==YES || iPhoneXR==YES  || iPhoneXSMax==YES)
//底部安全高度
#define BOTTOM_SAFE_HEIGHT (isIPhoneX ? 34 : 0)
//系统手势高度
#define SYSTEM_GESTURE_HEIGHT (isIPhoneX ? 13 : 0)
//tabbar高度
#define TABBAR_HEIGHT (49 + BOTTOM_SAFE_HEIGHT)
//状态栏高度
#define STATUS_HEIGHT (isIPhoneX ? 44 : 20)
//导航栏高
#define NAVBAR_HEIGHT 44
//顶部总的高度
#define TOP_HEIGHT (NAVBAR_HEIGHT + STATUS_HEIGHT)

//AppDelegate
#define DF_APP AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate

//屏幕尺寸
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define AUTO_WIDTH(w)   (w*[UIScreen mainScreen].bounds.size.width/375.0f)
#define AUTO_HEIGHT(h)  (h*[UIScreen mainScreen].bounds.size.height/667.0f)

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define isPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//判断iPhone4系列
//判断设备是否是4s
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size):NO)
//判断设备是否是5s
#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size):NO)
//判断设备是否是6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size):NO)
////判断设备是否是6p
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size):NO)
//判断iPhoneX
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPHoneXR
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXS
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs Max
#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)


//iPhoneX 系列适配
#define CPIStatusBarHeight ((iPhoneX==YES || iPhoneXR==YES  || iPhoneXSMax==YES) ? 44 : 20)
#define CPISafeAreaBottomHeight ((iPhoneX==YES || iPhoneXR==YES || iPhoneXSMax==YES) ? 34 : 0)
#define CPINavigationBarHeight (CPIStatusBarHeight+[UINavigationController new].navigationBar.frame.size.height)
#define CPITabbarHeight (CPISafeAreaBottomHeight+49)

#define CPITabbarHeight49 49

#define CPITabbarHeightIPAD 59

#define IMAGE_HEIGHT (88 + CPINavigationBarHeight + CPISafeAreaBottomHeight)

//判断是否是ipad
//#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
////判断iPHoneXr
//#define kIs_iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
////判断iPhoneXs
//#define kIs_iPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
////判断iPhoneXs Max
//#define kIs_iPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

// iPhoneX / iPhoneXs
#define kIs_iPhoneX         (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f)
// iPhoneXR / iPhoneXSMax
#define kIs_iPhoneXs_Max    (SCREEN_WIDTH >= 414.f && SCREEN_HEIGHT >= 896.f)

#define kStatusBarHeight                    ((kIs_iPhoneX==YES || kIs_iPhoneXs_Max== YES) ? 44.0 : 20.0)
#define kTabBarHeight                       ((kIs_iPhoneX==YES || kIs_iPhoneXs_Max== YES) ? 83.0 : 49.0)
#define kStatusBarAndNavigationBarHeight    ((kIs_iPhoneX==YES || kIs_iPhoneXs_Max== YES) ? 88.f : 64.f)
#define kTabbarSafeTopMargin                ((kIs_iPhoneX==YES || kIs_iPhoneXs_Max== YES) ? 24.f : 0.f)
#define kTabbarSafeBottomMargin             ((kIs_iPhoneX==YES || kIs_iPhoneXs_Max== YES) ? 34.f : 0.f)

#define kIs_iPhone5 ([[LLPhoneData getPhoneModel] isEqualToString:@"iPhone 5"] || [[LLPhoneData getPhoneModel] isEqualToString:@"iPhone 5c"] || [[LLPhoneData getPhoneModel] isEqualToString:@"iPhone 5s"] || [[LLPhoneData getPhoneModel] isEqualToString:@"iPhone SE"])
#define kIs_iPhone7p [[LLPhoneData getPhoneModel] isEqualToString:@"iPhone 7 Plus"]
#define kIs_iPhoneXr [[LLPhoneData getPhoneModel] isEqualToString:@"iPhone XR"]
//color
#define DF_COLOR_0x(rgbValue)       ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

#define DF_COLOR_0x_alpha(rgbValue,a) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)a])
#define DF_COLOR(a,b,c)             [UIColor colorWithRed:(a)/255.0f green:(b)/255.0f blue:(c)/255.0f alpha:1]
#define DF_COLOR_ALPHA(a,b,c,al)    [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:al]
#define DF_COLOR_WC(a)              DF_COLOR(a,a,a)
#define rgba(r, g, b, a)            DF_COLOR_ALPHA(r, g, b, a)
#define RGBA(r, g, b, a)            DF_COLOR_ALPHA(r, g, b, a)
#define DF_COLOR_BGMAIN             DF_COLOR(243, 244, 245)
#define DF_COLOR_HL                 rgba(39, 194, 194, 1)
#define DF_COLOR_GRAY               rgba(142, 135, 154, 1)
#define DF_COLOR_RED                DF_COLOR_0x(0xFF5B5B)
#define DF_COLOR_LINE               rgba(255, 255, 255, 0.2)

#define gMCColorWithHex(hexValue, alphaValue) ([UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f green:((hexValue >> 8) & 0x000000FF)/255.0f blue:((hexValue) & 0x000000FF)/255.0 alpha:alphaValue])

#define HEX333333 DF_COLOR_0x(0x333333)
#define HEX666666 DF_COLOR_0x(0x666666)
#define HEX999999 DF_COLOR_0x(0x999999)

#define SeparatorColor  DF_COLOR_0x(0xE4E3E7)
#define PinkColor       DF_COLOR_0x(0xFE849D)

#define RGBColor(r,g,b,a) [[UIColor alloc]initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) [[UIColor alloc]initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)

// App 主色调,大致为橙色
#define OTLAppMainColor RGBColor(247, 147, 30, 1)
#define Color76C0EF UIColorFromRGB(0x76C0EF)

#endif /* LCConfig_h */
