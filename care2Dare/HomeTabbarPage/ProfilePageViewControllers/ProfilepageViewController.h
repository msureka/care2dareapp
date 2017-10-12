//
//  ProfilepageViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "profilePageTableViewCell.h"
#import "DonateCharityTableViewCell.h"
#import "ProfileCompletechallengesimageTableViewCell.h"
#import "CompeteChallengesTableViewCell.h"

@interface ProfilepageViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//@property(nonatomic,weak)IBOutlet UIImageView * image_ExpWorld;
//@property(nonatomic,weak)IBOutlet UIImageView * image_ExpFriend;

@property(nonatomic,weak)IBOutlet UIView * view_Topheader;
@property(nonatomic,weak)IBOutlet UIButton * Button_setting;

//
@property(nonatomic,weak)IBOutlet UITableView * Tableview_Profile;


@property(nonatomic,strong)profilePageTableViewCell * cell_Profile;
@property(nonatomic,strong)DonateCharityTableViewCell * cell_donate;
@property(nonatomic,strong)CompeteChallengesTableViewCell * cell_complete;
@property(nonatomic,strong)ProfileCompletechallengesimageTableViewCell * cell_Profileimages;

@property (nonatomic, retain) UIRefreshControl *refreshControl;

-(IBAction)SettingButton_Action:(id)sender;
- (IBAction)Button_HelpProfile:(id)sender;



//@property(nonatomic,strong)WorldExpTableViewCell * cell_WorldExp;
//@property(nonatomic,strong)FriendExpTableViewCell * cell_FriendExp;
//@property (nonatomic, retain) UIRefreshControl *refreshControl;


@end
