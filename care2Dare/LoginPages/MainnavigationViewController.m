//
//  MainnavigationViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/7/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "MainnavigationViewController.h"
#import "LoginPageViewController.h"
#import "TutorialViewController.h"
@interface MainnavigationViewController ()

@end

@implementation MainnavigationViewController
@synthesize Str_checkView;
- (void)viewDidLoad {
    [super viewDidLoad];
    if([Str_checkView isEqualToString:@"tutorial"])
    {
        TutorialViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TutorialViewController"];
        [self setViewControllers:@[loginController] animated:NO];
    }
    else
    {
        
        LoginPageViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginPageViewController"];
        [self setViewControllers:@[loginController] animated:NO];
       
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
