//
//  AYBrushView.h
//  AYMovePanel
//
//  Created by Clintlin on 2017/4/26.
//  Copyright © 2017年 zhangxinming. All rights reserved.
//

#import <Foundation/Foundation.h>

@class itmPoint;

@interface itmBrushView : UIView
+ (instancetype)showInView:(UIView *)view;

- (void)paintPathWithRect:(CGRect)rect;
- (void)paintPathEndWithPoints:(NSArray <itmPoint *> *)pts;


@end
