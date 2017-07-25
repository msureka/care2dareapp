//
//  InplayViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 6/26/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicTableViewCell.h"
#import "PrivateTableViewCell.h"

@interface InplayViewController : UIViewController
@property(nonatomic,strong)PublicTableViewCell * cell_Public;
@property(nonatomic,strong)PrivateTableViewCell * cell_Private;
@property (nonatomic, retain) UIRefreshControl *refreshControl;

@property(nonatomic,strong) IBOutlet UITableView * Tableview_inplay;
@property(nonatomic,strong) IBOutlet UIView * Button_Public;
@property(nonatomic,strong) IBOutlet UIView * Button_Private;

@property(nonatomic,strong) IBOutlet UIImageView * Image_ButtinPublic;
@property(nonatomic,strong) IBOutlet UIImageView * Image_ButtonPrivate;

@property(nonatomic,strong) IBOutlet UILabel * label_public;
@property(nonatomic,strong) IBOutlet UILabel * label_private;
@property(nonatomic,weak)IBOutlet UIView * view_CreateChallenges;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView * indicator;

@end
