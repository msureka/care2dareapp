//
//  FavriteTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavriteTableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView * Image_Profile;
@property(strong,nonatomic)IBOutlet UIImageView * Image_PalyBuutton;

@property(strong,nonatomic)IBOutlet UILabel * Label_Changename;
@property(strong,nonatomic)IBOutlet UILabel * Label_Time;
@property(strong,nonatomic)IBOutlet UILabel * Label_Titile;
@property(strong,nonatomic)IBOutlet UILabel * Label_Backer;
@property(strong,nonatomic)IBOutlet UILabel * Label_Raised;
@property(strong,nonatomic)IBOutlet UILabel * label_JsonResult;
@end
