//
//  ContactView.h
//  LCNContactPicker
//
//  Created by 黄春涛 on 15/12/31.
//  Copyright © 2015年 黄春涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNContactViewStyle.h"
@class LCNContactView;
@class LCNContactModel;

@protocol ContactViewDelegate <NSObject>

-(void)selectedContactView:(LCNContactView *)contactView;

-(void)deleteContactView:(LCNContactView *)contactView;

@end

@interface LCNContactView : UIView

@property (nonatomic, strong) id<ContactViewDelegate> delegate;
@property (nonatomic, strong) LCNContactModel *model;

- (instancetype)initWithContactModel:(LCNContactModel *)model;

- (instancetype)initWithContactModel:(LCNContactModel *)model defaultStyle:(LCNContactViewStyle *)style defaultSelectedStyle:(LCNContactViewStyle *)selectedStyle;

- (void)setStyle:(LCNContactViewStyle *)style;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com