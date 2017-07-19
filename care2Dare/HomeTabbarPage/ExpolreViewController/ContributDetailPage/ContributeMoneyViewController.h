//
//  ContributeMoneyViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+KeyboardAnimation.h"
@interface ContributeMoneyViewController : UIViewController

@property(nonatomic,weak)IBOutlet UILabel * Label_ContributePlayes;
@property(nonatomic,weak)IBOutlet UIButton * Button_back;
@property(nonatomic,weak)IBOutlet UIButton * Button_Contribute_Send;
@property(nonatomic,weak)IBOutlet UIButton * Button_Help;
@property(nonatomic,weak)IBOutlet UITextField * textfield_Ammounts;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabBarBottomSpace;

-(IBAction)ButtonBack_Action:(id)sender;
-(IBAction)Button_Help_Action:(id)sender;
-(IBAction)Button_Contribute_Send_Action:(id)sender;
-(IBAction)textfield_Ammounts_Actions:(id)sender;
@property(nonatomic,strong)NSString *total_players,*challengerID,*Str_DonateRaisedTypePlayer;
@property(nonatomic,weak)IBOutlet UIView * BottomView;
@property(nonatomic,weak)IBOutlet UIView * view_Topheader;

@property(nonatomic,weak)IBOutlet UILabel * Label_TotalContribute;

@end
