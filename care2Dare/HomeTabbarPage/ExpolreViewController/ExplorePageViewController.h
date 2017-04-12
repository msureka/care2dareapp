//
//  ExplorePageViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorldExpTableViewCell.h"
#import "FriendExpTableViewCell.h"
@interface ExplorePageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UIImageView * image_ExpWorld;
@property(nonatomic,weak)IBOutlet UIImageView * image_ExpFriend;

@property(nonatomic,weak)IBOutlet UIView * view_ExpWorld;
@property(nonatomic,weak)IBOutlet UIView * View_ExpFriend;

@property(nonatomic,weak)IBOutlet UILabel * Label_JsonResult;

@property(nonatomic,weak)IBOutlet UITableView * Tableview_Explore;

@property(nonatomic,strong)WorldExpTableViewCell * cell_WorldExp;
@property(nonatomic,strong)FriendExpTableViewCell * cell_FriendExp;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
//-(IBAction)SignUpView:(id)sender;
//
//-(IBAction)ForgetPasswordAction:(id)sender;
//-(IBAction)LoginWithFbAction:(id)sender;
//-(IBAction)LoginWithTwitterAction:(id)sender;
//-(IBAction)LoginButtonAction:(id)sender;
@end
