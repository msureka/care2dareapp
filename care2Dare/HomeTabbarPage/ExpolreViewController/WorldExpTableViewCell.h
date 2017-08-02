//
//  WorldExpTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 3/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPieView.h"
@interface WorldExpTableViewCell : UITableViewCell

@property(strong,nonatomic)IBOutlet UIImageView * Image_Profile;
@property(strong,nonatomic)IBOutlet UIImageView * Image_PalyBuutton;

@property(strong,nonatomic)IBOutlet UIImageView * Image_Profile2;
@property(strong,nonatomic)IBOutlet UIImageView * Image_PalyBuutton2;

@property(strong,nonatomic)IBOutlet UIImageView * Image_Profile3;
@property(strong,nonatomic)IBOutlet UIImageView * Image_PalyBuutton3;
@property(weak,nonatomic)IBOutlet UIActivityIndicatorView * activityIndicator1;
@property(weak,nonatomic)IBOutlet UIActivityIndicatorView * activityIndicator2;
@property(weak,nonatomic)IBOutlet UIActivityIndicatorView * activityIndicator3;
@property(strong,nonatomic)IBOutlet UILabel * label_JsonResult;

@end
