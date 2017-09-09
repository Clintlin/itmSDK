//
//  AYBrushView.h
//  AYMovePanel
//
//  Created by Clintlin on 2017/4/26.
//  Copyright © 2017年 zhangxinming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class itmPoint;
@interface AYBrushView : UIView
+ (instancetype)showInView:(UIView *)view;

- (void)paintPathWithRect:(CGRect)rect;
- (void)paintPathEndWithPoints:(NSArray <itmPoint *> *)pts;


@end
