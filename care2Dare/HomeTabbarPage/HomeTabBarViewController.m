//
//  HomeTabBarViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "HomeTabBarViewController.h"
#import "Reachability.h"
@interface HomeTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>
{
     UITabBarItem *item0,*item1,*item2,*item3,*item4;
    NSUserDefaults * defaults;
    NSDictionary *urlplist;
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
    

    [self communicationServer];
    
    NSTimer *HomechatTimer =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(communicationServer) userInfo:nil  repeats:YES];
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
                                                     
                                                     
                                                     
                            NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                  
                                                     
                                                     
                                                     NSLog(@"Array_AllData ResultString %@",ResultString);
                                                     
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatedBudge" object:self userInfo:nil];
    if (![ResultString isEqualToString:@""] && ![ResultString isEqualToString:@"0"] )
                    {
       
                item4.badgeValue=ResultString;
                [defaults setObject:ResultString forKey:@"budge"];
                [defaults synchronize];

                  }
                    else
                {
        [defaults setObject:@"0" forKey:@"budge"];
                    [defaults synchronize];
        item4.badgeValue=nil;
                           
                                        
                                                         }
                                                     
                                                     
                                                     
                                                     
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
