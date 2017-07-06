//
//  LoginPageViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRHyperLabel.h"
@interface LoginPageViewController : UIViewController
@property(nonatomic,weak)IBOutlet UILabel * Label_TitleName;


@property(nonatomic,weak)IBOutlet UIView * view_LoginFB;
@property(nonatomic,weak)IBOutlet UIView *  View_LoginTW;
@property(nonatomic,weak)IBOutlet UIView *  View_LoginEmail;

@property(nonatomic,weak)IBOutlet UIButton *  Button_LoginFb;
@property(nonatomic,weak)IBOutlet UIButton *  Button_LoginTw;
@property(nonatomic,weak)IBOutlet UIButton *  Button_Email;

@property(nonatomic,weak)IBOutlet UIImageView *  Image_LoginFb;
@property(nonatomic,weak)IBOutlet UIImageView *  Image_LoginTw;
@property(nonatomic,weak)IBOutlet UIImageView *  Image_Email;

@property(nonatomic,weak)IBOutlet UILabel * Label_TermsAndCon;

-(IBAction)SignUpView:(id)sender;


-(IBAction)LoginWithFbAction:(id)sender;
-(IBAction)LoginWithTwitterAction:(id)sender;
-(IBAction)LoginWithEmailAction:(id)sender;



@end
