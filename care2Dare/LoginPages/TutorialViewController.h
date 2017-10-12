//
//  TutorialViewController.h
//  care2Dare
//
//  Created by MacMini2 on 12/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController
//@property(nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *Button_next1;
@property (weak, nonatomic) IBOutlet UIButton *Button_Skip;
@property (weak, nonatomic) IBOutlet UIButton *Button_next2;

@property (weak, nonatomic) IBOutlet UIPageControl *PageControl;

- (IBAction)Button_Skip_Action:(id)sender;
- (IBAction)Button_getstared_Action:(id)sender;
- (IBAction)Button_Next_Action:(id)sender;
@end
