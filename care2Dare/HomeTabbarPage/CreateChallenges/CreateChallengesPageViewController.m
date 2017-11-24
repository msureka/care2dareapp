//
//  CreateChallengesPageViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/8/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "CreateChallengesPageViewController.h"

#import "CreateFundriserViewController.h"

#import "CreateNewChallengesViewController.h"
#import "CreateChallengesViewController.h"
@interface CreateChallengesPageViewController ()<UITabBarControllerDelegate,UITabBarDelegate>
{
    NSString * viewCheck,*String_Cont_Name,*MoneyString,*_String_Cont_UserId;
    NSUserDefaults * defaults;
}
@end

@implementation CreateChallengesPageViewController

- (void)viewDidLoad {
     self.tabBarController.delegate=self;
    [super viewDidLoad];
    viewCheck=@"yes";
    defaults=[[NSUserDefaults alloc]init];
//    CreateNewChallengesViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateNewChallengesViewController"];
//          [self.navigationController presentViewController:set animated:YES completion:NULL];
    
        CreateChallengesViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateChallengesViewController"];
              [self.navigationController presentViewController:set animated:YES completion:NULL];
   

    
// [self.navigationController pushViewController:set animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
      [super viewWillAppear:YES];
    NSInteger tabindex=[[defaults valueForKey:@"tabchk"] integerValue];
     NSLog(@"tabindexxxxx=%ld",(long)tabindex);
    [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:tabindex];
   
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"controller class: %@", NSStringFromClass([viewController class]));
    NSLog(@"controller title: %@", viewController.title);
    NSString * check=NSStringFromClass([viewController class]);
    if ([check isEqualToString:@"CreateChallengesPageViewController"])
    {
//        CreateNewChallengesViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateNewChallengesViewController"];
//       [self.navigationController presentViewController:set animated:YES completion:NULL];
        CreateChallengesViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateChallengesViewController"];
        [self.navigationController presentViewController:set animated:YES completion:NULL];
    }
}

@end
