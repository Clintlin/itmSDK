//
//  itmImage.h
//  itmSDK
//
//  Created by HeXingang on 2017/7/25.
//  Copyright © 2017年 AiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface itmImage : UIImage

- (UIImage *)addCornerWithRadius:(CGFloat)radius
                            size:(CGSize)size;

+ (UIImage *)addCornerToImage:(UIImage *)image
                   WithRadius:(CGFloat)radius
                            size:(CGSize)size;
+ (UIImage *)imageNamed:(NSString *)name bundle:(NSString *)identifiter;
+ (UIImage *)PDFNamed:(NSString *)name size:(CGSize)size bundle:(NSString *)identifiter;

@end
