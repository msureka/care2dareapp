//
//  WatchPageViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatchViewTableViewCell.h"
@interface WatchPageViewController : UIViewController

@property(nonatomic,weak)IBOutlet UITableView * Tableview_watch;

@property(nonatomic,strong)WatchViewTableViewCell * cell_one;



@end
