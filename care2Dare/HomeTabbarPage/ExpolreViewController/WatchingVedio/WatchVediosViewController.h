//
//  WatchVediosViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatchVedioTableViewCell.h"
#import "WatchVedioDescTableViewCell.h"
#import "WatchVediolistTableViewCell.h"
#import "WatchVedioShareTableViewCell.h"
@interface WatchVediosViewController : UIViewController

@property(nonatomic,weak)IBOutlet UITableView * Tableview_Explore;
@property(nonatomic,strong)WatchVedioTableViewCell * cell_one;
@property(nonatomic,strong)WatchVedioDescTableViewCell * cell_two;
@property(nonatomic,strong)WatchVedioShareTableViewCell * cell_three;
@property(nonatomic,strong)WatchVediolistTableViewCell * cell_Four;
@property(nonatomic,strong)NSString * str_Userid2val;
@property(nonatomic,strong)NSString * str_ChallengeidVal;
//@property(nonatomic,strong)NSString *Str_urlVedio;
@property(nonatomic,strong)NSString *str_challengeTitle;
@property(nonatomic,strong)UIImageView *str_image_Data;

@property (nonatomic, retain) UIRefreshControl *refreshControl;

@end
