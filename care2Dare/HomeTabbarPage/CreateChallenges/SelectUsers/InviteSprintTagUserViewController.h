//
//  InviteSprintTagUserViewController.h
//  SprintTags_Pro
//
//  Created by Spiel's Macmini on 9/1/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTokenInputView.h"


@interface InviteSprintTagUserViewController : UIViewController< UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>


@property (strong, nonatomic) IBOutlet UIButton *Send_Button;
@property (strong, nonatomic)NSMutableArray *Array_InviteUserTags;
//@property (strong, nonatomic) IBOutlet UITableView * Table_ContactView;
-(IBAction)BackButton:(id)sender;

-(IBAction)SendButtons:(id)sender;

//@property (strong, nonatomic) NSMutableArray *selectedNames;
@property (strong, nonatomic) NSMutableArray *Names,*Names_UserId;
@end
