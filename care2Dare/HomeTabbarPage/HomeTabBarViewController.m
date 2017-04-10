//
//  HomeTabBarViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "HomeTabBarViewController.h"

@interface HomeTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>
{
     UITabBarItem *item0,*item1,*item2,*item3,*item4;
    NSUserDefaults * defaults;
}
@end

@implementation HomeTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabBar = self.tabBar;
    defaults=[[NSUserDefaults alloc]init];
    CGRect viewFrame = tabBar.frame;
    viewFrame.size.height = 56;
    self.tabBar.frame = viewFrame;

    item0 = [tabBar.items objectAtIndex:0];
    item1 = [tabBar.items objectAtIndex:1];
    item2 = [tabBar.items objectAtIndex:2];
    item3 = [tabBar.items objectAtIndex:3];
    item4 = [tabBar.items objectAtIndex:4];
    

    
    item0.selectedImage = [[UIImage imageNamed:@"watch1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item0.image = [[UIImage imageNamed:@"watch.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
   
    
    item1.selectedImage = [[UIImage imageNamed:@"explore1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item1.image = [[UIImage imageNamed:@"explore.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    item2.selectedImage = [[UIImage imageNamed:@"create.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item2.image = [[UIImage imageNamed:@"create.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    
    item3.selectedImage = [[UIImage imageNamed:@"favourites1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item3.image = [[UIImage imageNamed:@"favourites.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
  
    
    item4.selectedImage = [[UIImage imageNamed:@"profile1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item4.image = [[UIImage imageNamed:@"profile.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
  
    
    
//    if ([[defautls valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defautls valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
//    {
//   
//        self.selectedIndex=2;
//    }
//    else
//    {
        self.selectedIndex=1;
//    }
    
    [defaults setObject:@"1" forKey:@"tabchk"];
    [defaults synchronize];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 56;
    tabFrame.origin.y = self.view.frame.size.height - 56;
    self.tabBar.frame = tabFrame;
}
- (void)tabBar:(UITabBar *)theTabBar didSelectItem:(UITabBarItem *)item
{
    NSUInteger indexOfTab = [[theTabBar items] indexOfObject:item];
    NSLog(@"Tab index = %u", (int)indexOfTab);
    
    
    if (((int)indexOfTab==0))
    {
//        [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:0];
        [defaults setObject:@"0" forKey:@"tabchk"];
        
    }
    
    if (((int)indexOfTab==1))
    {
        
         [defaults setObject:@"1" forKey:@"tabchk"];
        
//        [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:1];
       
        
    }
    
    if (((int)indexOfTab==2))
    {
        
     
    }
    
    if (((int)indexOfTab==3))
    {
         [defaults setObject:@"3" forKey:@"tabchk"];
//        [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:3];
    }
    if (((int)indexOfTab==4))
    {
       [defaults setObject:@"4" forKey:@"tabchk"];
//        [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:4];
        
    }
    
    [defaults synchronize];

}

@end
