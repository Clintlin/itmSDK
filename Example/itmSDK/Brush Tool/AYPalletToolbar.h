//
//  AYPalletToolbar.h
//  AYMovePanel
//
//  Created by HeXingang on 2017/7/5.
//  Copyright © 2017年 zhangxinming. All rights reserved.
//

#import <itmSDK/itmSDK.h>

@protocol AYPalletToolbarDelegate <NSObject>

- (void)cloesClicked;

@end

@interface AYPalletToolbar : UIView

@property (nonatomic, strong)   UIColor*  selectColor;
@property (nonatomic, weak)     id<AYPalletToolbarDelegate> delegate;
@property (nonatomic, assign)   CGFloat     lineWidth;

+ (instancetype)showInView:(UIView *)view;

- (void)hideBrushItems:(BOOL)animeted;

@end
