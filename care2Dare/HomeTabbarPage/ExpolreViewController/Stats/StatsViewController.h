//
//  StatsViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatsOneTableViewCell.h"
#import "StatsTwoTableViewCell.h"
#import "StatsThreeTableViewCell.h"
#import "StatsFourTableViewCell.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
@interface StatsViewController : UIViewController

@property(nonatomic,weak)IBOutlet UIView * view_Topheader;

@property(nonatomic,weak)IBOutlet UIButton * Button_back;

@property(nonatomic,weak)IBOutlet UITableView * Tableview_Stats;

@property(nonatomic,weak)IBOutlet UIActivityIndicatorView * indicator_view;

@property(nonatomic,strong)StatsOneTableViewCell * oneCell;
@property(nonatomic,strong)StatsTwoTableViewCell * twoCell;
@property(nonatomic,strong)StatsThreeTableViewCell * threeCell;
@property(nonatomic,strong)StatsFourTableViewCell * fourCell;
@property(nonatomic,strong)NSString *str_ChallengeidVal1;
-(IBAction)ButtonBack_Action:(id)sender;
@end
