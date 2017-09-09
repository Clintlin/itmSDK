//
//  AYPalletToolbar.m
//  AYMovePanel
//
//  Created by HeXingang on 2017/7/5.
//  Copyright © 2017年 zhangxinming. All rights reserved.
//

#import "AYPalletToolbar.h"
#import <itmSDK/itmSDK.h>


@interface AYPalletToolbar()<CAAnimationDelegate>
{
    UIButton* _closeButton;
    UIButton* _brushWidthButton;
    
    BOOL      _brushItemIsShow;
    
    itmTimer*   _brushItemShowTimer;
}

@property (nonatomic, strong) UIScrollView*     palletBgView;
@property (nonatomic, strong) UIButton*         brushItem_L;
@property (nonatomic, strong) UIButton*         brushItem_M;
@property (nonatomic, strong) UIButton*         brushItem_S;

@end


CGFloat kAYPalletToolbarHeight          = 100.f;
CGFloat kAYPalletToolbarRightAreaWidth  = 130.f;
CGFloat kAYPalletToolbarRightGap        = 23.f;
CGFloat kAYPalletToolbarColorLumpWidth  = 72.f;
CGFloat kAYPalletToolbarColorLumpGap    = 20.f;
CGFloat kAYPalletToolbarCloseWidth      = 96.f;
CGFloat kAYPalletToolbarCloseHeight     = 70.f;
CGFloat kAYPalletToolbarColorsMargin    = 40.f;

CGFloat kBrushItemShowAnimateDuration = 0.2f;
CGFloat kBrushItemShowInterval = 4.f;

@implementation AYPalletToolbar


+ (instancetype)showInView:(UIView *)view{
    
    AYPalletToolbar* toolbar = [[AYPalletToolbar alloc] init];
    [view addSubview:toolbar];
    return toolbar;
}

- (instancetype)init
{
    if(self = [super init]){
        [self setBackgroundColor:[[itmColor colorWithHexString:@"dddddd" alpha:0.6] UIColor]];
        [self setFrame:CGRectMake(0,
                                  kScreenHeight - itmConverToPtFromPx(kAYPalletToolbarHeight),
                                  kScreenWidth,
                                  itmConverToPtFromPx(kAYPalletToolbarHeight))];
        self.lineWidth = 3.f;
        [self setupSubviews];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if(_brushItem_L){
        [_brushItem_L removeFromSuperview];
        _brushItem_L = nil;
    }
    if(_brushItem_M){
        [_brushItem_M removeFromSuperview];
        _brushItem_M = nil;
    }
    if(_brushItem_S){
        [_brushItem_S removeFromSuperview];
        _brushItem_S = nil;
    }
}

- (void)setupSubviews
{
    
    CGFloat width = MIN(kScreenWidth, kScreenHeight);
    
    CGFloat margin = itmConverToPtFromPx(kAYPalletToolbarColorsMargin);
    CGFloat itemWidth = itmConverToPtFromPx(kAYPalletToolbarColorLumpWidth);
    CGFloat itemGap = itmConverToPtFromPx(kAYPalletToolbarColorLumpGap);
    
    if(!_palletBgView){
    
        CGFloat offSetX = margin + itemGap + itemWidth;
        
        _palletBgView = [[UIScrollView alloc] initWithFrame:CGRectMake((kScreenWidth - width)/2.f + offSetX,
                                                                       0,
                                                                       width - itmConverToPtFromPx(kAYPalletToolbarRightAreaWidth) - offSetX,
                                                                       self.height)];
        [_palletBgView setBackgroundColor:[UIColor clearColor]];
        _palletBgView.showsHorizontalScrollIndicator = NO;
        _palletBgView.showsVerticalScrollIndicator = NO;
        [self addSubview:_palletBgView];
        
        [self addColors:[self colorStack]];
    }
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setBackgroundColor:[UIColor clearColor]];
    [_closeButton setImage:[UIImage imageNamed:@"brush_btn_close" bundle:nil] forState:UIControlStateNormal];
    [_closeButton setFrame:CGRectMake(_palletBgView.x + _palletBgView.width + itmConverToPtFromPx(kAYPalletToolbarRightGap),
                               itmConverToPtFromPx( (kAYPalletToolbarHeight - kAYPalletToolbarCloseHeight)/2.f ),
                               itmConverToPtFromPx(kAYPalletToolbarCloseWidth),
                               itmConverToPtFromPx(kAYPalletToolbarCloseHeight))];
    [self addSubview:_closeButton];
    
    [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat brushBtnWidth = itemWidth + 10.f;
    
    _brushWidthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_brushWidthButton setBackgroundColor:[UIColor clearColor]];
    [_brushWidthButton setFrame:CGRectMake( (kScreenWidth - width)/2.f + margin - 5, (self.height - brushBtnWidth)/2.f, brushBtnWidth, brushBtnWidth)];
    [_brushWidthButton setImage:[UIImage PDFNamed:@"live_brush_width" size:_brushWidthButton.size bundle:nil] forState:UIControlStateNormal];
    [self addSubview:_brushWidthButton];
    
    [_brushWidthButton addTarget:self action:@selector(brushSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGRect itemFrame = CGRectMake(_brushWidthButton.x, _brushWidthButton.y + self.y, _brushWidthButton.width, _brushWidthButton.height);
    
    _brushItem_L = [self brushItemCreatByImageName:@"live_brush_width_L"
                                 selectedImageName:@"live_brush_width_L_h"
                                             frame:itemFrame];
    [[self rootViewController].view addSubview:_brushItem_L];
    
    _brushItem_M = [self brushItemCreatByImageName:@"live_brush_width_M"
                                 selectedImageName:@"live_brush_width_M_h"
                                             frame:itemFrame];
    [[self rootViewController].view addSubview:_brushItem_M];
    
    _brushItem_S = [self brushItemCreatByImageName:@"live_brush_width_S"
                                 selectedImageName:@"live_brush_width_S_h"
                                             frame:itemFrame];
    [[self rootViewController].view addSubview:_brushItem_S];
    _brushItem_S.selected = YES;
}

- (void)reSize:(NSNotification *)notification {
    
    
    if (self.superview == nil) {
        return;
    }
    
//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
//    if (self.orientation == orientation) {
//        return;
//    }
//    self.orientation = orientation;
    
    WEAKSELF(weakSelf);
    
    [UIView animateWithDuration:itm_kAnimationDefaultDruation animations:^{
        [weakSelf didResize];
    }];
}

- (void)didResize
{
    
    [self setFrame:CGRectMake(0,
                              kScreenHeight - itmConverToPtFromPx(kAYPalletToolbarHeight),
                              kScreenWidth,
                              itmConverToPtFromPx(kAYPalletToolbarHeight))];
    
    CGFloat width = MIN(kScreenWidth, kScreenHeight);
    
    CGFloat margin = itmConverToPtFromPx(kAYPalletToolbarColorsMargin);
    CGFloat itemWidth = itmConverToPtFromPx(kAYPalletToolbarColorLumpWidth);
    CGFloat itemGap = itmConverToPtFromPx(kAYPalletToolbarColorLumpGap);
    
    CGFloat offSetX = margin + itemGap + itemWidth;
    
    [_palletBgView setFrame:CGRectMake((kScreenWidth - width)/2.f + offSetX,
                                      0,
                                      width - itmConverToPtFromPx(kAYPalletToolbarRightAreaWidth) - offSetX,
                                      self.height)];
    
    [_closeButton setFrame:CGRectMake(_palletBgView.x + _palletBgView.width + itmConverToPtFromPx(kAYPalletToolbarRightGap),
                                      itmConverToPtFromPx( (kAYPalletToolbarHeight - kAYPalletToolbarCloseHeight)/2.f ),
                                      itmConverToPtFromPx(kAYPalletToolbarCloseWidth),
                                      itmConverToPtFromPx(kAYPalletToolbarCloseHeight))];
    
    _brushWidthButton.x = (kScreenWidth - width)/2.f + margin - 5;
}

- (void)addColors:(NSArray*)colors
{
    if([colors count] == 0)
        return;
    
    self.selectColor = colors[0];
    
    CGFloat width = itmConverToPtFromPx(kAYPalletToolbarColorLumpWidth);
    CGFloat gap = itmConverToPtFromPx(kAYPalletToolbarColorLumpGap);
    
    for (int i=0; i<colors.count; i++) {
        UIColor* color = colors[i];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:color];
        
        [btn setFrame:CGRectMake( (gap + width) * i , (self.height - width)/2.f, width, width )];
        btn.layer.cornerRadius = width/2.f;
        btn.tag = 50 + i;
        [btn setImage:[UIImage imageNamed:@"live_color_check" bundle:nil] forState:UIControlStateSelected];
        [_palletBgView addSubview:btn];
        
        [btn addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == 0){
            btn.selected = YES;
        }
    }
    
    _palletBgView.contentSize = CGSizeMake( width * colors.count + gap * (colors.count-1),
                                           _palletBgView.height );
}



- (NSArray*)colorStack
{
    return  @[[[itmColor colorWithHexString:@"000000" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"ffffff" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"cccccc" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"00ffff" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"008000" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"ffff00" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"00ff00" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"0000ff" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"ff0000" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"ff00ff" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"007f7f" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"800000" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"008000" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"000080" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"808000" alpha:1.f] UIColor],
              [[itmColor colorWithHexString:@"800080" alpha:1.f] UIColor],
             ];
}

#pragma mark - - Selector

- (void)colorSelected:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    if(btn.selected)
        return;
    
    [self cancelSelectedStatus];
    btn.selected = YES;
    
    NSInteger index = btn.tag - 50;
    NSArray* colors = [self colorStack];
    
    self.selectColor = colors[index];
}

- (void)brushSelected:(id)sender
{
    if(_brushItemIsShow){
        [self hideBrushItems:YES];
    }
    else{
        [self showBrushItems];
    }
}

- (void)brushItemClicked:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    if(btn.selected){
        return;
    }
    
    [self cancelBrushSelectedStatus];
    btn.selected = YES;
    
    if(btn ==  _brushItem_S){
        self.lineWidth = 3.f;
    }
    else if(btn == _brushItem_M){
        self.lineWidth = 6.f;
    }
    else if(btn == _brushItem_L){
        self.lineWidth = 9.f;
    }
    
    [self hideBrushItems:YES];
}


- (void)closeAction:(id)sender
{
    [self hide:YES];
}

- (void)show:(BOOL)animated
{
    if(animated){
        [self setHidden:NO];
        __weak typeof(self) weakSelf = self;
        [itmAnimation animationWithType:itmAnimationTypeMoveInFromBottom andView:self completion:^(BOOL finished) {
            [weakSelf.superview bringSubviewToFront:weakSelf];
        }];
        
        return;
    }
    
    [self setHidden:NO];
    [self.superview bringSubviewToFront:self];
}

- (void)hide:(BOOL)animated
{
    if(_brushItemIsShow){
        [self hideBrushItems:animated];
    }
    
    if(animated){
        
        __weak typeof(self) weakSelf = self;
        
        [itmAnimation animationWithType:itmAnimationTypeMoveOutToBottom andView:self completion:^(BOOL finished) {
            [weakSelf setHidden:YES];
            if(weakSelf.delegate != nil && [weakSelf.delegate respondsToSelector:@selector(cloesClicked)]){
                [weakSelf.delegate cloesClicked];
            }
        }];
        
        return;
    }
    
    [self setHidden:YES];
    
    if(_delegate != nil && [_delegate respondsToSelector:@selector(cloesClicked)]){
        [_delegate cloesClicked];
    }
}

#pragma mark - - Timer

- (void)startBrushItemShowTimer
{
    [self stopBrushItemShowTimer];
    _brushItemShowTimer = [[itmTimer alloc] initWithInterval:kBrushItemShowInterval
                                               target:self
                                             selector:@selector(hideItems:)
                                               repeat:NO];
    _brushItemShowTimer.startTime = [[NSDate date] timeIntervalSince1970];
}

- (void)stopBrushItemShowTimer
{
    if(_brushItemShowTimer){
        [_brushItemShowTimer invalidate];
        _brushItemShowTimer = nil;
    }
}

- (void)hideItems:(id)sender
{
    if(_brushItemShowTimer == nil)
        return;
    
    itmTimer* timer = (itmTimer*)sender;
    if(timer.startTime != _brushItemShowTimer.startTime)
        return;
    
    [self hideBrushItems:YES];
}


#pragma mark - - Others

- (void)cancelSelectedStatus
{
    NSInteger count = [self colorStack].count;
    
    for (int i=0; i<count; i++) {
        UIButton* btn = [_palletBgView viewWithTag:50+i];
        if(btn){
            btn.selected = NO;
        }
    }
}

- (void)cancelBrushSelectedStatus
{
    _brushItem_L.selected = NO;
    _brushItem_M.selected = NO;
    _brushItem_S.selected = NO;
}


- (void)showBrushItems
{
    if(_brushItemIsShow)
        return;
    
    WEAKSELF(weakSelf);
    
    self.brushItem_M.hidden = NO;
    self.brushItem_S.hidden = NO;
    self.brushItem_L.hidden = NO;
    
    [UIView animateWithDuration:kBrushItemShowAnimateDuration animations:^{
        
        weakSelf.brushItem_M.alpha = 1.f;
        weakSelf.brushItem_S.alpha = 1.f;
        weakSelf.brushItem_L.alpha = 1.f;
        
        weakSelf.brushItem_S.y = self.y - weakSelf.brushItem_S.height * 3;
        weakSelf.brushItem_M.y = self.y - weakSelf.brushItem_M.height * 2;
        weakSelf.brushItem_L.y = self.y - weakSelf.brushItem_L.height * 1;
        
    } completion:^(BOOL finished) {
        [weakSelf startBrushItemShowTimer];
    }];
    
    _brushItemIsShow = YES;
}

- (void)hideBrushItems:(BOOL)animeted
{
    [self stopBrushItemShowTimer];
    
    if(!_brushItemIsShow)
        return;
    
    CGFloat offsetY = _brushWidthButton.y + self.y;
    
    if(animeted){
        
        WEAKSELF(weakSelf);
        [UIView animateWithDuration:kBrushItemShowAnimateDuration animations:^{
            
            weakSelf.brushItem_S.y = offsetY;
            weakSelf.brushItem_M.y = offsetY;
            weakSelf.brushItem_L.y = offsetY;
            
            weakSelf.brushItem_M.alpha = 0.f;
            weakSelf.brushItem_S.alpha = 0.f;
            weakSelf.brushItem_L.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            if(finished){
                weakSelf.brushItem_M.hidden = YES;
                weakSelf.brushItem_S.hidden = YES;
                weakSelf.brushItem_L.hidden = YES;
            }
        }];
    }
    else{
        self.brushItem_S.y = offsetY;
        self.brushItem_M.y = offsetY;
        self.brushItem_L.y = offsetY;
        
        self.brushItem_M.alpha = 0.f;
        self.brushItem_S.alpha = 0.f;
        self.brushItem_L.alpha = 0.f;
        
        self.brushItem_M.hidden = YES;
        self.brushItem_S.hidden = YES;
        self.brushItem_L.hidden = YES;
    }
    
    _brushItemIsShow = NO;
}

- (UIButton*)brushItemCreatByImageName:(NSString*)imageName
                     selectedImageName:(NSString*)selectedImageName
                                 frame:(CGRect)frame
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setImage:[UIImage PDFNamed:imageName size:btn.size bundle:nil] forState:UIControlStateNormal];
    [btn setImage:[UIImage PDFNamed:selectedImageName size:btn.size bundle:nil] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(brushItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.hidden = YES;
    btn.alpha = 0;
    
    return btn;
}

- (UIViewController*)rootViewController
{
    UIViewController *rootvc = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    rootvc = window.rootViewController;
    
    return rootvc;
}



@end
