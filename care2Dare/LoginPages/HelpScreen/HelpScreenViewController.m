//
//  HelpScreenViewController.m
//  ScrollViewss
//
//  Created by MacMini2 on 12/10/17.
//  Copyright © 2017 MacMini2. All rights reserved.
//

#import "HelpScreenViewController.h"
#import "HelpViewOne.h"
#import "HelpViewTwo.h"
#import "HelpViewThree.h"
#import "HelpViewFour.h"
#import "HelpViewFive.h"
#import "LoginPageViewController.h"
@interface HelpScreenViewController ()
{
    HelpViewOne *view1;
    HelpViewTwo *view2;
    HelpViewThree *view3;
    HelpViewFour *view4;
    HelpViewFive *view5;
}
@end

@implementation HelpScreenViewController
@synthesize Str_CloseView;
- (void)viewDidLoad {
    [super viewDidLoad];
    view1 = [[[NSBundle mainBundle] loadNibNamed:@"HelpViewOne" owner:self options:nil] objectAtIndex:0];
    view2 = [[[NSBundle mainBundle] loadNibNamed:@"HelpViewTwo" owner:self options:nil]objectAtIndex:0];;
    view3 = [[[NSBundle mainBundle] loadNibNamed:@"HelpViewThree" owner:self options:nil]objectAtIndex:0];
    view4 = [[[NSBundle mainBundle] loadNibNamed:@"HelpViewFour" owner:self options:nil]objectAtIndex:0];
    view5 = [[[NSBundle mainBundle] loadNibNamed:@"HelpViewFive" owner:self options:nil]objectAtIndex:0];
 
    
    view1.hidden=NO;
    view2.hidden=YES;
    view3.hidden=YES;
    view4.hidden=YES;
    view5.hidden=YES;
    [view1 setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view2 setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view3 setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view4 setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view5 setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
     [view1.Button_NextOne addTarget:self action:@selector(Button_nextone_Action:) forControlEvents:UIControlEventTouchUpInside];
     [view2.Button_next2 addTarget:self action:@selector(Button_nexttwo_Action:) forControlEvents:UIControlEventTouchUpInside];
     [view3.Button_next3 addTarget:self action:@selector(Button_nextthree_Action:) forControlEvents:UIControlEventTouchUpInside];
     [view4.Button_next4 addTarget:self action:@selector(Button_nextfour_Action:) forControlEvents:UIControlEventTouchUpInside];
     [view5.Button_DoneFive addTarget:self action:@selector(Button_donefive_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];
    [self.view addSubview:view5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Button_nextone_Action:(id)sender
{
    view1.hidden=YES;
    view2.hidden=NO;
    view3.hidden=YES;
    view4.hidden=YES;
    view5.hidden=YES;
}
- (IBAction)Button_nexttwo_Action:(id)sender
{
    view1.hidden=YES;
    view2.hidden=YES;
    view3.hidden=NO;
    view4.hidden=YES;
    view5.hidden=YES;
}
- (IBAction)Button_nextthree_Action:(id)sender
{
    view1.hidden=YES;
    view2.hidden=YES;
    view3.hidden=YES;
    view4.hidden=NO;
    view5.hidden=YES;
}
- (IBAction)Button_nextfour_Action:(id)sender
{
    view1.hidden=YES;
    view2.hidden=YES;
    view3.hidden=YES;
    view4.hidden=YES;
    view5.hidden=NO;
}
- (IBAction)Button_donefive_Action:(id)sender
{
    if ([Str_CloseView isEqualToString:@"yes"])
    {
        static NSString* const hasRunAppOnceKey = @"hasRunAppOnceKey";
        NSUserDefaults* defaults1 = [NSUserDefaults standardUserDefaults];
        [defaults1 setBool:YES forKey:hasRunAppOnceKey];
        LoginPageViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginPageViewController"];
        [self.navigationController pushViewController:loginController animated:NO];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
}

@end
