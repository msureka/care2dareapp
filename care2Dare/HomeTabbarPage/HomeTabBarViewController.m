//
//  HomeTabBarViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//F

#import "HomeTabBarViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#define color180 [UIColor colorWithRed:24/255.0 green:161/255.0 blue:209/255.0 alpha:1]
@interface HomeTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>
{
     UITabBarItem *item0,*item1,*item2,*item3,*item4;
    NSUserDefaults * defaults;
    NSDictionary *urlplist;
    NSMutableArray * Array_Notifications;
}
@end

@implementation HomeTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    UITabBar *tabBar = self.tabBar;
    defaults=[[NSUserDefaults alloc]init];
    
NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    CGRect viewFrame = tabBar.frame;
    viewFrame.size.height = 56;
    self.tabBar.frame = viewFrame;

    item0 = [tabBar.items objectAtIndex:0];
    item1 = [tabBar.items objectAtIndex:1];
    item2 = [tabBar.items objectAtIndex:2];
    item3 = [tabBar.items objectAtIndex:3];
    item4 = [tabBar.items objectAtIndex:4];
    

    
    item0.selectedImage = [[UIImage imageNamed:@"explore.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item0.image = [[UIImage imageNamed:@"explore1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
   
    
    item3.selectedImage = [[UIImage imageNamed:@"activitytab.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item3.image = [[UIImage imageNamed:@"activitytab1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    item2.selectedImage = [[UIImage imageNamed:@"create.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item2.image = [[UIImage imageNamed:@"create.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    
    item1.selectedImage = [[UIImage imageNamed:@"inplaytab.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item1.image = [[UIImage imageNamed:@"inplaytab1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
  
    
    item4.selectedImage = [[UIImage imageNamed:@"profile.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item4.image = [[UIImage imageNamed:@"profile1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
  
    

//    
    item0.title=@"EXPLORE";
    item3.title=@"ACTIVITY";
    item2.title=@"";
    item1.title=@"CHALLENGES";
    item4.title=@"PROFILE";
    
    [item0 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
    color180,UITextAttributeTextColor,
[NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
                                            [UIFont fontWithName:@"SanFranciscoDisplay-Semibold" size:11.0], UITextAttributeFont, nil]
                                  forState:UIControlStateNormal];
    
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                   color180,UITextAttributeTextColor,
                                   [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
                                   [UIFont fontWithName:@"SanFranciscoDisplay-Semibold" size:11.0], UITextAttributeFont, nil]
                         forState:UIControlStateNormal];
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  color180,UITextAttributeTextColor,
                                   [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
                                   [UIFont fontWithName:@"SanFranciscoDisplay-Semibold" size:11.0], UITextAttributeFont, nil]
                         forState:UIControlStateNormal];
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                   color180,UITextAttributeTextColor,
                                   [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
                                   [UIFont fontWithName:@"SanFranciscoDisplay-Semibold" size:11.0], UITextAttributeFont, nil]
                         forState:UIControlStateNormal];
    [item4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                   color180,UITextAttributeTextColor,
                                   [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
                                   [UIFont fontWithName:@"SanFranciscoDisplay-Semibold" size:11.0], UITextAttributeFont, nil]
                         forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1], NSForegroundColorAttributeName
                                                       ,nil] forState:UIControlStateNormal];

       [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary  dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
  

//    [[UITabBar appearance] setTintColor:[UIColor redColor]];
//    [[UITabBar appearance] setAlpha:1];
    
   
    if ([[defaults valueForKey:@"tabindex"] isEqualToString:@"4"])
    {
        [defaults setObject:@"0" forKey:@"tabindex"];
        self.selectedIndex=4;
    }
    else if ([[defaults valueForKey:@"tabindex"] isEqualToString:@"3"])
    {
        [defaults setObject:@"0" forKey:@"tabindex"];
        self.selectedIndex=3;
        
    }
    else
    {
        self.selectedIndex=0;
    }
    [defaults setObject:@"0" forKey:@"tabchk"];
    [defaults synchronize];
    

    [self communicationServer];
  
   HomechatTimer =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(communicationServer) userInfo:nil  repeats:YES];
}
-(void)communicationServer
{

    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",userid,useridVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"notificationcount"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                                                     Array_Notifications=[[NSMutableArray alloc]init];
                                                     
    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
            Array_Notifications=[objSBJsonParser objectWithData:data];
                                                     
//        Array_Notifications=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                  
                                                     
                                                     
                                                     NSLog(@"Array_AllData ResultString %@",ResultString);
                                                     
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatedBudge" object:self userInfo:nil];
                                                     
            NSString *Str_budgeCount,*str_challengecount,*str_contributioncount,*str_videocount,*Str_friendreq;
                                                     
            Str_budgeCount=[NSString stringWithFormat:@"%@",[[Array_Notifications objectAtIndex:0]valueForKey:@"totalcount"]];
                                                     
        str_challengecount=[NSString stringWithFormat:@"%@",[[Array_Notifications objectAtIndex:0]valueForKey:@"challengecount"]];
        
     str_contributioncount=[NSString stringWithFormat:@"%@",[[Array_Notifications objectAtIndex:0]valueForKey:@"contributioncount"]];
                                                     
     str_videocount=[NSString stringWithFormat:@"%@",[[Array_Notifications objectAtIndex:0]valueForKey:@"videocount"]];
                                                     
Str_friendreq =[NSString stringWithFormat:@"%@",[[Array_Notifications objectAtIndex:0]valueForKey:@"friendreqs"]];
            if (![Str_friendreq isEqualToString:@""] && ![Str_friendreq isEqualToString:@"0"] )
                {
                                                         
//                    item4.badgeValue=Str_budgeCount;
                    item4.badgeValue=Str_friendreq;
                    [defaults setObject:Str_friendreq forKey:@"friendreqs"];
                   
                                                         
             }
            else
            {
                [defaults setObject:@"0" forKey:@"friendreqs"];
                item4.badgeValue=nil;
                
                
                
            }
                                                     
                        
                if (![Str_budgeCount isEqualToString:@""] && ![Str_budgeCount isEqualToString:@"0"] )
                        {
                                                         
                       //             item4.badgeValue=Str_budgeCount;
                        item3.badgeValue=Str_budgeCount;
                [defaults setObject:Str_budgeCount forKey:@"budge"];
                   
                                                         
                    }
                else
                {
                   
                    [defaults setObject:@"0" forKey:@"budge"];
                    item3.badgeValue=nil;
                    
                    
                    
                }

                
                    if (![str_challengecount isEqualToString:@""] && ![str_challengecount isEqualToString:@"0"] )
                    {
                        
                        
                        [defaults setObject:str_challengecount forKey:@"challengecount"];
                        
                        
                    }
                    else
                    {
                     
                        [defaults setObject:@"0" forKey:@"challengecount"];
                
                    }

                     if (![str_contributioncount isEqualToString:@""] && ![str_contributioncount isEqualToString:@"0"] )
                    {
                       
                        [defaults setObject:str_contributioncount forKey:@"contributioncount"];
                        
                        
                    }
                     else
                     {
                        
                         [defaults setObject:@"0" forKey:@"contributioncount"];
                         
                     }

                    if (![str_videocount isEqualToString:@""] && ![str_videocount isEqualToString:@"0"] )
                    {
                      
                        [defaults setObject:str_videocount forKey:@"videocount"];
                        
                    }
                    else
                    {
                        [defaults setObject:@"0" forKey:@"videocount"];
                        
                        
                    }

            [defaults synchronize];
                                                     
//    if (![Str_budgeCount isEqualToString:@""] && ![Str_budgeCount isEqualToString:@"0"] )
//                    {
//
//   //             item4.badgeValue=Str_budgeCount;
//                item3.badgeValue=Str_budgeCount;
//                [defaults setObject:Str_budgeCount forKey:@"budge"];
//                [defaults synchronize];
//
//                  }
//                    else
//                {
//        [defaults setObject:@"0" forKey:@"budge"];
//
//                    [defaults synchronize];
//  //      item4.badgeValue=nil;
//        item3.badgeValue=nil;
//                                        
//                }
//            if (![str_challengecount isEqualToString:@""] && ![str_challengecount isEqualToString:@"0"] )
//                    {
//                                                         
//   
//                [defaults setObject:str_challengecount forKey:@"challengecount"];
//                [defaults synchronize];
//                                                         
//                        }
//                else
//                {
//                [defaults setObject:@"0" forKey:@"challengecount"];
//                [defaults synchronize];
//                  }
//              if (![str_contributioncount isEqualToString:@""] && ![str_contributioncount isEqualToString:@"0"] )
//                  {
//               
//             [defaults setObject:str_contributioncount forKey:@"contributioncount"];
//              [defaults synchronize];
//                                                         
//               }
//               else
//               {
//             [defaults setObject:@"0" forKey:@"contributioncount"];
//              [defaults synchronize];
//              }
//              
//       if (![str_videocount isEqualToString:@""] && ![str_videocount isEqualToString:@"0"] )
//       {
//                                                         
//     [defaults setObject:str_videocount forKey:@"videocount"];
//     [defaults synchronize];
//       }
//       else
//         {
//          [defaults setObject:@"0" forKey:@"videocount"];
//        [defaults synchronize];
//            }
//        
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
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
//- (void)application:(UIApplication *)application
//
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//
//fetchCompletionHandler:
//
//(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    // Handle your message. With swizzling enabled, no need to indicate
//    
//    // that a message was received.
//    
//    
//    
//    
//    
//    
//    
//    if (application.applicationState == UIApplicationStateActive)
//    {
//        NSLog(@"active app running");
//    }
//    else
//    {
//        NSLog(@"Inactive app Notrunning");
////        if ([[userInfo valueForKey:@"type"] isEqualToString:@"friends"])
////        {
////            [defaults setObject:@"4" forKey:@"tabindex"];
////            //        [defaults setObject:@"friends" forKey:@"pushviewtab"];
////        }
////        else if ([[userInfo valueForKey:@"type"] isEqualToString:@"challenges"])
////        {
////            [defaults setObject:@"3" forKey:@"tabindex"];
////            [defaults setObject:@"challenges" forKey:@"pushviewtab"];
////        }
////        else if ( [[userInfo valueForKey:@"type"] isEqualToString:@"contribute"])
////        {
////            [defaults setObject:@"3" forKey:@"tabindex"];
////            [defaults setObject:@"contribute" forKey:@"pushviewtab"];
////        }
////        else if ([[userInfo valueForKey:@"type"] isEqualToString:@"videos"])
////        {
////            [defaults setObject:@"3" forKey:@"tabindex"];
////            [defaults setObject:@"videos" forKey:@"pushviewtab"];
////        }
////        else
////        {
////            [defaults setObject:@"0" forKey:@"tabindex"];
////            [defaults setObject:@"" forKey:@"pushviewtab"];
////        }
//    }
//        [defaults synchronize];
//        
//       
//    
//}
@end
