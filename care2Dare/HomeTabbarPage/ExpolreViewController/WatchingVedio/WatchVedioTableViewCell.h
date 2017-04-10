//
//  WatchVedioTableViewCell.h
//  care2Dare
//
//  Created by Spiel's Macmini on 4/6/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchVedioTableViewCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UIProgressView *progressslider;
@property (nonatomic,strong) IBOutlet UIView *PlayerView;
@property (nonatomic,strong) IBOutlet UIButton *Button_back;
@property (nonatomic,strong) IBOutlet UIButton *Button_VolumeMute;
@property (nonatomic,strong) IBOutlet UIButton *Button_Threedots;

@property (nonatomic,strong) IBOutlet UIImageView *image_Thumbnail;

@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *indicator_loading;

@end
