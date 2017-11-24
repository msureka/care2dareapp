//
//  CreateFundriserThreeViewController.h
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateFundriserThreeViewController : UIViewController

- (IBAction)Button_Next_Action:(id)sender;
- (IBAction)Button_Back_Action:(id)sender;

- (IBAction)Button_Public_Action:(id)sender;
- (IBAction)Button_Private_Action:(id)sender;

@property(nonatomic,weak)IBOutlet UIButton * Button_Dot1;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot2;
@property(nonatomic,weak)IBOutlet UIButton * Button_Dot3;
@property (weak, nonatomic) IBOutlet UIButton *Button_next;

@property(nonatomic,weak)IBOutlet UIButton * Button_Label_Public;
@property(nonatomic,weak)IBOutlet UIButton * Button_Label_Private;
@property(nonatomic,weak)IBOutlet UIButton * Button_Image_Public;
@property(nonatomic,weak)IBOutlet UIButton * Button_Image_Private;

@property(nonatomic,weak)IBOutlet UISlider * slider_Days;
@property(nonatomic,weak)IBOutlet UILabel * Label_Currentsdays;

@property (strong, nonatomic)NSMutableDictionary *Dict_values3;
@property (weak, nonatomic) IBOutlet UILabel *Label_Heding;
@property (weak, nonatomic) IBOutlet UILabel *Label_Hedingtitle;
@end
