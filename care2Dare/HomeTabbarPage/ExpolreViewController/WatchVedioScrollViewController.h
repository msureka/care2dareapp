//
//  WatchVedioScrollViewController.h
//  care2Dare
//
//  Created by Spiel's Macmini on 5/3/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchVedioScrollViewController : UIViewController
@property(strong,nonatomic)IBOutlet UIScrollView * table_scrollview;
@property(nonatomic,strong)NSString * str_Userid2val;
@property(nonatomic,strong)NSString * str_ChallengeidVal;
//@property(nonatomic,strong)NSString *Str_urlVedio;
@property(nonatomic,strong)NSString *videoid1;
@property(nonatomic)NSInteger indexVedioindex;
@property(nonatomic,strong)NSString *str_challengeTitle;
//@property(nonatomic,retain)UIImageView *str_image_Data;
@property(nonatomic,retain)UIImage *str_image_Data;
@end
