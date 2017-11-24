//
//  CreateChallengerTwoViewController.h
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateChallengerTwoViewController : UIViewController

@property(nonatomic,weak)IBOutlet UILabel * Label_totalAmount;
@property(nonatomic,weak)IBOutlet UITextField * Textfield_Amount;
@property(nonatomic,weak)IBOutlet UILabel * Label_ChallengesName;




- (IBAction)Button_Next_Action:(id)sender;
- (IBAction)Button_Back_Action:(id)sender;
- (IBAction)Textfield_Amount_Action:(id)sender;

@property(nonatomic,weak)IBOutlet UIButton * Button_Dot1;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot2;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot3;
@property (weak, nonatomic) IBOutlet UIButton *Button_next;

@property (strong, nonatomic) NSMutableDictionary *Dict_values2;
@property(strong,nonatomic)NSMutableArray  * Array_Names,*Array_UserId;

@end
