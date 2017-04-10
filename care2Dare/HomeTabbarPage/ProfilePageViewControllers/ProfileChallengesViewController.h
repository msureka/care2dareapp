//
//  ProfileChallengesViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/7/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChallengesTableViewCell.h"
@interface ProfileChallengesViewController : UIViewController

@property(nonatomic,weak)IBOutlet UIView * view_Topheader;
@property(nonatomic,weak)IBOutlet UIButton * Button_Back;
@property(nonatomic,weak)IBOutlet UIButton * Button_Search;
@property(nonatomic,weak)IBOutlet UILabel * Lable_TitleChallenges;
@property(nonatomic,weak)IBOutlet UITextField *Textfield_Search;
//
@property(nonatomic,weak)IBOutlet UITableView * Tableview_Challenges;
@property(nonatomic,strong)ChallengesTableViewCell * cell_Challenges;


-(IBAction)ButtonBack_Action:(id)sender;
-(IBAction)ButtonSearch_Action:(id)sender;
@end
