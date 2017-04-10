//
//  LCNContactViewStyle.h
//  LCNContactPicker
//
//  Created by 黄春涛 on 16/1/4.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LCNContactViewStyle : NSObject

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;

- (instancetype)initWithTextColor:(UIColor *)textColor
                         fontSize:(NSInteger)fontSize
                  backgroundColor:(UIColor *)backgroundColor
                      borderColor:(UIColor *)borderColor
                      borderWidth:(CGFloat)borderWidth
                     cornerRadius:(CGFloat)cornerRadius;

+ (instancetype) defaultStyle;

+ (instancetype) defaultSelectedStyle;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com