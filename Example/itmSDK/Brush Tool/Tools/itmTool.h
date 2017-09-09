//
//  AYTool.h
//  AYMovePanel
//
//  Created by Clintlin on 2017/4/26.
//  Copyright © 2017年 zhangxinming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class itmPoint;

@interface itmTool : NSObject{
    BOOL        moved_;
}

@property (nonatomic, readonly) BOOL moved;
@property (nonatomic, strong) UIColor * color;
@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, strong) NSArray <itmPoint *>* nodes;

+(id)tool;

- (void) activated;
- (void) deactivated;

// 可以选择用手势
- (void) gestureBegan:(UIGestureRecognizer *)recognizer;
- (void) gestureMoved:(UIGestureRecognizer *)recognizer;
- (void) gestureEnded:(UIGestureRecognizer *)recognizer;
- (void) gestureCanceled:(UIGestureRecognizer *)recognizer;

// touches 事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches;
- (void)touchesMoved:(NSSet<UITouch *> *)touches;
- (void)touchesEnded:(NSSet<UITouch *> *)touches;

- (void)touchesCancelled:(NSSet<UITouch *> *)touches;
@end
