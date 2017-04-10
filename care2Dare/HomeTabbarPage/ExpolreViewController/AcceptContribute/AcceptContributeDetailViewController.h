//
//  AcceptContributeDetailViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/1/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccptTwoTableViewCell.h"
#import "AccImgVidTableViewCell.h"
@interface AcceptContributeDetailViewController : UIViewController
<UIActionSheetDelegate>
@property(nonatomic,weak)IBOutlet UILabel * Raised_amount;
@property(nonatomic,weak)IBOutlet UIButton * Button_back;

@property(nonatomic,weak)IBOutlet UIButton * Button_TotalPoints;
@property(nonatomic,weak)IBOutlet UIImageView * Image_TotalLikes;



-(IBAction)ButtonBack_Action:(id)sender;
-(IBAction)ButtonTotalPoints_Action:(id)sender;


@property(nonatomic,weak)IBOutlet UITableView * Tableview_ContriBute;
@property(nonatomic,weak)IBOutlet UIView * view_Topheader;
@property(nonatomic,strong)AccImgVidTableViewCell * cell_OneImageVid;
@property(nonatomic,strong)AccptTwoTableViewCell* cell_TwoDetails;


@property(nonatomic,strong)NSMutableArray * AllArrayData;
@property(nonatomic,strong)UIImageView * ProfileImgeData;




@end
