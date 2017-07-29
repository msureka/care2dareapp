//
//  DonationHistroyViewController.h
//  care2Dare
//
//  Created by MacMini2 on 17/07/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PledgeTableViewCell.h"

@interface DonationHistroyViewController : UIViewController


@property(nonatomic,weak)IBOutlet UILabel * Label_JsonResult;

@property(nonatomic,weak)IBOutlet UIView * view_ExpPledges;
@property(nonatomic,weak)IBOutlet UIView * View_ExpFavorite;

@property(nonatomic,weak)IBOutlet UILabel * Label_Pledges;
@property(nonatomic,weak)IBOutlet UILabel * Label_Favorite;

@property(nonatomic,weak)IBOutlet UITableView * Tableview_Favorites;

@property(nonatomic,strong)PledgeTableViewCell * cell_Pledge;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property(nonatomic,strong)IBOutlet UIView * HeadTopView;

@property(nonatomic,strong)IBOutlet UIActivityIndicatorView * indicator;
@property(nonatomic,strong)IBOutlet UILabel * label_TotalDonate;


- (IBAction)DoneButton:(id)sender;
@end
