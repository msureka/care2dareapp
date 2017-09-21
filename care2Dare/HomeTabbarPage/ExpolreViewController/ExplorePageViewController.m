//
//  ExplorePageViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ExplorePageViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "ContributeDaetailPageViewController.h"
#import "AcceptContributeDetailViewController.h"
#import "SVPullToRefresh.h"
#define BlueColor [UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor
#define GrayColor [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor
#define GreenColor [UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor

@interface ExplorePageViewController ()<UISearchBarDelegate>
{
    CALayer *borderBottom_world,*borderBottom_ExpFrnd,*borderBottom_ExpFavourite;
    NSString * cellChecking;
    UIView *sectionView,*transparancyTuchView;
    UISearchBar *searchbar;
     NSDictionary *urlplist;
     NSUserDefaults *defaults;
    NSMutableArray * Array_WorldExp,* Array_FriendExp,* Array_Faourite,*Array_WorldExp1;;
    NSArray *SearchCrickArray_worldExp,*SearchCrickArray_FriendExp,*SearchCrickArray_Faourite;
    CALayer *bootomBorder_Cell;
    NSURLSessionDataTask *dataTaskExp,*dataTaskWld,*dataTaskFav;
    NSInteger Array_WorldCount,modvalues,pagescount;
    NSString * ResultString_World,*ResultString_Fav,*ResultString_Profile;
    NSString *flag_world,*flag_Fav,*flag_profile,*str_tablereload;
    
    BOOL viewDidLoadCalled,ViewVillAppear,Tablesinglereload;
    
}
@end
//favouriteexplore1.png
@implementation ExplorePageViewController
@synthesize Tableview_Explore,View_ExpFriend,view_ExpWorld,image_ExpWorld,image_ExpFriend,image_ExpFavourite,View_ExpFavourite,indicator;
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
     defaults=[[NSUserDefaults alloc]init];
    
    viewDidLoadCalled = YES;
    Tablesinglereload=YES;
    ViewVillAppear=NO;
    
    Array_WorldExp=[[NSMutableArray alloc]init];
    Array_WorldExp1=[[NSMutableArray alloc]init];
      Array_FriendExp=[[NSMutableArray alloc]init];
       Array_Faourite=[[NSMutableArray alloc]init];

    self.percent = 0.1;
     self.percent1 = 0.1;
     self.percent2 = 0.1;
    
    [defaults setObject:@"WorldExp" forKey:@"stop"];
    [defaults synchronize];
    cellChecking=@"WorldExp";
    
    flag_Fav=@"no";
    flag_world=@"no";
    flag_profile=@"no";
str_tablereload=@"no";
    
  
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,44)];
    searchbar.translucent=YES;
    searchbar.delegate=self;
    searchbar.searchBarStyle=UISearchBarStyleMinimal;
    searchbar.showsCancelButton=YES;
   
        [searchbar setShowsCancelButton:NO animated:YES];
    
    SearchCrickArray_worldExp=[[NSArray alloc]init];
    SearchCrickArray_Faourite=[[NSArray alloc]init];
    Tableview_Explore.tableHeaderView=searchbar;
    
     borderBottom_world = [CALayer layer];
     borderBottom_ExpFrnd = [CALayer layer];
    borderBottom_ExpFavourite = [CALayer layer];
    indicator.hidden=NO;
    [indicator startAnimating];
    [Tableview_Explore setHidden:YES];
    
    
    
    
    UITapGestureRecognizer *ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(ViewTapTapped_Expworld:)];
    [view_ExpWorld addGestureRecognizer:ViewTap11];
    //[image_ExpWorld addGestureRecognizer:ViewTap11];
    
    UITapGestureRecognizer *ViewTap22 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(ViewTapTapped_Expfriend:)];
    [View_ExpFriend addGestureRecognizer:ViewTap22];
    // [image_ExpFriend addGestureRecognizer:ViewTap22];
    
    
    
    
    UITapGestureRecognizer *ViewTap33 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(ViewTapTapped_Expfavourite:)];
    [View_ExpFavourite addGestureRecognizer:ViewTap33];
    
    
    
    
    transparancyTuchView=[[UIView alloc]initWithFrame:CGRectMake(0,114,self.view.frame.size.width,self.view.frame.size.height-70)];
    transparancyTuchView.backgroundColor=[UIColor whiteColor];
    [transparancyTuchView setAlpha:0.5];
    [self.view addSubview:transparancyTuchView];
    transparancyTuchView.hidden=YES;
    UITapGestureRecognizer * ViewTap51 =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(ViewTap51Tapped:)];
    [transparancyTuchView addGestureRecognizer:ViewTap51];
    
 [Tableview_Explore setContentOffset:CGPointMake(0, 44)];
   // [Tableview_Explore reloadData];
    
    [Tableview_Explore addPullToRefreshWithActionHandler:^{
        [self insertRowAtTop];
    }];
    
    // setup infinite scrolling
    [Tableview_Explore addInfiniteScrollingWithActionHandler:^{
        [self insertRowAtBottom];
    }];
   
    
    
    [self ClienserverComm_worldExp];
   // [self ClienserverComm_FriendExp];
    
}
- (void)insertRowAtTop {
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
       [self PulltoRefershtable];
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        [Tableview_Explore.pullToRefreshView stopAnimating];
    });
    }
    

    else if ([cellChecking isEqualToString:@"FriendExp"])
    {
       [Tableview_Explore.pullToRefreshView stopAnimating];
    }
    else if ([cellChecking isEqualToString:@"Favourite"])
    {
     [Tableview_Explore.pullToRefreshView stopAnimating];
    }
}


- (void)insertRowAtBottom {
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
    [self PulltoRefershtable1];
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        [Tableview_Explore.infiniteScrollingView stopAnimating];
    });
    }
    
    else if ([cellChecking isEqualToString:@"FriendExp"])
    {
       [Tableview_Explore.infiniteScrollingView stopAnimating];
    }
    else if ([cellChecking isEqualToString:@"Favourite"])
    {
        [Tableview_Explore.infiniteScrollingView stopAnimating];
    }

}
- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    view_ExpWorld.clipsToBounds=YES;
     View_ExpFriend.clipsToBounds=YES;
     View_ExpFavourite.clipsToBounds=YES;
    
    image_ExpWorld.clipsToBounds=YES;
    image_ExpFriend.clipsToBounds=YES;
    image_ExpFavourite.clipsToBounds=YES;
    
    
    
    [image_ExpWorld setImage:[UIImage imageNamed:@"exploreworld.png"]];
    [image_ExpFriend setImage:[UIImage imageNamed:@"explore_friends1.png"]];
    [image_ExpFavourite setImage:[UIImage imageNamed:@"favouriteexplore.png"]];
    
    
    borderBottom_world.backgroundColor =[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    borderBottom_world.frame = CGRectMake(0, view_ExpWorld.frame.size.height-2.5, view_ExpWorld.frame.size.width, 2.5);
    [view_ExpWorld.layer addSublayer:borderBottom_world];
    
    
    
   
    
    
   
    borderBottom_ExpFrnd.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFriend.frame.size.height-1, View_ExpFriend.frame.size.width, 1);
    [View_ExpFriend.layer addSublayer:borderBottom_ExpFrnd];
    
    
    
    
    
    
    
    borderBottom_ExpFavourite.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFavourite.frame = CGRectMake(0, View_ExpFavourite.frame.size.height-1, View_ExpFavourite.frame.size.width, 1);
    [View_ExpFavourite.layer addSublayer:borderBottom_ExpFavourite];
    
}
-(void)PulltoRefershtable
{

    
    int64_t delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        [Tableview_Explore.infiniteScrollingView stopAnimating];
    });
    
  
   
        
      //  [Tableview_Explore setContentOffset:CGPointMake(0, 44)];
        if ([cellChecking isEqualToString:@"WorldExp"])
        {
            str_tablereload=@"no";
            pagescount=0;
            ViewVillAppear=YES;
        
            [self ClienserverComm_worldExp];
        }
        if ([cellChecking isEqualToString:@"FriendExp"])
        {
            [self ClienserverComm_FriendExp];
        }
        if ([cellChecking isEqualToString:@"Favourite"])
        {
            [self ClienserverComm_Favourite];
        }
    
  
    
}
-(void)ClienserverComm_FriendExp
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
        
        NSString *exploretype= @"exploretype";
        NSString *exploretypeval =@"FRIENDS";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,exploretype,exploretypeval];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"explore_world"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        dataTaskExp =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                          
                                                     [Array_FriendExp removeAllObjects];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                Array_FriendExp =[objSBJsonParser objectWithData:data];
                                                     
            SearchCrickArray_FriendExp=[objSBJsonParser objectWithData:data];
                                                     
                        ResultString_Profile=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                ResultString_Profile = [ResultString_Profile stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     
            ResultString_Profile = [ResultString_Profile stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"Array_FriendExp %@",Array_FriendExp);
                                                     
                                                     
                                                     NSLog(@"Array_WorldExp ResultString %@",ResultString_Profile);
                    if ([ResultString_Profile isEqualToString:@"nouserid"])
                            {
                                                         
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                        }
                                                     
                                                     
                if ([ResultString_Profile isEqualToString:@"done"])
                        {
                                                         
                                                         
                                                         
                                                         
                            }
            flag_profile=@"yes";
            [Tableview_Explore setHidden:NO];
                                                     [indicator setHidden:YES];
                                                     [indicator stopAnimating];
                [Tableview_Explore reloadData];
                
            
                               
                                                     
            }
                                                 
                                else
                                    {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                        [indicator setHidden:YES];
                                        [indicator stopAnimating];
                                        [Tableview_Explore setHidden:NO];
                                        [Tableview_Explore reloadData];
                            }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 [indicator setHidden:YES];
                                                 [indicator stopAnimating];
                                                  [Tableview_Explore reloadData];
                                                 [Tableview_Explore setHidden:NO];
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTaskExp resume];
    }
    
}
-(void)ClienserverComm_worldExp
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
        NSString *pages= @"pages";
        NSString* pagesVal = [NSString stringWithFormat:@"%ld", (long)pagescount];
     
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,pages,pagesVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"explore_world"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        dataTaskWld =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                        
                                                     
                        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                    [Array_WorldExp1 removeAllObjects];
                       
                     Array_WorldExp1=[objSBJsonParser objectWithData:data];
                                                     
                    SearchCrickArray_worldExp=[objSBJsonParser objectWithData:data];
                                                     
                    ResultString_World=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                ResultString_World = [ResultString_World stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                    
        ResultString_World = [ResultString_World stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
            NSLog(@"Array_WorldExp %@",Array_WorldExp);
                                                     
                                                     
                NSLog(@"Array_WorldExp ResultString %@",ResultString_World);
                                      
                            indicator.hidden=YES;
                            [indicator stopAnimating];
                            [Tableview_Explore setHidden:NO];
                                                     
                if ([ResultString_World isEqualToString:@"nouserid"])
                                        {
                                                        
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                handler:nil];
                    [alertController addAction:actionOk];
                    [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     
                                                     
                                                     if ([ResultString_World isEqualToString:@"done"])
                                                     {
                                                         
                                                  
                                                         
                                                         
                                                     }
                                                     flag_world=@"yes";
                        if (Array_WorldExp1.count !=0)
                    {
                        if (ViewVillAppear==YES)
                        {
                            [Array_WorldExp removeAllObjects];
//                            [Array_WorldExp1 removeAllObjects];
                        ViewVillAppear=NO;
                       
                        }
                        NSUInteger count = Array_WorldCount;
                        NSLog(@"chect containt object==%@",[Array_WorldExp valueForKeyPath:@"pages"]);
                        if ([[Array_WorldExp valueForKeyPath:@"pages"] containsObject:[[Array_WorldExp1 objectAtIndex:Array_WorldExp1.count-1]valueForKey:@"pages"]])
                        {
                            
                        }
                        else
                        {
                        [Array_WorldExp addObjectsFromArray:Array_WorldExp1];
                             pagescount=pagescount+1;
                        }
                        
                        float arraycount=Array_WorldExp.count;
                        float newarraycount=arraycount/3.0;
                        
                        NSLog(@"Modddvalues==%f",ceil(newarraycount));
                      
                        Array_WorldCount= ceil(newarraycount);
                        
                         modvalues=(Array_WorldExp.count%3);
                        NSLog(@"Modddvalues==%ld",(long)modvalues);

                         if ([str_tablereload isEqualToString:@"no"])
                         {
                             str_tablereload=@"yes";
                           
                             
                         }
                    
                       
                            }
                      
         
                                                     [Tableview_Explore setHidden:NO];
                                                     [Tableview_Explore reloadData];
                                                     [indicator setHidden:YES];
                                                     [indicator stopAnimating];
                                                     
                                        //  [Tableview_Explore reloadData];
                                                     
                                                 }
                                             
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     [indicator setHidden:YES];
                                                     [indicator stopAnimating];[Tableview_Explore reloadData];
                                                     [Tableview_Explore setHidden:NO];
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 [indicator setHidden:YES];
                                                 [indicator stopAnimating];
                                                 NSLog(@"error login2.......%@",error.description);
                                                  [Tableview_Explore reloadData];
                                                 [Tableview_Explore setHidden:NO];
                                             }
                                             
                                             
                                         }];
        [dataTaskWld resume];
    }
   
}
-(void)ClienserverComm_Favourite
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"favourite-show"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        dataTaskFav =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                      {
                          if(data)
                          {
                              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                              NSInteger statusCode = httpResponse.statusCode;
                              if(statusCode == 200)
                              {
                                  
                               
                                  [Array_Faourite removeAllObjects];
                                  SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                  Array_Faourite=[objSBJsonParser objectWithData:data];
                                  SearchCrickArray_Faourite=[objSBJsonParser objectWithData:data];
                                  
                                  ResultString_Fav=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                  //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                  
                                  ResultString_Fav = [ResultString_Fav stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                  ResultString_Fav = [ResultString_Fav stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                  
                                  NSLog(@"Array_Faourite %@",Array_Faourite);
                                  
                                  
                                  NSLog(@"Array_WorldExp ResultString %@",ResultString_Fav);
                                  if ([ResultString_Fav isEqualToString:@"nouserid"])
                                  {
                                      
                                      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                      
                                      UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                         style:UIAlertActionStyleDefault
                                                                                       handler:nil];
                                      [alertController addAction:actionOk];
                                      [self presentViewController:alertController animated:YES completion:nil];
                                      
                                      
                                  }
                                  
                                  
                                  flag_Fav=@"yes";
                                
                                   [Tableview_Explore reloadData];
                                  [Tableview_Explore setHidden:NO];
                                  [indicator setHidden:YES];
                                  [indicator stopAnimating];
                                  
                                  
                                  
                              }
                              
                              else
                              {
                                  NSLog(@" error login1 ---%ld",(long)statusCode);
                                  [Tableview_Explore setHidden:NO];
                                  [indicator setHidden:YES];
                                  [indicator stopAnimating];
                                  [Tableview_Explore reloadData];
                                
                              }
                              
                              
                          }
                          else if(error)
                          {
                              
                              NSLog(@"error login2.......%@",error.description);
                              [indicator setHidden:YES];
                              [indicator stopAnimating];
                              [Tableview_Explore setHidden:NO];
                              [Tableview_Explore reloadData];
                          }
                          
                          
                      }];
        [dataTaskFav resume];
    }
    
}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    
    int64_t delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        [Tableview_Explore.infiniteScrollingView stopAnimating];
    });

    
        if (viewDidLoadCalled ==YES)
        {
            viewDidLoadCalled =NO;
        }
    else
    {
    
   // [Tableview_Explore setContentOffset:CGPointMake(0, 44)];
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
        
        [defaults setObject:@"WorldExp" forKey:@"stop"];
        
        if ( [[defaults valueForKey:@"ExpView_Update"] isEqualToString:@"yes"])
        {
            [Tableview_Explore setContentOffset:CGPointMake(0, 44)];
            if ( [[defaults valueForKey:@"Accept"] isEqualToString:@"yes"])
            {
                [Array_WorldExp removeAllObjects];
                [Tableview_Explore reloadData];
              [defaults setObject:@"no" forKey:@"Accept"];
            }
           
            str_tablereload=@"no";
            pagescount=0;
            ViewVillAppear=YES;
            
            [self ClienserverComm_worldExp];
            
            [defaults setObject:@"no" forKey:@"ExpView_Update"];
            
        }
        [defaults synchronize];
    }
    if ([cellChecking isEqualToString:@"FriendExp"])
    {
         [defaults setObject:@"FriendExp" forKey:@"stop"];
        [defaults synchronize];
        [self ClienserverComm_FriendExp];
    }
    if ([cellChecking isEqualToString:@"Favourite"])
    { [defaults setObject:@"Favourite" forKey:@"stop"];
        [defaults synchronize];
        [self ClienserverComm_Favourite];
    }
    }
}
- (void)ViewTap51Tapped:(UITapGestureRecognizer *)recognizer
{
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}



- (void)ViewTapTapped_Expworld:(UITapGestureRecognizer *)recognizer
{
    [defaults setObject:@"WorldExp" forKey:@"stop"];
    [defaults synchronize];
    [dataTaskExp cancel];
 cellChecking=@"WorldExp";
    
    
    view_ExpWorld.clipsToBounds=YES;
    View_ExpFriend.clipsToBounds=YES;
    View_ExpFavourite.clipsToBounds=YES;
    
    image_ExpWorld.clipsToBounds=YES;
    image_ExpFriend.clipsToBounds=YES;
    image_ExpFavourite.clipsToBounds=YES;
    
    [image_ExpWorld setImage:[UIImage imageNamed:@"exploreworld.png"]];
    [image_ExpFriend setImage:[UIImage imageNamed:@"explore_friends1.png"]];
    [image_ExpFavourite setImage:[UIImage imageNamed:@"favouriteexplore.png"]];
    
    borderBottom_world.backgroundColor =[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;//[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_world.frame = CGRectMake(0, view_ExpWorld.frame.size.height-2.5, view_ExpWorld.frame.size.width, 2.5);
    [view_ExpWorld.layer addSublayer:borderBottom_world];
    
    
    
    
    borderBottom_ExpFrnd.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFriend.frame.size.height-1, View_ExpFriend.frame.size.width, 1);
    [View_ExpFriend.layer addSublayer:borderBottom_ExpFrnd];
    
    
    borderBottom_ExpFavourite.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFavourite.frame = CGRectMake(0, View_ExpFavourite.frame.size.height-1, View_ExpFavourite.frame.size.width, 1);
    [View_ExpFavourite.layer addSublayer:borderBottom_ExpFavourite];
    
    
    
 //    [self ClienserverComm_worldExp];
    if (Array_WorldExp.count==0)
    {
        
    }
    else
    {
        
    }
    [Tableview_Explore reloadData];
}
- (void)ViewTapTapped_Expfriend:(UITapGestureRecognizer *)recognizer
{
    [defaults setObject:@"FriendExp" forKey:@"stop"];
    [defaults synchronize];

    [Tableview_Explore.infiniteScrollingView stopAnimating];
    [Tableview_Explore.pullToRefreshView stopAnimating];
    cellChecking=@"FriendExp";
    [dataTaskWld cancel];
    view_ExpWorld.clipsToBounds=YES;
    View_ExpFriend.clipsToBounds=YES;
    View_ExpFavourite.clipsToBounds=YES;
    
    image_ExpWorld.clipsToBounds=YES;
    image_ExpFriend.clipsToBounds=YES;
    image_ExpFavourite.clipsToBounds=YES;
    
    [image_ExpWorld setImage:[UIImage imageNamed:@"exploreworld1.png"]];
    [image_ExpFriend setImage:[UIImage imageNamed:@"explore_friends.png"]];
    [image_ExpFavourite setImage:[UIImage imageNamed:@"favouriteexplore.png"]];

    borderBottom_world.backgroundColor = [UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_world.frame = CGRectMake(0, view_ExpWorld.frame.size.height-1, view_ExpWorld.frame.size.width, 1);
    [view_ExpWorld.layer addSublayer:borderBottom_world];
    
    
    
    
    

    borderBottom_ExpFrnd.backgroundColor =[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;//[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFriend.frame.size.height-2.5, View_ExpFriend.frame.size.width, 2.5);
    [View_ExpFriend.layer addSublayer:borderBottom_ExpFrnd];
    
    borderBottom_ExpFavourite.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFavourite.frame = CGRectMake(0, View_ExpFavourite.frame.size.height-1, View_ExpFavourite.frame.size.width, 1);
    [View_ExpFavourite.layer addSublayer:borderBottom_ExpFavourite];

    
     [self ClienserverComm_FriendExp];
    if (Array_FriendExp.count==0)
    {
       
    }
    else
    {
        
    }
    
    [Tableview_Explore reloadData];
}
-(void)ViewTapTapped_Expfavourite:(UITapGestureRecognizer *)recognizer
{
    
    [defaults setObject:@"Favourite" forKey:@"stop"];
    [defaults synchronize];
    [Tableview_Explore.infiniteScrollingView stopAnimating];
    [Tableview_Explore.pullToRefreshView stopAnimating];
    cellChecking=@"Favourite";
    [dataTaskWld cancel];
    
    view_ExpWorld.clipsToBounds=YES;
    View_ExpFriend.clipsToBounds=YES;
    View_ExpFavourite.clipsToBounds=YES;
    
    image_ExpWorld.clipsToBounds=YES;
    image_ExpFriend.clipsToBounds=YES;
    image_ExpFavourite.clipsToBounds=YES;
    
    
    
    [image_ExpWorld setImage:[UIImage imageNamed:@"exploreworld1.png"]];
    [image_ExpFriend setImage:[UIImage imageNamed:@"explore_friends1.png"]];
    [image_ExpFavourite setImage:[UIImage imageNamed:@"favouriteexplore1.png"]];
    
    
    
    
    borderBottom_world.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_world.frame = CGRectMake(0, view_ExpWorld.frame.size.height-1, view_ExpWorld.frame.size.width, 1);
    [view_ExpWorld.layer addSublayer:borderBottom_world];

        borderBottom_ExpFrnd.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;//[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_ExpFrnd.frame = CGRectMake(0, View_ExpFriend.frame.size.height-1, View_ExpFriend.frame.size.width, 1);
    [View_ExpFriend.layer addSublayer:borderBottom_ExpFrnd];
    
    
    borderBottom_ExpFavourite.backgroundColor =[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    borderBottom_ExpFavourite.frame = CGRectMake(0, View_ExpFavourite.frame.size.height-2.5, View_ExpFavourite.frame.size.width, 2.5);
    [View_ExpFavourite.layer addSublayer:borderBottom_ExpFavourite];
    
    [self ClienserverComm_Favourite];
    
    if (Array_Faourite.count==0)
    {
       
    }
    else
    {
       
    }
    
    [Tableview_Explore reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
   

        if ([cellChecking isEqualToString:@"WorldExp"])
        {
            if (Array_WorldExp.count==0)
            {
                if ([flag_world isEqualToString:@"no"] ||[[defaults valueForKey:@"Accept"] isEqualToString:@"yes"])
                {
                    return 0;
                }
                else
                {
                    
                  return 1;
                }
                
            }
            else
            {
                if ( [[defaults valueForKey:@"Accept"] isEqualToString:@"yes"])
                {
                    [defaults setObject:@"no" forKey:@"Accept"];
                    [defaults synchronize];
                     return 0;
                    
                }
                else
                {
               return Array_WorldCount;
                }
            }
            
        }
        else if ([cellChecking isEqualToString:@"FriendExp"])
        {
            if (Array_FriendExp.count==0)
            {
                if ([flag_profile isEqualToString:@"no"])
                {
                    return 0;
                }
                else
                {
                    return 1;
                }
                
            }
            else
            {
            return Array_FriendExp.count;
            }
        }
        else if ([cellChecking isEqualToString:@"Favourite"])
        {
            
            if (Array_Faourite.count==0)
            {
                if ([flag_Fav isEqualToString:@"no"])
                {
                    return 0;
                }
                else
                {
                    return 1;
                }
                
            }
            else
            {
            
            return Array_Faourite.count;
            }
        }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    static NSString *cellIdW1=@"CellW1";
    static NSString *cellIdF1=@"CellF1";
   static NSString *cellIdF11=@"CellF";
   
    
        if ([cellChecking isEqualToString:@"WorldExp"])
            {
                
//                  cell_WorldExp = (WorldExpTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdW1 forIndexPath:indexPath];
//
            WorldExpTableViewCell * cell_WorldExp = [[[NSBundle mainBundle]loadNibNamed:@"WorldExpTableViewCell" owner:self options:nil] objectAtIndex:0];
                
               
                
                if (cell_WorldExp == nil)
                {
                    
                    cell_WorldExp = [[WorldExpTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdW1];
                    
                    
              }
                
                if (Array_WorldExp.count==0)
                {
                 
                    bootomBorder_Cell = [CALayer layer];
                    bootomBorder_Cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                    bootomBorder_Cell.frame = CGRectMake(0, cell_WorldExp.frame.size.height-1, cell_WorldExp.frame.size.width, 1);
                    [cell_WorldExp.layer addSublayer:bootomBorder_Cell];
                    
                    if ([ResultString_World isEqualToString:@"nochallenges"])
                    {
                         cell_WorldExp.label_JsonResult.text=@"All active challenges worldwide will be shown here.";
                    }
                    
                    cell_WorldExp.Image_Profile.hidden=YES;
                    cell_WorldExp.Image_PalyBuutton.hidden=YES;
                    
                    cell_WorldExp.Image_Profile2.hidden=YES;
                    cell_WorldExp.Image_PalyBuutton2.hidden=YES;
                    
                    cell_WorldExp.Image_Profile3.hidden=YES;
                    cell_WorldExp.Image_PalyBuutton3.hidden=YES;
                    cell_WorldExp.activityIndicator1.hidden=NO;
                    cell_WorldExp.activityIndicator2.hidden=NO;
                    cell_WorldExp.activityIndicator3.hidden=NO;
                    cell_WorldExp.label_JsonResult.hidden=NO;
                    [cell_WorldExp.activityIndicator1 setHidden:YES];
                    [cell_WorldExp.activityIndicator1 stopAnimating];
                    [cell_WorldExp.activityIndicator2 setHidden:YES];
                    [cell_WorldExp.activityIndicator2 stopAnimating];
                    [cell_WorldExp.activityIndicator3 setHidden:YES];
                    [cell_WorldExp.activityIndicator3 stopAnimating];
                    
                }
                else
                {
                    bootomBorder_Cell = [CALayer layer];
                    bootomBorder_Cell.backgroundColor = [UIColor clearColor].CGColor;
                    bootomBorder_Cell.frame = CGRectMake(0, cell_WorldExp.frame.size.height-1, cell_WorldExp.frame.size.width, 1);
                    [cell_WorldExp.layer addSublayer:bootomBorder_Cell];
                    cell_WorldExp.Image_Profile.hidden=NO;
                    cell_WorldExp.Image_PalyBuutton.hidden=NO;
                    
                    cell_WorldExp.Image_Profile2.hidden=NO;
                    cell_WorldExp.Image_PalyBuutton2.hidden=NO;
                    
                    cell_WorldExp.Image_Profile3.hidden=NO;
                    cell_WorldExp.Image_PalyBuutton3.hidden=NO;
                    
                    cell_WorldExp.label_JsonResult.hidden=YES;

                    CGFloat Image_Heiht=((self.view.frame.size.width-2)/3);
                    
                    
                    [cell_WorldExp.Image_Profile setFrame:CGRectMake(0, 1, Image_Heiht, Image_Heiht)];
                    [cell_WorldExp.Image_Profile2 setFrame:CGRectMake(cell_WorldExp.Image_Profile.frame.origin.x+Image_Heiht+1, 1, Image_Heiht, Image_Heiht)];
                    
                    [cell_WorldExp.Image_Profile3 setFrame:CGRectMake(cell_WorldExp.Image_Profile2.frame.origin.x+Image_Heiht+1, 1, Image_Heiht, Image_Heiht)];
                    
                    cell_WorldExp.activityIndicator1.center=cell_WorldExp.Image_Profile.center;
                    cell_WorldExp.activityIndicator2.center=cell_WorldExp.Image_Profile2.center;
                    cell_WorldExp.activityIndicator3.center=cell_WorldExp.Image_Profile3.center;
                    
                    cell_WorldExp.Image_PalyBuutton.center=cell_WorldExp.Image_Profile.center;
                    cell_WorldExp.Image_PalyBuutton2.center=cell_WorldExp.Image_Profile2.center;
                    cell_WorldExp.Image_PalyBuutton3.center=cell_WorldExp.Image_Profile3.center;
                
                self.pieView = [[MDPieView alloc]initWithFrame:CGRectMake((cell_WorldExp.Image_Profile.frame.size.width+cell_WorldExp.Image_Profile.frame.origin.x)-26, (cell_WorldExp.Image_Profile.frame.size.height+cell_WorldExp.Image_Profile.frame.origin.y)-26, 22, 22) andPercent:self.percent andColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
                [cell_WorldExp addSubview:self.pieView];
                
                
                self.pieView1 = [[MDPieView1 alloc]initWithFrame:CGRectMake((cell_WorldExp.Image_Profile2.frame.size.width+cell_WorldExp.Image_Profile2.frame.origin.x)-26, (cell_WorldExp.Image_Profile2.frame.size.height+cell_WorldExp.Image_Profile2.frame.origin.y)-26, 22, 22) andPercent:self.percent andColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
                [cell_WorldExp addSubview:self.pieView1];
                
                self.pieView2 = [[MDPieView2 alloc]initWithFrame:CGRectMake((cell_WorldExp.Image_Profile3.frame.size.width+cell_WorldExp.Image_Profile3.frame.origin.x)-26, (cell_WorldExp.Image_Profile3.frame.size.height+cell_WorldExp.Image_Profile3.frame.origin.y)-26, 22, 22) andPercent:self.percent andColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
                [cell_WorldExp addSubview:self.pieView2];
                
                NSDictionary *dic_worldexp,*dic_worldexp2,*dic_worldexp1;
                if (indexPath.row ==Array_WorldCount-1)
                {
                    
                
                    if (modvalues==0)
                    {
                         dic_worldexp=[Array_WorldExp objectAtIndex:(indexPath.row)*3];
                         dic_worldexp1=[Array_WorldExp objectAtIndex:((indexPath.row)*3)+1];
                         dic_worldexp2=[Array_WorldExp objectAtIndex:((indexPath.row)*3)+2];
                        
                        cell_WorldExp.Image_PalyBuutton.tag=((indexPath.row)*3);
                        cell_WorldExp.Image_PalyBuutton2.tag=((indexPath.row)*3)+1;
                        cell_WorldExp.Image_PalyBuutton3.tag=((indexPath.row)*3)+2;
                        
                        cell_WorldExp.Image_Profile.tag=((indexPath.row)*3)+0;
                        cell_WorldExp.Image_Profile2.tag=((indexPath.row)*3)+1;
                        cell_WorldExp.Image_Profile3.tag=((indexPath.row)*3)+2;
                        
                        self.pieView.tag=((indexPath.row)*3)+0;
                        self.pieView1.tag=((indexPath.row)*3)+1;
                        self.pieView2.tag=((indexPath.row)*3)+2;
                        
                        cell_WorldExp.Image_Profile.hidden=NO;
                        cell_WorldExp.Image_Profile2.hidden=NO;
                        cell_WorldExp.Image_Profile3.hidden=NO;
                        
                        cell_WorldExp.Image_PalyBuutton.hidden=NO;
                        cell_WorldExp.Image_PalyBuutton2.hidden=NO;
                        cell_WorldExp.Image_PalyBuutton3.hidden=NO;
                        
                        self.pieView.hidden=NO;
                        self.pieView1.hidden=NO;
                        self.pieView2.hidden=NO;
                        
                       
                        
                        
                    }
                    if (modvalues==1)
                    {
                        dic_worldexp=[Array_WorldExp objectAtIndex:(indexPath.row)*3];
                        
                        cell_WorldExp.Image_PalyBuutton.tag=((indexPath.row)*3);
                        
                        
                        cell_WorldExp.Image_Profile.tag=((indexPath.row)*3);
                        
                        self.pieView.tag=((indexPath.row)*3)+0;
                        

                        
                        cell_WorldExp.Image_Profile.hidden=NO;
                        cell_WorldExp.Image_Profile2.hidden=YES;
                        cell_WorldExp.Image_Profile3.hidden=YES;
                      
                        cell_WorldExp.Image_PalyBuutton.hidden=NO;
                        cell_WorldExp.Image_PalyBuutton2.hidden=YES;
                        cell_WorldExp.Image_PalyBuutton3.hidden=YES;
                        
                        self.pieView.hidden=NO;
                        self.pieView1.hidden=YES;
                        self.pieView2.hidden=YES;

                        
                    }
                    if (modvalues==2)
                    {
                       
                        dic_worldexp=[Array_WorldExp objectAtIndex:(indexPath.row)*3];
                      dic_worldexp1=[Array_WorldExp objectAtIndex:((indexPath.row)*3)+1];
                        
                        cell_WorldExp.Image_PalyBuutton.tag=((indexPath.row)*3);
                        cell_WorldExp.Image_PalyBuutton2.tag=((indexPath.row)*3)+1;
                       
                        
                        cell_WorldExp.Image_Profile.tag=((indexPath.row)*3)+0;
                        cell_WorldExp.Image_Profile2.tag=((indexPath.row)*3)+1;
                       
                        self.pieView.tag=((indexPath.row)*3)+0;
                        self.pieView1.tag=((indexPath.row)*3)+1;
                        

                        
                         cell_WorldExp.Image_Profile.hidden=NO;
                         cell_WorldExp.Image_Profile2.hidden=NO;
                         cell_WorldExp.Image_Profile3.hidden=YES;
                        cell_WorldExp.Image_PalyBuutton.hidden=NO;
                        cell_WorldExp.Image_PalyBuutton2.hidden=NO;
                        cell_WorldExp.Image_PalyBuutton3.hidden=YES;
                        
                        self.pieView.hidden=NO;
                        self.pieView1.hidden=NO;
                        self.pieView2.hidden=YES;
                    
                    }
                }
                else
                {
                    dic_worldexp=[Array_WorldExp objectAtIndex:(indexPath.row)*3];
                    dic_worldexp1=[Array_WorldExp objectAtIndex:((indexPath.row)*3)+1];
                    dic_worldexp2=[Array_WorldExp objectAtIndex:((indexPath.row)*3)+2];
                    
                    cell_WorldExp.Image_PalyBuutton.tag=((indexPath.row)*3);
                    cell_WorldExp.Image_PalyBuutton2.tag=((indexPath.row)*3)+1;
                    cell_WorldExp.Image_PalyBuutton3.tag=((indexPath.row)*3)+2;
                    
                    cell_WorldExp.Image_Profile.tag=((indexPath.row)*3)+0;
                    cell_WorldExp.Image_Profile2.tag=((indexPath.row)*3)+1;
                    cell_WorldExp.Image_Profile3.tag=((indexPath.row)*3)+2;
                    
                    self.pieView.tag=((indexPath.row)*3)+0;
                    self.pieView1.tag=((indexPath.row)*3)+1;
                    self.pieView2.tag=((indexPath.row)*3)+2;

                    cell_WorldExp.Image_Profile.hidden=NO;
                    cell_WorldExp.Image_Profile2.hidden=NO;
                    cell_WorldExp.Image_Profile3.hidden=NO;
                    
                    cell_WorldExp.Image_PalyBuutton.hidden=NO;
                    cell_WorldExp.Image_PalyBuutton2.hidden=NO;
                    cell_WorldExp.Image_PalyBuutton3.hidden=NO;
                    
                    self.pieView.hidden=NO;
                    self.pieView1.hidden=NO;
                    self.pieView2.hidden=NO;
                }
                
               // self.percent = 0.0;
              
                
                
                
                
            cell_WorldExp.Image_Profile.userInteractionEnabled=YES;
            UITapGestureRecognizer * ImageThumbnail_Tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageThumbnailVideo_Tapped2:)];
                [cell_WorldExp.Image_Profile addGestureRecognizer:ImageThumbnail_Tapped];
                
                
                  cell_WorldExp.Image_Profile2.userInteractionEnabled=YES;
                UITapGestureRecognizer * ImageThumbnail_Tapped2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageThumbnailVideo_Tapped2:)];
                [cell_WorldExp.Image_Profile2 addGestureRecognizer:ImageThumbnail_Tapped2];
                
                  cell_WorldExp.Image_Profile3.userInteractionEnabled=YES;
                UITapGestureRecognizer * ImageThumbnail_Tapped3 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageThumbnailVideo_Tapped2:)];
                [cell_WorldExp.Image_Profile3 addGestureRecognizer:ImageThumbnail_Tapped3];
                
                
//                cell_WorldExp.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
//                cell_WorldExp.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
//                cell_WorldExp.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
//                NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                

//        CGRect textRect = [text boundingRectWithSize:cell_WorldExp.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_WorldExp.Label_Titile.font} context:nil];
//                
//    int numberOfLines = textRect.size.height / cell_WorldExp.Label_Titile.font.pointSize;;
//        if (numberOfLines==1)
//        {
//    [cell_WorldExp.Label_Titile setFrame:CGRectMake(cell_WorldExp.Label_Titile.frame.origin.x, cell_WorldExp.Label_Titile.frame.origin.y, cell_WorldExp.Label_Titile.frame.size.width, cell_WorldExp.Label_Titile.frame.size.height/2)];
//                }
              
                
                
//                NSLog(@"number of lines=%d",numberOfLines);
//                
//                 cell_WorldExp.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
         
                
                
                 NSURL *url,*url1,*url2;
                
                url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
                   
                    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
                    [cell_WorldExp.activityIndicator1 setHidden:NO];
                    [cell_WorldExp.activityIndicator1 startAnimating];
                    
                    [cell_WorldExp.Image_Profile setImageWithURLRequest:imageRequest
                                                        placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]
                                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                     {
                         [cell_WorldExp.activityIndicator1 setHidden:YES];
                         [cell_WorldExp.activityIndicator1 stopAnimating];
                         
                         cell_WorldExp.Image_Profile.image = image;
                     }
                                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                     {
                         [cell_WorldExp.activityIndicator1 setHidden:YES];
                         [cell_WorldExp.activityIndicator1 stopAnimating];
                     }];
                    
                    
                    
//                    [cell_WorldExp.Image_Profile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];

                    
                    if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                                {
                
                        cell_WorldExp.Image_PalyBuutton.hidden=YES;
                                    
                            
                      
                
                                    
                                    NSString * tagreach=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"daysleft"]];
                                    NSString * Totaldays=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"totaldays"]];
                                    
                                    CGFloat progrssVal=1-([tagreach floatValue])/[Totaldays floatValue];
                                    NSString *per= [ NSString stringWithFormat:@"%.3f",progrssVal];
                                    // [cell_TwoDetails.ProgressBar_Total setProgress:[per floatValue]];
                                    self.percent =[per floatValue];
                                    NSLog(@"percentage==%f",progrssVal);
                                    NSLog(@"percentagecellrowindex==%f",[per floatValue]);
                                    [self.pieView reloadViewWithPercent:self.percent];
                                
                
                        }
                  else
                        {
                
                    cell_WorldExp.Image_PalyBuutton.hidden=NO;
                            
//                url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
                            
//            [cell_WorldExp.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                            
                            
                            
                            NSString * tagreach=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"daysleft"]];
                            NSString * Totaldays=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"totaldays"]];
                            
                            CGFloat progrssVal=1-([tagreach floatValue])/[Totaldays floatValue];
                            NSString *per= [ NSString stringWithFormat:@"%.3f",progrssVal];
                            // [cell_TwoDetails.ProgressBar_Total setProgress:[per floatValue]];
                            self.percent =[per floatValue];
                            NSLog(@"percentage==%f",progrssVal);
                            NSLog(@"percentagecellrowindexelse==%f",[per floatValue]);
                            [self.pieView reloadViewWithPercent:self.percent];
                            
                                    }
                
                   
                
                    
                    url1=[NSURL URLWithString:[dic_worldexp1 valueForKey:@"mediathumbnailurl"]];
                    
                    NSURLRequest *imageRequest1 = [NSURLRequest requestWithURL:url1];
                    [cell_WorldExp.activityIndicator2 setHidden:NO];
                    [cell_WorldExp.activityIndicator2 startAnimating];
                   
                    [cell_WorldExp.Image_Profile2 setImageWithURLRequest:imageRequest1
                                      placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                     {
                         [cell_WorldExp.activityIndicator2 setHidden:YES];
                         [cell_WorldExp.activityIndicator2 stopAnimating];
                         
                         cell_WorldExp.Image_Profile2.image = image;
                     }
                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                     {
                         [cell_WorldExp.activityIndicator2 setHidden:YES];
                        [cell_WorldExp.activityIndicator2 stopAnimating];
                     }];
                    
//                    [cell_WorldExp.Image_Profile2 setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                    
                if ( [[dic_worldexp1 valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                {
                    
                 
                cell_WorldExp.Image_PalyBuutton2.hidden=YES;
                    
                    
                    NSString * tagreach1=[NSString stringWithFormat:@"%@",[dic_worldexp1 valueForKey:@"daysleft"]];
                    NSString * Totaldays1=[NSString stringWithFormat:@"%@",[dic_worldexp1 valueForKey:@"totaldays"]];
                    
                    CGFloat progrssVal1=1-([tagreach1 floatValue])/[Totaldays1 floatValue];
                    NSString *per1= [ NSString stringWithFormat:@"%.3f",progrssVal1];
                    // [cell_TwoDetails.ProgressBar_Total setProgress:[per floatValue]];
                    self.percent1 =[per1 floatValue];
                    NSLog(@"percentage==%f",progrssVal1);
                    NSLog(@"percentage111worldxp2==%f",[per1 floatValue]);
                    [self.pieView1 reloadViewWithPercent:self.percent1];
                    
                }
 else
                {
                    
                
                    cell_WorldExp.Image_PalyBuutton2.hidden=NO;
                    
//                                url1=[NSURL URLWithString:[dic_worldexp1 valueForKey:@"mediathumbnailurl"]];
//
//                [cell_WorldExp.Image_Profile2 sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                    
                    NSString * tagreach1=[NSString stringWithFormat:@"%@",[dic_worldexp1 valueForKey:@"daysleft"]];
                    NSString * Totaldays1=[NSString stringWithFormat:@"%@",[dic_worldexp1 valueForKey:@"totaldays"]];
                    
                    CGFloat progrssVal1=1-([tagreach1 floatValue])/[Totaldays1 floatValue];
                    NSString *per1= [ NSString stringWithFormat:@"%.3f",progrssVal1];
                    // [cell_TwoDetails.ProgressBar_Total setProgress:[per floatValue]];
                    self.percent1 =[per1 floatValue];
                    NSLog(@"percentage==%f",progrssVal1);
                    NSLog(@"percentage111worldxp2==%f",[per1 floatValue]);
                    [self.pieView1 reloadViewWithPercent:self.percent1];
                }
            
           
                    
                    url2=[NSURL URLWithString:[dic_worldexp2 valueForKey:@"mediathumbnailurl"]];
                    
                    NSURLRequest *imageRequest3 = [NSURLRequest requestWithURL:url2];
                    [cell_WorldExp.activityIndicator3 setHidden:NO];
                    [cell_WorldExp.activityIndicator3 startAnimating];
                    
                    [cell_WorldExp.Image_Profile3 setImageWithURLRequest:imageRequest3
                                                        placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]
                                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                     {
                         [cell_WorldExp.activityIndicator3 setHidden:YES];
                         [cell_WorldExp.activityIndicator3 stopAnimating];
                         
                         cell_WorldExp.Image_Profile3.image = image;
                     }
                                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                     {
                         [cell_WorldExp.activityIndicator3 setHidden:YES];
                         [cell_WorldExp.activityIndicator3 stopAnimating];
                     }];

                
                  
//                    [cell_WorldExp.Image_Profile3 setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                    
                    
                if ([[dic_worldexp2 valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                {
                    
                    cell_WorldExp.Image_PalyBuutton3.hidden=YES;
                    
                    
                    
                    NSString * tagreach2=[NSString stringWithFormat:@"%@",[dic_worldexp2 valueForKey:@"daysleft"]];
                    NSString * Totaldays2=[NSString stringWithFormat:@"%@",[dic_worldexp2 valueForKey:@"totaldays"]];
                    
                    CGFloat progrssVal2=1-([tagreach2 floatValue])/[Totaldays2 floatValue];
                    NSString *per2= [ NSString stringWithFormat:@"%.3f",progrssVal2];
                    // [cell_TwoDetails.ProgressBar_Total setProgress:[per floatValue]];
                    self.percent2 =[per2 floatValue];
                   
                    [self.pieView2 reloadViewWithPercent:self.percent2];
                    
                }
                else
                {
                    
                  
                    cell_WorldExp.Image_PalyBuutton3.hidden=NO;
                    
                    
//                url2=[NSURL URLWithString:[dic_worldexp2 valueForKey:@"mediathumbnailurl"]];
//                      [cell_WorldExp.Image_Profile3 sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                    
                    NSString * tagreach2=[NSString stringWithFormat:@"%@",[dic_worldexp2 valueForKey:@"daysleft"]];
                    NSString * Totaldays2=[NSString stringWithFormat:@"%@",[dic_worldexp2 valueForKey:@"totaldays"]];
                    
                    CGFloat progrssVal2=1-([tagreach2 floatValue])/[Totaldays2 floatValue];
                    NSString *per2= [ NSString stringWithFormat:@"%.3f",progrssVal2];
                    // [cell_TwoDetails.ProgressBar_Total setProgress:[per floatValue]];
                    self.percent2 =[per2 floatValue];
                    NSLog(@"percentage==%f",progrssVal2);
                    NSLog(@"percentage111mediatype==%f",[per2 floatValue]);
                    [self.pieView2 reloadViewWithPercent:self.percent2];
                   
            }
                    
                
}
                
                
  
               
                return cell_WorldExp;
                
            }
            if ([cellChecking isEqualToString:@"FriendExp"])
            {
                
                FriendExpTableViewCell * cell_FriendExp = [[[NSBundle mainBundle]loadNibNamed:@"FriendExpTableViewCell" owner:self options:nil] objectAtIndex:0];
                
                
                if (cell_FriendExp == nil)
                {
                    
                    cell_FriendExp = [[FriendExpTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdF1];
                }
                
                
                
                
               
              
                bootomBorder_Cell = [CALayer layer];
                bootomBorder_Cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                bootomBorder_Cell.frame = CGRectMake(0, cell_FriendExp.frame.size.height-1, cell_FriendExp.frame.size.width, 1);
                [cell_FriendExp.layer addSublayer:bootomBorder_Cell];
                
               
                
                
                if (Array_FriendExp.count==0)
                {
                    cell_FriendExp.Image_Profile.hidden=YES;
                    cell_FriendExp.Image_PalyBuutton.hidden=YES;;
                    cell_FriendExp.Label_Changename.hidden=YES;;
                    cell_FriendExp.Label_Time.hidden=YES;;
                    cell_FriendExp.Label_Titile.hidden=YES;;
                    cell_FriendExp.Label_Backer.hidden=YES;;
                    cell_FriendExp.Label_Raised.hidden=YES;;
                    cell_FriendExp.Label_Backername.hidden=YES;;
                    cell_FriendExp.Label_Raisedname.hidden=YES;;
                    cell_FriendExp.label_JsonResult.hidden=NO;;
                    if ([ResultString_Profile isEqualToString:@"nochallenges"])
                    {
                        
                        
                        
                        
                        cell_FriendExp.label_JsonResult.text=@"All the active challenges of your friends will be shown here.";
                    }
                  
                }
                else
                {
                
                    
                    cell_FriendExp.Image_Profile.hidden=NO;
                    cell_FriendExp.Image_PalyBuutton.hidden=NO;;
                    cell_FriendExp.Label_Changename.hidden=NO;;
                    cell_FriendExp.Label_Time.hidden=NO;;
                    cell_FriendExp.Label_Titile.hidden=NO;;
                    cell_FriendExp.Label_Backer.hidden=NO;;
                    cell_FriendExp.Label_Raised.hidden=NO;;
                    cell_FriendExp.Label_Backername.hidden=NO;;
                    cell_FriendExp.Label_Raisedname.hidden=NO;;
                    cell_FriendExp.label_JsonResult.hidden=YES;;
                    
                
                    [cell_FriendExp.Image_Profile setFrame:CGRectMake(cell_FriendExp.Image_Profile.frame.origin.x, cell_FriendExp.Image_Profile.frame.origin.y, cell_FriendExp.Image_Profile.frame.size.width, cell_FriendExp.Image_Profile.frame.size.width)];
                    
                    
                NSDictionary * dic_worldexp=[Array_FriendExp objectAtIndex:indexPath.row];
                cell_FriendExp.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
                cell_FriendExp.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
                cell_FriendExp.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                
                
                CGRect textRect = [text boundingRectWithSize:cell_FriendExp.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_FriendExp.Label_Titile.font} context:nil];
                
                int numberOfLines = textRect.size.height / cell_FriendExp.Label_Titile.font.pointSize;;
                if (numberOfLines==1)
                {
                    [cell_FriendExp.Label_Titile setFrame:CGRectMake(cell_FriendExp.Label_Titile.frame.origin.x, cell_FriendExp.Label_Titile.frame.origin.y, cell_FriendExp.Label_Titile.frame.size.width, cell_FriendExp.Label_Titile.frame.size.height/2)];
                }
               else
            {
                    [cell_FriendExp.Label_Titile setFrame:CGRectMake(cell_FriendExp.Label_Titile.frame.origin.x, cell_FriendExp.Label_Titile.frame.origin.y, cell_FriendExp.Label_Titile.frame.size.width, cell_FriendExp.Label_Titile.frame.size.height)];
                    }
                
                
                
                NSLog(@"number of lines=%d",numberOfLines);
                
                cell_FriendExp.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengeid"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengerdetails"];
                
                //cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediatype"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediaurl"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"noofchallengers"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"payperchallenger"];
                
                
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
                    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
                    
                    [cell_FriendExp.Image_Profile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
                    
                   
                    
                    
                    
                if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                {
                    cell_FriendExp.Image_PalyBuutton.hidden=YES;
                    
                   
                }
                else
                {
                    
//                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
//                    
//                    [cell_FriendExp.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
                    cell_FriendExp.Image_PalyBuutton.hidden=NO;
                    
                    
                }
                
                
                
                UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[dic_worldexp valueForKey:@"usersname"] attributes: arialDict];
                
                UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-SemiBold" size:14.0];
                NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
                NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: @" Challenges " attributes:verdanaDict];
                
                
                UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
                NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
                NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_worldexp valueForKey:@"challengerdetails"] attributes:verdanaDict2];
                
                [aAttrString appendAttributedString:vAttrString];
                [aAttrString appendAttributedString:cAttrString];
                
                
                cell_FriendExp.Label_Changename.attributedText = aAttrString;
                }
                return cell_FriendExp;
                
      
    }
    if ([cellChecking isEqualToString:@"Favourite"])
    {
        
        FavriteTableViewCell *cell_Favorite = [[[NSBundle mainBundle]loadNibNamed:@"FavriteTableViewCell" owner:self options:nil] objectAtIndex:0];
        
        
        if (cell_Favorite == nil)
        {
            
            cell_Favorite = [[FavriteTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdF11];
        }
        
        
        bootomBorder_Cell = [CALayer layer];
        bootomBorder_Cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        bootomBorder_Cell.frame = CGRectMake(0, cell_Favorite.frame.size.height-1, cell_Favorite.frame.size.width, 1);
        [cell_Favorite.layer addSublayer:bootomBorder_Cell];
        
        
        if (Array_Faourite.count==0)
        {
            if ([ResultString_Fav isEqualToString:@"nochallenges"])
            {
                
                cell_Favorite.label_JsonResult.text=@"All the challenges which you tag as favourite will be shown here.";
            }
        
            
            
            
            
             cell_Favorite.Image_Profile.hidden=YES;
            cell_Favorite.Image_PalyBuutton.hidden=YES;
            cell_Favorite.Label_Changename.hidden=YES;
            cell_Favorite.Label_Time.hidden=YES;
           cell_Favorite.Label_Titile.hidden=YES;
           cell_Favorite.Label_Backer.hidden=YES;
           cell_Favorite.Label_Raised.hidden=YES;
           cell_Favorite.label_JsonResult.hidden=NO;
            
            
        }
        else
        {
            cell_Favorite.Image_Profile.hidden=NO;
            cell_Favorite.Image_PalyBuutton.hidden=NO;
            cell_Favorite.Label_Changename.hidden=NO;
            cell_Favorite.Label_Time.hidden=NO;
            cell_Favorite.Label_Titile.hidden=NO;
            cell_Favorite.Label_Backer.hidden=NO;
            cell_Favorite.Label_Raised.hidden=NO;
            cell_Favorite.label_JsonResult.hidden=YES;
        
         [cell_Favorite.Image_Profile setFrame:CGRectMake(cell_Favorite.Image_Profile.frame.origin.x, cell_Favorite.Image_Profile.frame.origin.y, cell_Favorite.Image_Profile.frame.size.width, cell_Favorite.Image_Profile.frame.size.width)];
            
        NSDictionary * dic_worldexp=[Array_Faourite objectAtIndex:indexPath.row];
        cell_Favorite.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
        cell_Favorite.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
        cell_Favorite.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
        NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
        
        
        CGRect textRect = [text boundingRectWithSize:cell_Favorite.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_Favorite.Label_Titile.font} context:nil];
        
        int numberOfLines = textRect.size.height / cell_Favorite.Label_Titile.font.pointSize;;
        if (numberOfLines==1)
        {
            [cell_Favorite.Label_Titile setFrame:CGRectMake(cell_Favorite.Label_Titile.frame.origin.x, cell_Favorite.Label_Titile.frame.origin.y, cell_Favorite.Label_Titile.frame.size.width, cell_Favorite.Label_Titile.frame.size.height/2)];
        }
        
        
        
        NSLog(@"number of lines=%d",numberOfLines);
        
        cell_Favorite.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengeid"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengerdetails"];
        
        //cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediatype"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediaurl"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"noofchallengers"];
        // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"payperchallenger"];
        
        
            
            
            NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
            
            [cell_Favorite.Image_Profile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
            
           
            
            
        if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
        {
            cell_Favorite.Image_PalyBuutton.hidden=YES;
            
           
        }
        else
        {
            
//            NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
//            
//            [cell_Favorite.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] ];
            cell_Favorite.Image_PalyBuutton.hidden=NO;
            
            
        }
        
            
        
        UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[dic_worldexp valueForKey:@"usersname"] attributes: arialDict];
        
        UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-SemiBold" size:14.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: @" Challenges " attributes:verdanaDict];
        
        
        UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
        NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_worldexp valueForKey:@"challengerdetails"] attributes:verdanaDict2];
        
        [aAttrString appendAttributedString:vAttrString];
        [aAttrString appendAttributedString:cAttrString];
        
        
        cell_Favorite.Label_Changename.attributedText = aAttrString;
        }
        return cell_Favorite;
        
        
    }
   // return nil;
    abort();
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
        if ([cellChecking isEqualToString:@"WorldExp"])
        {
           
            return self.view.frame.size.width/3;
            
        }
        if ([cellChecking isEqualToString:@"FriendExp"])
        {
            
            return 140;;
            
           
        }
        if ([cellChecking isEqualToString:@"Favourite"])
        {
          
               return 100;
            
            
        }
  
    return 0;
}
- (void)ImageThumbnailVideo_Tapped2:(UITapGestureRecognizer *)sender12
{
    UIGestureRecognizer *rec = (UIGestureRecognizer*)sender12;
    UIImageView *imageView = (UIImageView *)rec.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);
    ContributeDaetailPageViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeDaetailPageViewController"];
    
     AcceptContributeDetailViewController * set2=[self.storyboard instantiateViewControllerWithIdentifier:@"AcceptContributeDetailViewController"];
    
    NSDictionary *  didselectDic;
    NSMutableArray * Array_new=[[NSMutableArray alloc]init];
     didselectDic=[Array_WorldExp  objectAtIndex:(long)imageView.tag];
    [Array_new addObject:didselectDic];
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
//    set2.ProfileImgeData =imageView.image;
//    set.ProfileImgeData =imageView.image;
       
    }
    
 if ([[NSString stringWithFormat:@"%@",[didselectDic valueForKey:@"accepted"] ]isEqualToString:@"yes"]|| [[NSString stringWithFormat:@"%@",[didselectDic valueForKey:@"accepted"] ]isEqualToString:@""] )
            {
               
                set.AllArrayData =Array_new;
                [self.navigationController pushViewController:set animated:YES];
                
            }
            else
            {
              
                set2.AllArrayData =Array_new;
                [self.navigationController pushViewController:set2 animated:YES];
            }
            
    
        
        NSLog(@"Array_new11=%@",Array_new);;
        
        
        
        

        
        
   
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContributeDaetailPageViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeDaetailPageViewController"];
    AcceptContributeDetailViewController * set2=[self.storyboard instantiateViewControllerWithIdentifier:@"AcceptContributeDetailViewController"];
    NSDictionary *  didselectDic;
    NSMutableArray * Array_new=[[NSMutableArray alloc]init];
    if ([cellChecking isEqualToString:@"FriendExp"])
    {
        if (Array_FriendExp.count !=0)
        {
       
     didselectDic=[Array_FriendExp  objectAtIndex:indexPath.row];
//        cell_FriendExp = [Tableview_Explore cellForRowAtIndexPath:indexPath];
//         set.ProfileImgeData =cell_FriendExp.Image_Profile.image;
//        set2.ProfileImgeData =cell_FriendExp.Image_Profile.image;
    
        [Array_new addObject:didselectDic];
        if ([[NSString stringWithFormat:@"%@",[didselectDic valueForKey:@"accepted"] ]isEqualToString:@"yes"] || [[NSString stringWithFormat:@"%@",[didselectDic valueForKey:@"accepted"] ]isEqualToString:@""])
        {
            
            set.AllArrayData =Array_new;
            [self.navigationController pushViewController:set animated:YES];
            
        }
        else
        {
            
            set2.AllArrayData =Array_new;
            [self.navigationController pushViewController:set2 animated:YES];
        }
        
        
        }
        NSLog(@"Array_new11=%@",Array_new);;
    }
    if ([cellChecking isEqualToString:@"Favourite"])
    {
        if (Array_Faourite.count !=0)
        {
        didselectDic=[Array_Faourite  objectAtIndex:indexPath.row];
//        cell_Favorite = [Tableview_Explore cellForRowAtIndexPath:indexPath];
        //  set.ProfileImgeData =cell_Favorite.Image_Profile.image;
        [Array_new addObject:didselectDic];
        if ([[NSString stringWithFormat:@"%@",[didselectDic valueForKey:@"accepted"] ]isEqualToString:@"yes"] || [[NSString stringWithFormat:@"%@",[didselectDic valueForKey:@"accepted"] ]isEqualToString:@""])
        {
            
            set.AllArrayData =Array_new;
            [self.navigationController pushViewController:set animated:YES];
            
        }
        else
        {
            
            set2.AllArrayData =Array_new;
            [self.navigationController pushViewController:set2 animated:YES];
        }

        
    }
    
    }
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    transparancyTuchView.hidden=NO;
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    transparancyTuchView.hidden=YES;
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
        
    
        
        
        if (searchText.length==0)
        {
            transparancyTuchView.hidden=NO;
            [Array_WorldExp removeAllObjects];
            [Array_WorldExp addObjectsFromArray:SearchCrickArray_worldExp];
            
        }
        else
            
        {
            transparancyTuchView.hidden=YES;

            [Array_WorldExp removeAllObjects];
            
            for (NSDictionary *book in SearchCrickArray_worldExp)
            {
                NSString * string=[book objectForKey:@"title"];
                NSString * string1=[book objectForKey:@"usersname"];
                NSString * string2=[book objectForKey:@"challengersname"];
                
                NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange r1=[string1 rangeOfString:searchText options:NSCaseInsensitiveSearch];
                NSRange r2=[string2 rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (r.location !=NSNotFound || r1.location !=NSNotFound || r2.location !=NSNotFound)
                {
                    
                    [Array_WorldExp addObject:book];
                
                }
                
            }
        
                float arraycount=Array_WorldExp.count;
                float newarraycount=arraycount/3.0;
                
                NSLog(@"Modddvalues==%f",ceil(newarraycount));
                
                Array_WorldCount= ceil(newarraycount);
                
                modvalues=(Array_WorldExp.count%3);
                NSLog(@"Modddvalues==%ld",(long)modvalues);
                
           
        }
        
    }
    
    
    if ([cellChecking isEqualToString:@"FriendExp"])
    {
        
        
        
        if (searchText.length==0)
        {
            transparancyTuchView.hidden=NO;
            [Array_FriendExp removeAllObjects];
            [Array_FriendExp addObjectsFromArray:SearchCrickArray_FriendExp];
            
        }
        else
            
        {
            transparancyTuchView.hidden=YES;
            
            [Array_FriendExp removeAllObjects];
            
            for (NSDictionary *book in SearchCrickArray_FriendExp)
            {
                NSString * string=[book objectForKey:@"title"];
                NSString * string1=[book objectForKey:@"usersname"];
                NSString * string2=[book objectForKey:@"challengersname"];
                
            NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange r1=[string1 rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange r2=[string2 rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (r.location !=NSNotFound || r1.location !=NSNotFound || r2.location !=NSNotFound)
                {

                    
                    [Array_FriendExp addObject:book];
                    
                }
                
            }
            
        }
        
    }
 
    
    if ([cellChecking isEqualToString:@"Favourite"])
    {
        
        
        
        if (searchText.length==0)
        {
            transparancyTuchView.hidden=NO;
            [Array_Faourite removeAllObjects];
            [Array_Faourite addObjectsFromArray:SearchCrickArray_Faourite];
            
        }
        else
            
        {
            transparancyTuchView.hidden=YES;
            
            [Array_Faourite removeAllObjects];
            
            for (NSDictionary *book in SearchCrickArray_Faourite)
            {
                NSString * string=[book objectForKey:@"title"];
                NSString * string1=[book objectForKey:@"usersname"];
                NSString * string2=[book objectForKey:@"challengersname"];
                
                NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
                NSRange r1=[string1 rangeOfString:searchText options:NSCaseInsensitiveSearch];
                NSRange r2=[string2 rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (r.location !=NSNotFound || r1.location !=NSNotFound || r2.location !=NSNotFound)
                {
                    
                    
                    [Array_Faourite addObject:book];
                    
                }
                
            }
            
        }
        
    }
    
 
    [searchBar setShowsCancelButton:YES animated:YES];
    
    [Tableview_Explore reloadData];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
    searchBar.text=@"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [Tableview_Explore setContentOffset:CGPointMake(0, 44) animated:YES];
    [searchbar resignFirstResponder];
    if ([cellChecking isEqualToString:@"WorldExp"])
    {
    [Array_WorldExp removeAllObjects];
    [Array_WorldExp addObjectsFromArray:SearchCrickArray_worldExp];
    [Tableview_Explore reloadData];
    }
    if ([cellChecking isEqualToString:@"FriendExp"])
    {
        [Array_FriendExp removeAllObjects];
        [Array_FriendExp addObjectsFromArray:SearchCrickArray_FriendExp];
         [Tableview_Explore reloadData];
    }

}
-(void)PulltoRefershtable1
{
    [self ClienserverComm_worldExp];
//    NSUInteger count = [Array_WorldExp count];
//    
//    
//    
//    [Array_WorldExp addObjectsFromArray:Array_WorldExp1];
//    
//    
//    NSMutableArray *insertIndexPaths = [NSMutableArray array];
//    for (NSUInteger item = count; item < Array_WorldExp.count; item++) {
//        
//        [insertIndexPaths addObject:[NSIndexPath indexPathForRow:item
//                                                       inSection:0]];
//    }
//    
//    [Tableview_Explore beginUpdates];
//    [Tableview_Explore insertRowsAtIndexPaths:insertIndexPaths
//                            withRowAnimation:UITableViewRowAnimationFade];
//    [Tableview_Explore endUpdates];
//    NSIndexPath* indexPath = [NSIndexPath indexPathForRow: ([Tableview_Explore numberOfRowsInSection:([Tableview_Explore numberOfSections]-1)]-1) inSection: ([Tableview_Explore numberOfSections]-1)];
//    [Tableview_Explore scrollToRowAtIndexPath:indexPath
//                            atScrollPosition:UITableViewScrollPositionNone
//                                    animated:YES];
//    
//    NSIndexPath *selected = [Tableview_Explore indexPathForSelectedRow];
//    if (selected) {
//        [Tableview_Explore deselectRowAtIndexPath:selected animated:YES];
//    }
    
}
@end
