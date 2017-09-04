//
//  PrivateTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivateTableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView * Image_Profile;
@property(strong,nonatomic)IBOutlet UIImageView * Image_PalyBuutton;
@property(strong,nonatomic)IBOutlet UIImageView * Image_NewFrnd;
@property(strong,nonatomic)IBOutlet UILabel * Label_Changename;
@property(strong,nonatomic)IBOutlet UILabel * Label_Time;
@property(strong,nonatomic)IBOutlet UILabel * Label_Titile;
@property(strong,nonatomic)IBOutlet UILabel * Label_Backer;
@property(strong,nonatomic)IBOutlet UILabel * Label_Raised;
@property(strong,nonatomic)IBOutlet UILabel * Label_Mypleges;
@property(weak,nonatomic)IBOutlet UIActivityIndicatorView * activityIndicator1;
@property (weak, nonatomic) IBOutlet UILabel *label_recordchallenge;
@property(strong,nonatomic)IBOutlet UILabel * label_BlueStrip;
@property(strong,nonatomic)IBOutlet UIView * View_record;
@property(strong,nonatomic)IBOutlet UILabel * label_record;
@property(strong,nonatomic)IBOutlet UIImageView * Image_record;
@end
