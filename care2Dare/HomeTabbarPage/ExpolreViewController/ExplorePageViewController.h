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
#import "MDPieView.h"
#import "MDpieView1.h"
#import "MDPieView2.h"
#import "FavriteTableViewCell.h"
@interface ExplorePageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UIImageView * image_ExpWorld;
@property(nonatomic,weak)IBOutlet UIImageView * image_ExpFriend;
@property(nonatomic,weak)IBOutlet UIImageView * image_ExpFavourite;

@property(nonatomic,weak)IBOutlet UIView * view_ExpWorld;
@property(nonatomic,weak)IBOutlet UIView * View_ExpFriend;
@property(nonatomic,weak)IBOutlet UIView * View_ExpFavourite;

@property(nonatomic,weak)IBOutlet UIActivityIndicatorView * indicator;

@property(nonatomic,weak)IBOutlet UITableView * Tableview_Explore;

@property(nonatomic,strong)WorldExpTableViewCell * cell_WorldExp;
@property(nonatomic,strong)FriendExpTableViewCell * cell_FriendExp;
@property(nonatomic,strong)FavriteTableViewCell * cell_Favorite;

@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property (nonatomic,assign) float percent;
@property (nonatomic,assign) float percent1;
@property (nonatomic,assign) float percent2;
@property (nonatomic,strong)MDPieView *pieView;
@property (nonatomic,strong)MDPieView1 *pieView1;
@property (nonatomic,strong)MDPieView2 *pieView2;

//-(IBAction)SignUpView:(id)sender;
//
//-(IBAction)ForgetPasswordAction:(id)sender;
//-(IBAction)LoginWithFbAction:(id)sender;
//-(IBAction)LoginWithTwitterAction:(id)sender;
//-(IBAction)LoginButtonAction:(id)sender;
@end
