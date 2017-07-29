//
//  MDPieView2.h
//  care2Dare
//
//  Created by Spiel's Macmini on 5/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDPieView2 : UIView
-(instancetype)initWithFrame:(CGRect)frame andPercent:(float)percent andColor:(UIColor *)color;
-(void)reloadViewWithPercent:(float)percent;
@end
