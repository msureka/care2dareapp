//
//  LoginWithEmailViewController.h
//  care2Dare
//
//  Created by MacMini2 on 06/07/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRHyperLabel.h"
@interface LoginWithEmailViewController : UIViewController


@property(nonatomic,weak)IBOutlet UITextField * textfield_uname;
@property(nonatomic,weak)IBOutlet UITextField * textfield_password;
@property(nonatomic,weak)IBOutlet UIButton *  Button_Login;

-(IBAction)ForgetPasswordAction:(id)sender;
@property (weak, nonatomic) IBOutlet FRHyperLabel *termLabel;

-(IBAction)LoginButtonAction:(id)sender;
- (IBAction)usernameTxtAction:(id)sender;
-(IBAction)LoginviewViewBack:(id)sender;


@property(nonatomic,weak)IBOutlet UIView * view_LoginFB;
@property(nonatomic,weak)IBOutlet UIView *  View_LoginTW;
@property(nonatomic,weak)IBOutlet UIView *  View_LoginEmail;

@property(nonatomic,weak)IBOutlet UIButton *  Button_LoginFb;
@property(nonatomic,weak)IBOutlet UIButton *  Button_LoginTw;
@property(nonatomic,weak)IBOutlet UIButton *  Button_Email;


-(IBAction)LoginWithFbAction:(id)sender;
-(IBAction)LoginWithTwitterAction:(id)sender;


@property(nonatomic,weak)IBOutlet UIImageView *  Image_LoginFb;
@property(nonatomic,weak)IBOutlet UIImageView *  Image_LoginTw;





@end
