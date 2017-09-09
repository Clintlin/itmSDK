//
//  AYBrushTool.h
//  AYMovePanel
//
//  Created by Clintlin on 2017/4/26.
//  Copyright © 2017年 zhangxinming. All rights reserved.
//

#import "itmTool.h"

@class DSPath,itmBrushView,itmPoint;
@interface itmBrushTool : itmTool{
    BOOL                    firstEver_;
    NSMutableArray          <itmPoint *>*accumulatedStrokePoints_;
    CGPoint                 lastLocation_;
    CGPoint                 startLocation_;
    float                   lastRemainder_;
    
    BOOL                    clearBuffer_;
    CGRect                  strokeBounds_;
    
    itmPoint               *oldPoints[5];
    itmPoint               *shortPoints[2];
    int                     pointsIndex_;
}

@property (nonatomic , strong) UIBezierPath * oldPath;
@property (nonatomic) CGPoint center;


- (NSString *) description;

- (void)configPath;
//- (void) paintPath:(DSPath *)path inCanvas:(DSCanvas *)canvas;
- (UIBezierPath *) createPathWithPoints:(NSArray *)pts;
//- (UIBezierPath *) createPathForReplayModeWithPoints:(NSArray *)pts;
- (void) storke:(BOOL)isRestore;

- (void) gestureBegan:(UIGestureRecognizer *)recognizer;
- (void) gestureMoved:(UIGestureRecognizer *)recognizer;
- (void) gestureEnded:(UIGestureRecognizer *)recognizer;

- (void)touchesBegan:(NSSet<UITouch *> *)touches;
- (void)touchesMoved:(NSSet<UITouch *> *)touches;
- (void)touchesEnded:(NSSet<UITouch *> *)touches;

- (NSMutableArray <itmPoint *>*)allPoints;


@end
