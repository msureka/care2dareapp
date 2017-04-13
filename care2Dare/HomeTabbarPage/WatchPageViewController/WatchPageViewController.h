//
//  WatchPageViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatchViewTableViewCell.h"
@interface WatchPageViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,weak)IBOutlet UITableView * Tableview_watch;

@property(nonatomic,strong)WatchViewTableViewCell * cell_one;
@property(nonatomic,weak)IBOutlet UIView * view_Topheader;
@property(nonatomic,weak)IBOutlet UIButton * Button_Back;
@property(nonatomic,weak)IBOutlet UIButton * Button_Search;
@property(nonatomic,weak)IBOutlet UILabel * Lable_TitleFriends;
@property(nonatomic,strong)IBOutlet UITextField *Textfield_Search;
-(IBAction)SearchEditing_Action:(id)sender;
- (IBAction)ButtonBack_Action:(id)sender;
@end
