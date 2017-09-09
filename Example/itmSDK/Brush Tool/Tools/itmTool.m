//
//  AYTool.m
//  AYMovePanel
//
//  Created by Clintlin on 2017/4/26.
//  Copyright © 2017年 zhangxinming. All rights reserved.
//

#import "itmTool.h"


@implementation itmTool

+(id)tool{
    itmTool * tool = [[[self class] alloc] init];
    return tool;
}

- (NSString *) iconName
{
    return nil;
}

- (NSString *) landscapeIconName
{
    return nil;
}

- (id) icon
{
    return [UIImage imageNamed:self.iconName];
}

- (id) landscapeIcon
{
    return [UIImage imageNamed:self.landscapeIconName];
}

- (void) activated
{
}

- (void) deactivated
{
}

// 可以选择用手势
- (void) gestureBegan:(UIGestureRecognizer *)recognizer{
    moved_ = NO;
}
- (void) gestureMoved:(UIGestureRecognizer *)recognizer{
    moved_ = YES;
}
- (void) gestureEnded:(UIGestureRecognizer *)recognizer{
    
}
- (void) gestureCanceled:(UIGestureRecognizer *)recognizer{
    
}

// touches 事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches{
    moved_ = NO;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches{
    moved_ = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches{
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches{
    
}


- (NSString *) description{
    
    NSDictionary * dict = @{
                            @"color": [self.color description],
                            @"width": [@(self.width) description]};
    
    
    return [NSString stringWithFormat:@"%@: %@", [super description],[dict description]];
    
}

@end
