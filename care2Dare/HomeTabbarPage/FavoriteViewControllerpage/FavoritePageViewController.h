//
//  FavoritePageViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PledgeTableViewCell.h"
#import "FavriteTableViewCell.h"
@interface FavoritePageViewController : UIViewController

@property(nonatomic,weak)IBOutlet UILabel * Label_JsonResult;

@property(nonatomic,weak)IBOutlet UIView * view_ExpPledges;
@property(nonatomic,weak)IBOutlet UIView * View_ExpFavorite;

@property(nonatomic,weak)IBOutlet UILabel * Label_Pledges;
@property(nonatomic,weak)IBOutlet UILabel * Label_Favorite;

@property(nonatomic,weak)IBOutlet UITableView * Tableview_Favorites;

@property(nonatomic,strong)PledgeTableViewCell * cell_Pledge;
@property(nonatomic,strong)FavriteTableViewCell * cell_Favorite;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
@end
