//
//  ProfileFriendsViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/7/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsReqTableViewCell.h"
#import "FriendAddReqTableViewCell.h"
@interface ProfileFriendsViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,weak)IBOutlet UIView * view_Topheader;
@property(nonatomic,weak)IBOutlet UIButton * Button_Back;
@property(nonatomic,weak)IBOutlet UIButton * Button_Search;
@property(nonatomic,weak)IBOutlet UILabel * Lable_TitleFriends;
@property(nonatomic,weak)IBOutlet UITextField *Textfield_Search;
- (IBAction)SearchEditing_Action:(id)sender;

//
@property(nonatomic,weak)IBOutlet UITableView * Tableview_Friends;
@property(nonatomic,strong)FriendsReqTableViewCell * cell_req;
@property(nonatomic,strong)FriendAddReqTableViewCell * cell_addreq;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property(nonatomic,weak)NSString *Str_profiletypr;
-(IBAction)ButtonBack_Action:(id)sender;
-(IBAction)ButtonSearch_Action:(id)sender;
@end
