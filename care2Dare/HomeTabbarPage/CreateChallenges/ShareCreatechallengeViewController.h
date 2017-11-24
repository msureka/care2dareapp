//
//  ShareCreatechallengeViewController.h
//  care2Dare
//
//  Created by MacMini2 on 22/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareCreatechallengeViewController : UIViewController
- (IBAction)Button_Share_Action:(id)sender;
- (IBAction)Button_Finish_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Button_share;
@property (weak, nonatomic) IBOutlet UIButton *Button_finish;
@property (weak, nonatomic) IBOutlet UILabel *Label_desc;
//@property (strong, nonatomic) NSString *str_donateType;
@property (strong, nonatomic) NSMutableArray *Array_Values;
@end
