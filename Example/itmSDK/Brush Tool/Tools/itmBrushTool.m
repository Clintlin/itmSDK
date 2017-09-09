//
//  AYBrushTool.m
//  AYMovePanel
//
//  Created by Clintlin on 2017/4/26.
//  Copyright © 2017年 zhangxinming. All rights reserved.
//

#import "itmBrushTool.h"
#import "itmBrushView.h"
#import <itmSDK/itmSDK.h>

@implementation itmBrushTool{
    UIBezierPath * _path;
    CGRect _drawingRect;
}

-(instancetype)init{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    _path = [[UIBezierPath alloc] init];
    accumulatedStrokePoints_ = [[NSMutableArray alloc] init];
    return self;
}


- (void) gestureBegan:(UIGestureRecognizer *)recognizer{
    
    [accumulatedStrokePoints_ removeAllObjects];
    
    CGPoint location = [self documentLocationFromGesture:recognizer];
    lastLocation_ = startLocation_ = location;
    
    // 绘画面积
    _drawingRect = CGRectZero;
    
    //
//    _oldPath = [UIBezierPath bezierPath];
//    [_oldPath  moveToPoint:location];
    
    pointsIndex_ = 0;
    _drawingRect = CGRectZero;
    oldPoints[0] = [itmPoint pointWithCGPoint:location z:1.f];
    [accumulatedStrokePoints_ addObject:oldPoints[0]];
}
- (void) gestureMoved:(UIGestureRecognizer *)recognizer{
    
    /**
     DSCanvas    *canvas = (DSCanvas *)recognizer.view;
     CGPoint location = [self documentLocationFromRecognizer:recognizer];
     
     //    float       distanceMoved = DSDistance(startLocation_, location);
     //    if (distanceMoved < 3.0 / canvas.scale) {
     //        // haven't moved far enough
     //        return;
     //    }
     
     pointsIndex_++;
     DS3DPoint * currentPoint = [DS3DPoint point:location Z:1.f];
     //    NSLog(@"%@ -- %@",[currentPoint description],NSStringFromCGPoint(location));
     [accumulatedStrokePoints_ addObject:currentPoint];
     
     
     oldPoints[pointsIndex_] = currentPoint;
     
     
     if (pointsIndex_>0) {
     [self calcuateUpdatedRectsWithPoint:lastLocation_ lastLocation:location];
     }
     
     if (pointsIndex_ == 4) {
     oldPoints[3] = [[oldPoints[2] add:oldPoints[4]] multiplyByScalar:0.5];
     [_oldPath moveToPoint:oldPoints[0].point];
     [_oldPath addCurveToPoint:oldPoints[3].point
     controlPoint1:oldPoints[1].point
     controlPoint2:oldPoints[2].point];
     
     // draw
     [self drawPathInCanvas:canvas withRect:_drawingRect];
     
     // replace pts
     oldPoints[0] = oldPoints[3];
     oldPoints[1] = oldPoints[4];
     pointsIndex_ = 1;
     
     _drawingRect = CGRectZero;
     [self calcuateUpdatedRectsWithPoint:oldPoints[0].point
     lastLocation:oldPoints[1].point];
     }
     
     //
     lastLocation_ = location;
     
     [super gestureMoved:recognizer];
     */
    itmBrushView *canvas = (itmBrushView *)recognizer.view;
    CGPoint     location = [self documentLocationFromGesture:recognizer];
    
    pointsIndex_++;
    itmPoint * currentPoint = [itmPoint pointWithCGPoint:location z:1.f];
    [accumulatedStrokePoints_ addObject:currentPoint];
    
    oldPoints[pointsIndex_] = currentPoint;
    
    
    if (pointsIndex_>0) {
        [self calcuateUpdatedRectsWithPoint:lastLocation_ lastLocation:location];
    }
    
    if (pointsIndex_ == 4) {
        oldPoints[3] = [[oldPoints[2] addPoint:oldPoints[4]] multiplyByScalar:0.5];
        [_oldPath moveToPoint:oldPoints[0].CGPoint];
        [_oldPath addCurveToPoint:oldPoints[3].CGPoint
                    controlPoint1:oldPoints[1].CGPoint
                    controlPoint2:oldPoints[2].CGPoint];
        
        // draw
        [self drawPathInCanvas:canvas withRect:_drawingRect];
        
        // replace pts
        oldPoints[0] = oldPoints[3];
        oldPoints[1] = oldPoints[4];
        pointsIndex_ = 1;
        
        _drawingRect = CGRectZero;
        [self calcuateUpdatedRectsWithPoint:oldPoints[0].CGPoint
                               lastLocation:oldPoints[1].CGPoint];
    }
    
    //
    lastLocation_ = location;
    
}
- (void) gestureEnded:(UIGestureRecognizer *)recognizer{
    itmBrushView *canvas = (itmBrushView *)recognizer.view;
    CGPoint     location = [self documentLocationFromGesture:recognizer];
    
    [accumulatedStrokePoints_ addObject:[itmPoint pointWithCGPoint:location z:1.f]];
    
    // draw
    [canvas paintPathEndWithPoints:accumulatedStrokePoints_];
    
    self.nodes = accumulatedStrokePoints_;
    [_oldPath removeAllPoints];
}






- (void)touchesBegan:(NSSet<UITouch *> *)touches{
    [super touchesBegan:touches];
    
    [accumulatedStrokePoints_ removeAllObjects];
    
    CGPoint location = [self documentLocationFromRecognizer:touches];
    lastLocation_ = startLocation_ = location;
    
    // 绘画面积
    _drawingRect = CGRectZero;
    
    //
    _oldPath = [UIBezierPath bezierPath];
    [_oldPath  moveToPoint:location];
    
    pointsIndex_ = 0;
    _drawingRect = CGRectZero;
    oldPoints[0] = [itmPoint pointWithCGPoint:location z:1.f];
    [accumulatedStrokePoints_ addObject:oldPoints[0]];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches{
    [super touchesMoved:touches];
    
    itmBrushView *canvas = (itmBrushView *)touches.anyObject.view;
    CGPoint     location = [self documentLocationFromRecognizer:touches];
    
    pointsIndex_++;
    itmPoint * currentPoint = [itmPoint pointWithCGPoint:location z:1.f];
    [accumulatedStrokePoints_ addObject:currentPoint];
    
    oldPoints[pointsIndex_] = currentPoint;
    
//    if (pointsIndex_>0) {
//        [self calcuateUpdatedRectsWithPoint:lastLocation_ lastLocation:location];
//    }
    
    if (pointsIndex_ == 4) {
        oldPoints[3] = [[oldPoints[2] addPoint:oldPoints[4]] multiplyByScalar:0.5];
        [_oldPath moveToPoint:oldPoints[0].CGPoint];
        [_oldPath addCurveToPoint:oldPoints[3].CGPoint
                    controlPoint1:oldPoints[1].CGPoint
                    controlPoint2:oldPoints[2].CGPoint];
        
        // draw
        [self drawPathInCanvas:canvas withRect:_drawingRect];
        
        // replace pts
        oldPoints[0] = oldPoints[3];
        oldPoints[1] = oldPoints[4];
        pointsIndex_ = 1;
        
        _drawingRect = CGRectZero;
//        [self calcuateUpdatedRectsWithPoint:oldPoints[0].CGPoint
//                               lastLocation:oldPoints[1].CGPoint];
    }
    
    //
    lastLocation_ = location;
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches{
    [super touchesEnded:touches];
    
    itmBrushView *canvas = (itmBrushView *)touches.anyObject.view;
    CGPoint     location = [self documentLocationFromRecognizer:touches];
    
    [accumulatedStrokePoints_ addObject:[itmPoint pointWithCGPoint:location z:1.f]];
    
    // draw
    [canvas paintPathEndWithPoints:accumulatedStrokePoints_];
    
    self.nodes = accumulatedStrokePoints_;
    [_oldPath removeAllPoints];
}

- (CGPoint) documentLocationFromRecognizer:(NSSet<UITouch *> *)touches
{
    UITouch * touch = touches.anyObject;
    itmBrushView * canvas = (itmBrushView *)touch.view;
    return [touch locationInView:canvas];
}

- (CGPoint) documentLocationFromGesture:(UIGestureRecognizer *)gesture
{
    itmBrushView * canvas = (itmBrushView *)gesture.view;
    return [gesture locationInView:canvas];
}

// 计算绘画面积
-(void)calcuateUpdatedRectsWithPoint:(CGPoint)c lastLocation:(CGPoint)p{
    float _lineWidth = self.width;
    
    CGFloat minX = fmin(p.x, c.x) - _lineWidth * 0.5;
    CGFloat minY = fmin(p.y, c.y) - _lineWidth * 0.5;
    CGFloat maxX = fmax(p.x, c.x) + _lineWidth * 0.5;
    CGFloat maxY = fmax(p.y, c.y) + _lineWidth * 0.5;
    CGRect dirtyRect = CGRectMake(minX, minY, (maxX - minX), (maxY - minY));
    _drawingRect = dirtyRect;
}

- (void) drawPathInCanvas:(itmBrushView *)canvas withRect:(CGRect)rect{
    
    [canvas paintPathWithRect:rect];
}

- (UIBezierPath *) createPathWithPoints:(NSArray *)pts
{
    _oldPath = [UIBezierPath bezierPath];
    int pointIndex = 0;
    oldPoints[0] = nil;
    for (itmPoint * pt in pts) {
        
        if (pointIndex == 0 && oldPoints[0] == nil) {
            oldPoints[0] = [pt copy];
            [_oldPath moveToPoint:oldPoints[0].CGPoint];
            continue;
        }
        
        pointIndex++;
        oldPoints[pointIndex] = [pt copy];
        
        if (pointIndex == 2) {
            itmPoint * mP = [[oldPoints[1] addPoint:oldPoints[2]] multiplyByScalar:0.5];
            [_oldPath addQuadCurveToPoint:mP.CGPoint controlPoint:oldPoints[1].CGPoint];
            
            // replace pts
            oldPoints[1] = oldPoints[2];
            pointIndex = 1;
        }
    }
    
    
    return _oldPath;
}

- (void)configPath{
    
    [_oldPath setLineCapStyle:kCGLineCapRound];
    [_oldPath setLineJoinStyle:kCGLineJoinRound];
    
    // size
    [_oldPath setLineWidth:self.width];
    
    [self.color setStroke];
}

- (void) storke:(BOOL)isRestore{
    
    [self configPath];
}

- (NSMutableArray <itmPoint *>*)allPoints {
    return accumulatedStrokePoints_;
}
- (NSString *) description{
    return [super description];
}
@end
