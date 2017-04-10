//
//  WatchPageViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/10/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "WatchPageViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"

@interface WatchPageViewController ()
{
    NSMutableArray *Array_Watch;
    NSUserDefaults *defaults;
    NSDictionary *urlplist;
    
}
@end

@implementation WatchPageViewController
@synthesize Tableview_watch,cell_one;
- (void)viewDidLoad {
    [super viewDidLoad];
   //
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    [self ClienserverComm_watchView];
    
}
-(void)ClienserverComm_watchView
{
    [self.view endEditing:YES];
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"watch"];;
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
                                                     
    Array_Watch=[[NSMutableArray alloc]init];
    SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                
    Array_Watch =[objSBJsonParser objectWithData:data];
                                                     
    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                
                                                     
ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];

ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
NSLog(@"Array_Watch %@",Array_Watch);
                                                     
                                                     
NSLog(@"Array_WorldExp ResultString %@",ResultString);
    
if ([ResultString isEqualToString:@"nouserid"])
        {
                                                         
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            
        [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
            }
                                                     
                                                     
            if ([ResultString isEqualToString:@"done"])
                            {
                                                         
                                                         
                                                         
                                                         
                        }
                                               
                if (Array_Watch.count !=0)
                {
                    [Tableview_watch reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
  return Array_Watch.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdv1=@"CellWatch";
    

            cell_one = (WatchViewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdv1 forIndexPath:indexPath];
            
       //     NSURL *url=[NSURL URLWithString:str_profileurl];
            
//            [cell_two.ImageLeft_LeftProfile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            
    
    
    
//    friendstatus = "<null>";
//    name = "Mohit Sureka";
//    newstatus = yes;
//    posttime = "8m ago";
//    profileimage = "https://graph.facebook.com/10154323404982724/picture?type=large";
//    recorddate = "2017-04-10 09:15:44";
//    "registration_status" = ACTIVE;
//    status = "<null>";
//    thumbnailurl = "http://www.care2dareapp.com/app/recordedmedia/R20170306070111mGtlC20170410090900Z0FR-thumbnail.jpg";
//    totalviews = "<null>";
//    useridvideo = 20170306070111mGtl;
//    videourl = "http://www.care2dareapp.com/app/recordedmedia/R20170306070111mGtlC20170410090900Z0FR.mp4";
//    
//    
    
    
            return cell_one;
    
       
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
return 328;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}

@end
