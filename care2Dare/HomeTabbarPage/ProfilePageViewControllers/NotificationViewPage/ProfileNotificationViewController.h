//
//  ProfileNotificationViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/8/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicChallengesTableViewCell.h"
#import "PrivateChallengesTableViewCell.h"
#import "PlegeIncomingTableViewCell.h"
#import "PledgeOutoingTableViewCell.h"
#import "VedioNotiTableViewCell.h"
@interface ProfileNotificationViewController : UIViewController
@property(nonatomic,weak)IBOutlet UIView * view_Topheader;
@property(nonatomic,weak)IBOutlet UIButton * Button_Back;

@property(nonatomic,weak)IBOutlet UILabel * Lable_Titlenotif;

@property(nonatomic,weak)IBOutlet UITableView * Tableview_Notif;
@property(nonatomic,strong)PublicChallengesTableViewCell * cell_PublicNoti;
@property(nonatomic,strong)PrivateChallengesTableViewCell * cell_PrivateNoti;

@property(nonatomic,strong)PlegeIncomingTableViewCell *cell_PlegeIncoNoti;
@property(nonatomic,strong)PledgeOutoingTableViewCell *cell_PlegeOutNoti;

@property(nonatomic,strong)VedioNotiTableViewCell *cell_VedioNoti;


@property(nonatomic,weak)IBOutlet UIButton * Button_Challenges;
@property(nonatomic,weak)IBOutlet UIButton * Button_Contribution;
@property(nonatomic,weak)IBOutlet UIButton * Button_Videos;

@property(nonatomic,weak)IBOutlet UIImageView * ImageRed_Challenges;
@property(nonatomic,weak)IBOutlet UIImageView * ImageRed_Contribution;
@property(nonatomic,weak)IBOutlet UIImageView * ImageRed_Videos;

-(IBAction)ButtonChallenges_Action:(id)sender;
-(IBAction)ButtonContribution_Action:(id)sender;
-(IBAction)ButtonVedio_Action:(id)sender;


@end
