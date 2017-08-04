//
//  itmObject.h
//  itmSDK
//
//  Created by HeXingang on 2017/7/25.
//  Copyright © 2017年 AiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface itmObject : NSObject

- (void)callFunctions:(void (^)(void))funs afterDelay:(float)delay;
- (void)callFunctions:(void(^)(void))func completed:(void(^)(void))completed;

@end
