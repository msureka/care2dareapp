//
//  CreateFundriserViewController.h
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateFundriserViewController : UIViewController

@property(nonatomic,weak)IBOutlet UIButton * Button_Label_Donate;
@property(nonatomic,weak)IBOutlet UIButton * Button_Label_Raised;
@property(nonatomic,weak)IBOutlet UIButton * Button_Image_Donate;
@property(nonatomic,weak)IBOutlet UIButton * Button_Image_Raised;

@property(nonatomic,weak)IBOutlet UIButton * Button_Dot1;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot2;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot3;

-(IBAction)ButtonChallengeDonate_Action:(id)sender;
-(IBAction)ButtonFundRaised_Action:(id)sender;

-(IBAction)ButtonCancel_Action:(id)sender;

@end
