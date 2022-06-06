//
//  TestComponent.h
//  DCTestUniPlugin
//
//  Created by XHY on 2020/4/23.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "DCUniComponent.h"
#import <TXLiteAVSDK_Smart/TXLiteAVSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface TxLiveComponent : DCUniComponent<TXLivePushListener>
@property (nonatomic, strong) TXLivePush *pusher;

@end

NS_ASSUME_NONNULL_END
