//
//  CreateFundriserTwoViewController.h
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateFundriserTwoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *TextView_amount;
@property (weak, nonatomic) IBOutlet UIButton *Button_next;
@property (strong, nonatomic)NSMutableDictionary * Dict_values2;
- (IBAction)Button_Next_Action:(id)sender;
- (IBAction)Button_Back_Action:(id)sender;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot1;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot2;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot3;
- (IBAction)Textfield_amount_Action:(id)sender;


@end
