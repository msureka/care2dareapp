//
//  RaisedContributeViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaisedoneTableViewCell.h"
#import "RaisedTwoTableViewCell.h"
#import "RaisedThreeTableViewCell.h"
#import "RaisedFourTableViewCell.h"

@interface RaisedContributeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,weak)IBOutlet UILabel * Label_RaisedAmt;
@property(nonatomic,weak)IBOutlet UIView * view_Topheader;

@property(nonatomic,weak)IBOutlet UILabel * Label_PayTopheader;
@property(nonatomic,weak)IBOutlet UIImageView * Image_PayTopheader;

@property(nonatomic,weak)IBOutlet UITableView * Tableview_Raised;

@property(nonatomic,strong)RaisedoneTableViewCell * cell_one;
@property(nonatomic,strong)RaisedTwoTableViewCell * cell_two;
@property(nonatomic,strong)RaisedThreeTableViewCell * cell_three;
@property(nonatomic,strong)RaisedFourTableViewCell * cell_Four;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
-(IBAction)ButtonBack_Action:(id)sender;



@property(weak,nonatomic)IBOutlet UITextView * TextViews;
@property(weak,nonatomic)IBOutlet UIView * BackGround_MainViews;
@property(weak,nonatomic)IBOutlet UIView * BackTextViews;
;
-(IBAction)Send_Comments:(id)sender;

-(IBAction)ImageGalButtonAct:(id)sender;

@property(nonatomic,strong)IBOutlet UITextView * textOne;
@property(nonatomic,strong)IBOutlet UIView * textOneBlue;
@property(nonatomic,strong)IBOutlet UIView * BlackViewOne;
@property(nonatomic,strong)IBOutlet UITableView * tableOne;
@property (nonatomic, strong)IBOutlet UIButton *sendButton;
@property (nonatomic, strong)IBOutlet UIButton *ImageGalButton;
@property (nonatomic, strong)IBOutlet  UILabel *placeholderLabel;
@property(nonatomic,strong)IBOutlet UIView * ViewTextViewOne;
//@property (nonatomic, retain) UIRefreshControl *refreshControl;

@property(strong,nonatomic)NSString * Str_Channel_Id;
@property(strong,nonatomic)NSString * Str_Raised_Amount;

@end
