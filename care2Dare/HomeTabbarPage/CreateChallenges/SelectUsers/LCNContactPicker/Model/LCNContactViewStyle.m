//
//  LCNContactViewStyle.m
//  LCNContactPicker
//
//  Created by 黄春涛 on 16/1/4.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LCNContactViewStyle.h"
#define BACKGROUND_COLOR [UIColor clearColor]
#import "LCNContactView.h"

@implementation LCNContactViewStyle

- (instancetype)initWithTextColor:(UIColor *)textColor
                         fontSize:(NSInteger)fontSize
                  backgroundColor:(UIColor *)backgroundColor
                      borderColor:(UIColor *)borderColor
                      borderWidth:(CGFloat)borderWidth
                     cornerRadius:(CGFloat)cornerRadius{
    
    if (self = [super init]) {
        _textColor = textColor;
        _fontSize = fontSize;
        _backgroundColor = backgroundColor;
        _borderColor = borderColor;
        _borderWidth = borderWidth;
        _cornerRadius = cornerRadius;
    }
    return self;
}

+ (instancetype) defaultStyle{
    LCNContactViewStyle *style = [LCNContactViewStyle new];
    style.textColor =[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1];
    //style.fontSize = [UIFont systemFontSize];
    [style setFontSize:16];
    style.backgroundColor = BACKGROUND_COLOR;
    
    style.borderColor = BACKGROUND_COLOR;
    style.borderWidth = 0;
    style.cornerRadius = 5;
    
    return style;
    
}

+ (instancetype) defaultSelectedStyle{
    LCNContactViewStyle *style = [LCNContactViewStyle new];
    
    style.textColor = [UIColor whiteColor];
    
    //style.fontSize = [UIFont systemFontSize];
     [style setFontSize:16];
    style.backgroundColor =[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1];
    
    style.borderColor = BACKGROUND_COLOR;
    style.borderWidth = 1;
    style.cornerRadius = 5;
    
  
    
    return style;
}

@end
