//
//  LCNTextField.h
//  LCNContactPicker
//
//  Created by 黄春涛 on 16/1/4.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCNTextField;

@protocol LCNTextFieldDelegate <UITextFieldDelegate>

- (void)LCNTextFieldDidChange:(LCNTextField *)textField;

- (void)LCNTextfieldDeleteBackwardWithEmpty:(LCNTextField *)textField;

@end

@interface LCNTextField : UITextField

@property (nonatomic, assign) id<LCNTextFieldDelegate> delegate;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com