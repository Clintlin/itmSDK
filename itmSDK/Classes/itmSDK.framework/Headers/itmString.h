//
//  itmString.h
//  itmSDK
//
//  Created by HeXingang on 2017/7/25.
//  Copyright © 2017年 AiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface itmString : NSString

//json
- (NSString *)jsonWithDictionary:(NSDictionary *)dict;
- (NSString *)jsonWithArray:(NSArray *)arr;
- (NSObject *)coverObjectFrom:(NSString *)json;

+ (NSObject *)coverObjectFrom:(NSString *)json;

/**
 self = unix时间戳
 按时间生成时间 x秒前，分钟前，小时前，昨天 hh:mm,x天前，YYYY-mm-dd
 */
- (NSString *)timeStringWithFormat:(NSString *)format;

// size
/*!
 
 针对定高的容器，进行文字size的匹配
 */
- (CGSize)sizeWithFontSize:(CGFloat)size;

+ (CGSize)string:(NSString*)string sizeWithFontSize:(CGFloat)size;

/*!
 针对定宽的容器，进行文字size的匹配
 */
- (CGSize)sizeWithFont:(UIFont *)font
              fontSize:(CGFloat)fontSize
                insets:(UIEdgeInsets)insets
             textWidth:(CGFloat)width;
/*!
 根据字节数进行转换
 */
+ (NSString *)getBytesFromDataLength:(NSInteger)dataLength ;

@end
