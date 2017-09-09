//
//  AYBrushView.m
//  AYMovePanel
//
//  Created by Clintlin on 2017/4/26.
//  Copyright © 2017年 zhangxinming. All rights reserved.
//

#import "itmBrushView.h"
#import "itmBrushTool.h"
#import "AYPalletToolbar.h"
#import <itmSDK/itmSDK.h>

@interface itmBrushView ()<UIGestureRecognizerDelegate, AYPalletToolbarDelegate>
//@property (nonatomic, strong) AYCanvasToolbar * toolbar;
@property (nonatomic, strong) AYPalletToolbar*  toolbar;
@property (nonatomic, strong) itmBrushTool * activeTool;
@end

@implementation itmBrushView{
    BOOL isReplaying ,isDrawing,willDraw, isTouchOnCompones;
}

+ (instancetype)showInView:(UIView *)view{
    itmBrushView * bv = [[itmBrushView alloc] init];
    [bv setupView:view];
    [bv setupSubviews];
    return bv;
}


- (void) setupView:(UIView *)view {
    [view addSubview:self];
    
    self.frame = view.bounds;
    [self setBackgroundColor:[UIColor clearColor]];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupSubviews {
    
    _toolbar = [AYPalletToolbar showInView:self];
    _toolbar.delegate = self;
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return [touch.view isKindOfClass:[self class]];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
//        isTouchOnCompones = ![gesture.view isKindOfClass:[self class]];
//        if (isTouchOnCompones) return;
        [self.activeTool gestureBegan:gesture];
    
        self.activeTool = [itmBrushTool tool];
        self.activeTool.width = self.toolbar.lineWidth;
        self.activeTool.color = [self.toolbar selectColor];
        [self.toolbar hideBrushItems:YES];
        
    }else if (gesture.state == UIGestureRecognizerStateChanged){
//        if (isTouchOnCompones) return;

        isDrawing = YES;
        [self.activeTool gestureMoved:gesture];
    }else if (gesture.state == UIGestureRecognizerStateEnded){
//        if (isTouchOnCompones) return;
    
        [self.activeTool gestureEnded:gesture];
        if (willDraw && !isDrawing) {
            willDraw = NO;
            //画一个点
            return;
        }
        isDrawing = NO;
        [self.activeTool gestureEnded:gesture];
    }
    
}


- (void)drawRect:(CGRect)rect{

    NSArray <itmPoint *>* pts = [self.activeTool.allPoints reverseObjectEnumerator].allObjects;
    
    NSInteger ptsCount = 5;
    if (pts.count >= ptsCount) {
        pts = [pts subarrayWithRange:NSMakeRange(0, ptsCount)];
    }
    [self.activeTool createPathWithPoints:pts];
    [self.activeTool storke:NO];
    
    [self startDrawingLineWithPoints:pts path:self.activeTool.oldPath color:self.activeTool.color.CGColor];
    
}

- (void)paintPathWithRect:(CGRect)rect{
    
//    [self setNeedsDisplay];
    // rect 为需要渲染的区域
    [self setNeedsDisplayInRect:rect];
}

- (void)paintPathEndWithPoints:(NSArray *)points{
    // 保存整个路径上的所有点
}

#pragma mark PalletToolbarDelegate

- (void)cloesClicked
{
    [self setHidden:YES];
}

- (void)show:(BOOL)animated
{
    self.hidden = NO;
//    [_toolbar show:animated];
}

- (void)hide:(BOOL)animated
{
//    [_toolbar hide:animated];
}

#pragma mark - 讲述模式
- (void)startDrawingLineWithPoints:(NSArray <itmPoint *>*)pts path:(UIBezierPath *)path color:(CGColorRef)color{
    
    if (pts == nil) {
        return;
    }
    
    CAShapeLayer * animationLayer = [CAShapeLayer layer];
    
    animationLayer.path = path.CGPath;
    animationLayer.lineWidth = path.lineWidth;
    animationLayer.strokeColor = color;
    animationLayer.fillColor = [UIColor clearColor].CGColor;
    
    itmTimer * replayerTimer = [[itmTimer alloc] initWithInterval:0.01f
                                                         target:self
                                                       selector:@selector(replayItemDidFinishPlayWithTimer:)];
    replayerTimer.count = 0.f;
    replayerTimer.contentLayer = animationLayer;
    
    // 分解
    //  大意如下：
    //  animationBeginTime,动画将于该时间点执行
    //  gap_time 当前动画要持续的时间
    //
    CAAnimationGroup *group = [CAAnimationGroup animation];
    NSMutableArray * groupAnimation = [@[] mutableCopy];
    
    float kDSLaserPenWillDisappearTime = 0.4;
    double animationBeginTime = 0;
    
    // DSPointDistance
    float theDistance = 0;
    theDistance = DSDistance(pts[0].CGPoint, pts[pts.count-1].CGPoint);
    animationBeginTime = kDSLaserPenWillDisappearTime;
    
    //从点末向下一个点画
    CABasicAnimation * animation = [self createStrokeEndAnimationForPath:@(1)
                                                                      to:@(0)
                                                                duration:kDSLaserPenWillDisappearTime * 0.2];
    animation.beginTime = kDSLaserPenWillDisappearTime * 0.8;
    
    // 添加消失的animation ， 从末端向前端消失
//    CABasicAnimation * fadingAnimation = [self createStrokeStartAnimationForPath:@(1)
//                                                                              to:@(0)
//                                                                        duration:kDSLaserPenWillDisappearTime];
    
//    fadingAnimation.beginTime = 0;
    
    [groupAnimation addObject:animation];
//    [groupAnimation addObject:fadingAnimation];
    
    
    CABasicAnimation * lastAnimation = groupAnimation.lastObject;
    [group setDuration:lastAnimation.beginTime + lastAnimation.duration];
    [group setAnimations:groupAnimation];
    [group setFillMode:kCAFillModeForwards];
    [group setRemovedOnCompletion:NO];
    
    [animationLayer addAnimation:group forKey:nil];
    
    [self.layer addSublayer:animationLayer];
    
    replayerTimer.countEnd = group.duration;
    [replayerTimer fire];
    
    
//    for (int i = 0; i < pts.count - 1; i++) {
//
//        // 动画的开始时间点
//        animationBeginTime += gap_time;
//
//        // 两点之间的持续时间
//        gap_time = pts[i].date.timeIntervalSince1970 - pts[i+1].date.timeIntervalSince1970;
//
//        // 两点之间的距离
//        currentPosition += DSDistance(pts[i+1].CGPoint, pts[i].CGPoint);
//
//        //当前要回放的百分比的起点
//        float fromTime = (currentPosition - DSDistance(pts[i+1].CGPoint, pts[i].CGPoint))/theDistance;
//
//        //当前要回放的百分比的终点
//        float toTime = currentPosition /theDistance;
//
//        //从点末向下一个点画
//        CABasicAnimation * animation = [self createStrokeEndAnimationForPath:@(fromTime)
//                                                                          to:@(toTime)
//                                                                    duration:gap_time];
//        animation.beginTime = 0;
//
//        // 添加消失的animation ， 从末端向前端消失
//        CABasicAnimation * fadingAnimation = [self createStrokeStartAnimationForPath:@(toTime)
//                                                                                  to:@(fromTime)
//                                                                            duration:gap_time];
//
//        fadingAnimation.beginTime = animationBeginTime + kDSLaserPenWillDisappearTime;
//
//        [groupAnimation addObject:animation];
//        [groupAnimation addObject:fadingAnimation];
//
//    }
    
    // 添加并执行动画
//    CABasicAnimation * lastAnimation = groupAnimation.lastObject;
//    [group setDuration:lastAnimation.beginTime + lastAnimation.duration];
//    [group setAnimations:groupAnimation];
//    [group setFillMode:kCAFillModeForwards];
//    [group setRemovedOnCompletion:NO];
//
//    [animationLayer addAnimation:group forKey:nil];
//
//    [self.layer addSublayer:animationLayer];
//
//    replayerTimer.countEnd = group.duration;
//    [replayerTimer fire];
}

- (void)replayItemDidFinishPlayWithTimer:(itmTimer *)timer{
    
    timer.count += timer.timeInterval;
    
    // 停
    if (timer.count >= timer.countEnd) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            CALayer * layer = timer.contentLayer;
            
            [layer setHidden:YES];
            //            [layer removeAllAnimations];
            //            [layer performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:1.0f];
            
        });
        
        //
        [timer invalidate];
        timer = nil;
    }
}

- (CABasicAnimation *)createStrokeEndAnimationForPath:(NSNumber *)fromValue
                                                   to:(NSNumber *)toValue
                                             duration:(float)duration{
    
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = duration;
    
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    return animation;
}

- (CABasicAnimation *)createFadingAnimationForPath:(NSNumber *)fromValue
                                                to:(NSNumber *)toValue
                                          duration:(float)duration{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = duration;
    
    return animation;
    
}

- (CABasicAnimation *)createStrokeStartAnimationForPath:(NSNumber *)fromValue
                                                     to:(NSNumber *)toValue
                                               duration:(float)duration{
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = duration;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    return animation;
}


@end
