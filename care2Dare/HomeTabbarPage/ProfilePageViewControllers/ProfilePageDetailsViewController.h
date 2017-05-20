//
//  ProfilePageDetailsViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/31/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "profilePageTableViewCell.h"
#import "PublicTableViewCell.h"
#import "PrivateTableViewCell.h"

@interface ProfilePageDetailsViewController : UIViewController
@property(nonatomic,weak)IBOutlet UIView * view_Topheader;
@property(nonatomic,weak)IBOutlet UIButton * Button_setting;
@property(nonatomic,weak)IBOutlet UIButton * Button_SetValues;
//
@property(nonatomic,weak)IBOutlet UITableView * Tableview_Profile;


@property(nonatomic,strong)profilePageTableViewCell * cell_Profile;
@property(nonatomic,strong)PublicTableViewCell * cell_Public;
@property(nonatomic,strong)PrivateTableViewCell * cell_Private;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
-(IBAction)NotificationButton_Action:(id)sender;
-(IBAction)SettingButton_Action:(id)sender;

@property(nonatomic,strong)NSString * userId_prof;
@property(nonatomic,strong)NSString * user_imageUrl;
@property(nonatomic,strong)NSString * user_name;
//@property(nonatomic,strong)UIImageView * Images_data;
@end
