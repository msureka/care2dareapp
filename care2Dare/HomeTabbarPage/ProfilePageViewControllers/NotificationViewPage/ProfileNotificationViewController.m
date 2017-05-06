//
//  ProfileNotificationViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/8/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ProfileNotificationViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
@interface ProfileNotificationViewController ()
{
    UIView *sectionView;
    NSString * SeachCondCheck,*CheckedTabbedButtons;
    CALayer*  borderBottom_challenges,*borderBottom_Contribution,*borderBottom_Vedios;
    NSUserDefaults * defaults;
    NSMutableArray * Array_AllData,*Array_Public,*Array_Private,*Array_IcomingPlg,*Array_OutgoingPlg,* Array_AllData_contribution,*Array_AllData_Videos;
    NSDictionary *urlplist;
    CALayer *Bottomborder_Cell2;
    NSString * ResultString_Challenges,*ResultString_Contribute,*ResultString_video;
    NSString *FlagSearchBar,*searchString,*flag_challenge,*flag_Contribute,*flag_Vedio;
    
    NSArray *SearchCrickArray_challenge,*SearchCrickArray_Contribute,*SearchCrickArray_vedio,*Array_Public1,*Array_Private1,*Array_IcomingPlg1,*Array_OutgoingPlg1;
}
@end

@implementation ProfileNotificationViewController

@synthesize cell_PublicNoti,cell_PrivateNoti,cell_VedioNoti,cell_PlegeOutNoti,cell_PlegeIncoNoti,Lable_Titlenotif,Button_Back,Button_Search,Textfield_Search,Tableview_Notif,view_Topheader,Button_Videos,Button_Challenges,Button_Contribution;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    Textfield_Search.hidden=YES;
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    SeachCondCheck=@"no";
    CheckedTabbedButtons=@"Challenges";
    Textfield_Search.delegate=self;
     borderBottom_challenges= [CALayer layer];
     borderBottom_Vedios = [CALayer layer];
    
    SearchCrickArray_challenge=[[NSArray alloc]init];
    SearchCrickArray_Contribute=[[NSArray alloc]init];
    SearchCrickArray_vedio=[[NSArray alloc]init];
    Array_Public1=[[NSArray alloc]init];
    Array_Private1=[[NSArray alloc]init];
    
    Array_IcomingPlg1=[[NSArray alloc]init];
    Array_OutgoingPlg1=[[NSArray alloc]init];
flag_challenge=@"no";
    flag_Contribute=@"no";
    flag_Vedio=@"no";
    if ([[defaults valueForKey:@"challengecount"] isEqualToString:@"0"])
    {
        _ImageRed_Challenges.hidden=YES;
    }
    else
    {
     _ImageRed_Challenges.hidden=NO;
    }
    if ([[defaults valueForKey:@"contributioncount"] isEqualToString:@"0"])
    {
        _ImageRed_Contribution.hidden=YES;
    }
    else
    {
        _ImageRed_Contribution.hidden=NO;
    }
    if ([[defaults valueForKey:@"videocount"] isEqualToString:@"0"])
    {
        _ImageRed_Videos.hidden=YES;
    }
    else
    {
        _ImageRed_Videos.hidden=NO;
    }
    
   

    
    [self ClienserverCommAll];
}
- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CALayer*  borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
    
    
    Textfield_Search.delegate=self;
    
    
  
    borderBottom_challenges.backgroundColor =[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1.0].CGColor;//[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_challenges.frame = CGRectMake(0, Button_Challenges.frame.size.height-2.5, Button_Challenges.frame.size.width,2.5);
    [Button_Challenges.layer addSublayer:borderBottom_challenges];
    
    borderBottom_Contribution = [CALayer layer];
    borderBottom_Contribution.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Contribution.frame = CGRectMake(0, Button_Contribution.frame.size.height-1, Button_Contribution.frame.size.width,1);
    [Button_Contribution.layer addSublayer:borderBottom_Contribution];
    
   
    borderBottom_Vedios.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Vedios.frame = CGRectMake(0, Button_Videos.frame.size.height-1, Button_Videos.frame.size.width,1);
    [Button_Videos.layer addSublayer:borderBottom_Vedios];
    
    [Button_Challenges setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [Button_Contribution setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Videos setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
}
-(void)ClienserverCommAll
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"checknotifications"];;
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
                                                     
                    Array_AllData=[[NSMutableArray alloc]init];
                SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                Array_AllData=[objSBJsonParser objectWithData:data];
                                                     
                     ResultString_Challenges=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        
                        ResultString_Challenges = [ResultString_Challenges stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                        ResultString_Challenges = [ResultString_Challenges stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                    NSLog(@"Array_AllData %@",Array_AllData);
                                                     
                                                     
                NSLog(@"Array_AllData ResultString %@",ResultString_Challenges);
                                                     
                                                     
                                                     
                    if (Array_AllData.count !=0)
                        {
                                                       
        Array_Public=[[NSMutableArray alloc]init];
        Array_Private=[[NSMutableArray alloc]init];
                for (int i=0; i<Array_AllData.count; i++)
                        {
            if ([[[Array_AllData objectAtIndex:i]valueForKey:@"challengetype"]isEqualToString:@"PUBLIC"])
                            {
                [Array_Public addObject:[Array_AllData objectAtIndex:i]];
                        }
                        else
                    {
            [Array_Private addObject:[Array_AllData objectAtIndex:i]];
                    }
                }
                   SearchCrickArray_challenge=[Array_AllData mutableCopy];
                    Array_Public1=[Array_Public mutableCopy];
                    Array_Private1=[Array_Private mutableCopy];
                
                       cell_PublicNoti.Lable_JsonResult.hidden=YES;
                            
                            flag_challenge=@"yes";
                          
                            
                    [Tableview_Notif reloadData];
                                                         
                    }
                else
                  {
                      cell_PublicNoti.Lable_JsonResult.hidden=NO;
                    
                }
                                                    
                                                     
                                                     
                                                     
               if ([ResultString_Challenges isEqualToString:@"nonotifications"])
                                {
                                    
                                    flag_challenge=@"yes";
                                    
                       [Tableview_Notif reloadData];
                  cell_PublicNoti.Lable_JsonResult.hidden=NO;
                     
                                                         
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
- (void)ClienserverComm_Contribution
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"checknotifications2"];;
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
                                                     
                    Array_AllData_contribution=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
            Array_AllData_contribution=[objSBJsonParser objectWithData:data];
                                                     
ResultString_Contribute=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
        ResultString_Contribute = [ResultString_Contribute stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     
        ResultString_Contribute = [ResultString_Contribute stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
     NSLog(@"Array_AllData_contribution %@",Array_AllData_contribution);
                                                     
                                                     
    NSLog(@"Array_AllData ResultString %@",ResultString_Contribute);
                                                     
                                                     
                                                     
            if (Array_AllData_contribution.count !=0)
                    {
                                                         
            Array_IcomingPlg=[[NSMutableArray alloc]init];
            Array_OutgoingPlg=[[NSMutableArray alloc]init];
                for (int i=0; i<Array_AllData_contribution.count; i++)
                            {
if ([[[Array_AllData_contribution objectAtIndex:i]valueForKey:@"contributiontype"]isEqualToString:@"both"])
                {
    [Array_IcomingPlg addObject:[Array_AllData_contribution objectAtIndex:i]];
    [Array_OutgoingPlg addObject:[Array_AllData_contribution objectAtIndex:i]];
                    }
                else
                {
                    if ([[[Array_AllData_contribution objectAtIndex:i]valueForKey:@"contributiontype"]isEqualToString:@"incoming"])
                    {
        [Array_IcomingPlg addObject:[Array_AllData_contribution objectAtIndex:i]];
                    }
                    else
                    {
                    
    [Array_OutgoingPlg addObject:[Array_AllData_contribution objectAtIndex:i]];
                    }
                }
            }
                                                         
        SearchCrickArray_Contribute=[Array_AllData_contribution mutableCopy];
        Array_IcomingPlg1=[Array_IcomingPlg mutableCopy];
        Array_OutgoingPlg1=[Array_OutgoingPlg mutableCopy];
                        
                      
                        flag_Contribute=@"yes";
                       
                        
        [Tableview_Notif reloadData];
                                                         
                                }
                            else
                            {
                   
                                                         
                            }
                                                     
                                                     
                                                     
                                                     
                    if ([ResultString_Contribute isEqualToString:@"nonotifications"])
                        {
                            flag_Contribute=@"yes";
                            [Tableview_Notif reloadData];
                            
                                                         
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
- (void)ClienserverComm_Vedios
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
        NSString *  urlStrLivecount=[urlplist valueForKey:@"checknotifications3"];;
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
                                                     
    Array_AllData_Videos=[[NSMutableArray alloc]init];
    SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
    Array_AllData_Videos=[objSBJsonParser objectWithData:data];
                                                     
         ResultString_video=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
        ResultString_video = [ResultString_video stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     
        ResultString_video = [ResultString_video stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
            NSLog(@"Array_AllData_Videos %@",Array_AllData_Videos);
                                                     
                                                     
                    NSLog(@"Array_AllData_Videos ResultString %@",ResultString_video);
                                                     
                                                     
                                                     
            if (Array_AllData_Videos.count !=0)
                            {
                                                         
             SearchCrickArray_vedio=[Array_AllData_Videos mutableCopy];
                                
                          
                                flag_Vedio=@"yes";
            [Tableview_Notif reloadData];
                                                         
                }
                else
                {
            
                                                         
            }
                                                     
                                                    
                                                     
        if ([ResultString_video isEqualToString:@"nonotifications"])
            {
         flag_Vedio=@"yes";
   [Tableview_Notif reloadData];
                                                         
                                                         
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
    
}

-(IBAction)ButtonBack_Action:(id)sender
{
     Textfield_Search.text=@"";
    if ([SeachCondCheck isEqualToString:@"yes"])
    {
        [Textfield_Search resignFirstResponder];
        Lable_Titlenotif.hidden=NO;
        Textfield_Search.hidden=YES;
        Button_Search.hidden=NO;
        SeachCondCheck=@"no";
        
        if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
        {
           [Array_Public removeAllObjects];
            [Array_Private removeAllObjects];
            [Array_AllData removeAllObjects];
            [Array_Public addObjectsFromArray:Array_Public1];
            [Array_Private addObjectsFromArray:Array_Private1];
            [Array_AllData addObjectsFromArray:SearchCrickArray_challenge];
                
                
            }
        if([CheckedTabbedButtons isEqualToString:@"Contribution"])
        {
                
        [Array_IcomingPlg removeAllObjects];
        [Array_OutgoingPlg removeAllObjects];
        [Array_AllData_contribution removeAllObjects];
        [Array_IcomingPlg addObjectsFromArray:Array_IcomingPlg1];
        [Array_OutgoingPlg addObjectsFromArray:Array_OutgoingPlg1];
        [Array_AllData_contribution addObjectsFromArray:SearchCrickArray_Contribute];
            
        }
        
        if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
        {
            
            
        [Array_AllData_Videos removeAllObjects];
                
        [Array_AllData_Videos addObjectsFromArray:SearchCrickArray_vedio];
                
                
            }
        [Tableview_Notif reloadData];

    }
    else
    {
        [Textfield_Search resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(IBAction)ButtonSearch_Action:(id)sender
{
    [Textfield_Search becomeFirstResponder];
    SeachCondCheck=@"yes";
    Lable_Titlenotif.hidden=YES;
    Textfield_Search.hidden=NO;
    Button_Search.hidden=YES;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
        
        if (Array_AllData.count==0)
        {
           
            if(section==0)
            {
                if ([flag_challenge isEqualToString:@"no"])
                {
                     return 0;
                }
                else
                {
                     return 1;
                }
           

            }
            if(section==1)
            {
                
                
                return 0;
                
            }
          
        }
        else
        {
            if(section==0)
            {
                
                return Array_Public.count;
                
                
            }
            if(section==1)
            {
                
                
                return Array_Private.count;
                
            }
        }
    }
    if ([CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
        
        if (Array_AllData_contribution.count==0)
        {
            if(section==0)
            {
                
                if ([flag_Contribute isEqualToString:@"no"])
                {
                    return 0;
                }
                else
                {
                    return 1;
                }

                
            }
            if(section==1)
            {
                
                
                return 0;
                
            }
        }
        else
        {
            if(section==0)
            {
                
                
                return Array_IcomingPlg.count;
                
                
            }
            if(section==1)
            {
                
                
                return Array_OutgoingPlg.count;
                
            }
        }
    }
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        if (Array_AllData_Videos.count==0)
        {
            if ([flag_Vedio isEqualToString:@"no"])
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
    return Array_AllData_Videos.count;
        }
    }
    
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *mycellid2=@"CellPublic";
    static NSString *cellId2=@"CellPrivate";
    
    static NSString *mycellid33=@"CellPI";
    static NSString *mycellid44=@"CellPO";
    
    static NSString *mycellid55=@"CellV";

    
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
        
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            
            cell_PublicNoti = (PublicChallengesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:mycellid2 forIndexPath:indexPath];
            
            if (Array_Public.count-1==indexPath.row)
            {
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor clearColor].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_PublicNoti.frame.size.height-1, cell_PublicNoti.frame.size.width, 1);
                [cell_PublicNoti.layer addSublayer:Bottomborder_Cell2];
            }
            else
            {
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_PublicNoti.frame.size.height-1, cell_PublicNoti.frame.size.width, 1);
                [cell_PublicNoti.layer addSublayer:Bottomborder_Cell2];
            }
           
            if ([ResultString_Challenges isEqualToString:@"nonotifications"] || Array_Public.count==0)
            {

                cell_PublicNoti.Lable_JsonResult.hidden=NO;
                cell_PublicNoti.Label_Name.hidden=YES;
                cell_PublicNoti.image_Redmsg.hidden=YES;
                cell_PublicNoti.image_profile.hidden=YES;
                cell_PublicNoti.image_profile2.hidden=YES;
                
            }
            else
            {
           
                cell_PublicNoti.Label_Name.hidden=NO;
                cell_PublicNoti.image_Redmsg.hidden=NO;
                cell_PublicNoti.image_profile.hidden=NO;
                cell_PublicNoti.image_profile2.hidden=NO;
                cell_PublicNoti.Lable_JsonResult.hidden=YES;
            NSDictionary * dic_Values=[Array_Public objectAtIndex:indexPath.row];
            
            
 
            
            if ([[dic_Values valueForKey:@"msgread"]isEqualToString:@"no"])
            {
                cell_PublicNoti.image_Redmsg.hidden=NO;
            }
            else
            {
                cell_PublicNoti.image_Redmsg.hidden=YES;
            }
            
            

            
            
            
            
            
            
        NSURL *url,*url1;
            url=[NSURL URLWithString:[dic_Values valueForKey:@"challengeurl"]];
             url1=[NSURL URLWithString:[dic_Values valueForKey:@"byprofileimageurl"]];
            
            cell_PublicNoti.image_profile.clipsToBounds=YES;
            cell_PublicNoti.image_profile2.clipsToBounds=YES;
           
            
if ([[dic_Values valueForKey:@"notificationtype"]isEqualToString:@"newchallenge"])
        {
            [cell_PublicNoti.image_profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
              [cell_PublicNoti.image_profile2 sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            cell_PublicNoti.image_profile.layer.cornerRadius=9.0f;
            cell_PublicNoti.image_profile2.layer.cornerRadius=cell_PublicNoti.image_profile2.frame.size.height/2;
            
            
            
            
            
            UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"New challenge" attributes: arialDict];
            
            UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:18.0];
            NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
            NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: @" received from " attributes:verdanaDict];
            
            
            UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
            NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
            NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_Values valueForKey:@"byname"] attributes:verdanaDict2];
            
            [aAttrString appendAttributedString:vAttrString];
            [aAttrString appendAttributedString:cAttrString];
            
            NSString *myString =[NSString stringWithFormat:@"%@%@%@",@"New challenge",@" from received ",[dic_Values valueForKey:@"byname"]];
            
            NSRange range = [myString rangeOfString:@"New challenge"];
            [aAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1.0] range:range];
            
            cell_PublicNoti.Label_Name.attributedText = aAttrString;
            
            
            
            CGRect textRect = [cell_PublicNoti.Label_Name.text boundingRectWithSize:cell_PublicNoti.Label_Name.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_PublicNoti.Label_Name.font} context:nil];
            
            int numberOfLines = textRect.size.height / cell_PublicNoti.Label_Name.font.pointSize;;
            if (numberOfLines==1)
            {
                [cell_PublicNoti.Label_Name setFrame:CGRectMake(cell_PublicNoti.Label_Name.frame.origin.x, cell_PublicNoti.Label_Name.frame.origin.y, cell_PublicNoti.Label_Name.frame.size.width, cell_PublicNoti.Label_Name.frame.size.height*2)];
            }

            
            
        }
        else
        {
            [cell_PublicNoti.image_profile sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            [cell_PublicNoti.image_profile2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            
            cell_PublicNoti.image_profile.layer.cornerRadius=cell_PublicNoti.image_profile.frame.size.height/2;
            cell_PublicNoti.image_profile2.layer.cornerRadius=9.0f;
            NSString * Str_Notitype;
            UIColor *blue_color;
    if ([[dic_Values valueForKey:@"notificationtype"]isEqualToString:@"accepted"])
            {
              Str_Notitype=@"Accepted";
                blue_color=[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0];
            }
            else
            {
                 Str_Notitype=@"Denied";
                blue_color=[UIColor colorWithRed:234/255.0 green:36/255.0 blue:39/255.0 alpha:1];
            }
            
            UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
            NSString * str_name=[NSString stringWithFormat:@"%@%@",[dic_Values valueForKey:@"byname"],@" "];
            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:str_name attributes: arialDict];
            
            UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
            NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
            NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:Str_Notitype attributes:verdanaDict];
            
            
            UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:18.0];
            NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
            NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:@" your challenge" attributes:verdanaDict2];
            
            [aAttrString appendAttributedString:vAttrString];
            [aAttrString appendAttributedString:cAttrString];
            
            NSString *myString =[NSString stringWithFormat:@"%@%@%@",str_name,Str_Notitype,@" your challenge"];
            
            NSRange range = [myString rangeOfString:Str_Notitype];
            [aAttrString addAttribute:NSForegroundColorAttributeName value:blue_color range:range];
            
            cell_PublicNoti.Label_Name.attributedText = aAttrString;
            
            
            
            CGRect textRect = [cell_PublicNoti.Label_Name.text boundingRectWithSize:cell_PublicNoti.Label_Name.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_PublicNoti.Label_Name.font} context:nil];
            
            int numberOfLines = textRect.size.height / cell_PublicNoti.Label_Name.font.pointSize;;
            if (numberOfLines==1)
            {
                [cell_PublicNoti.Label_Name setFrame:CGRectMake(cell_PublicNoti.Label_Name.frame.origin.x, cell_PublicNoti.Label_Name.frame.origin.y, cell_PublicNoti.Label_Name.frame.size.width, cell_PublicNoti.Label_Name.frame.size.height*2)];
            }
    
            
            
            
            
        }
            
            }
            
            return cell_PublicNoti;
            
            
        }
            break;
        case 1:
            
        {
            
            cell_PrivateNoti =(PrivateChallengesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
            
            if (Array_Private.count-1==indexPath.row)
            {
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor clearColor].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_PrivateNoti.frame.size.height-1, cell_PrivateNoti.frame.size.width, 1);
                [cell_PrivateNoti.layer addSublayer:Bottomborder_Cell2];
            }
            else
            {
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_PrivateNoti.frame.size.height-1, cell_PrivateNoti.frame.size.width, 1);
                [cell_PrivateNoti.layer addSublayer:Bottomborder_Cell2];
            }
           
            
            NSDictionary * dic_Values=[Array_Private objectAtIndex:indexPath.row];
            
            
            if ([[dic_Values valueForKey:@"msgread"]isEqualToString:@"no"])
            {
                cell_PrivateNoti.image_Redmsg.hidden=NO;
            }
            else
            {
                cell_PrivateNoti.image_Redmsg.hidden=YES;
            }
            
            

            
            NSURL *url,*url1;
            url=[NSURL URLWithString:[dic_Values valueForKey:@"challengeurl"]];
            url1=[NSURL URLWithString:[dic_Values valueForKey:@"byprofileimageurl"]];
            
            cell_PrivateNoti.image_profile.clipsToBounds=YES;
            cell_PrivateNoti.image_profile2.clipsToBounds=YES;
            
            
            if ([[dic_Values valueForKey:@"notificationtype"]isEqualToString:@"newchallenge"])
            {
                [cell_PrivateNoti.image_profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                [cell_PrivateNoti.image_profile2 sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                cell_PrivateNoti.image_profile.layer.cornerRadius=9.0f;
                cell_PrivateNoti.image_profile2.layer.cornerRadius=cell_PrivateNoti.image_profile2.frame.size.height/2;
                
                
                
                
                
                UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"New challenge" attributes: arialDict];
                
                UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:18.0];
                NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
                NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: @" received from " attributes:verdanaDict];
                
                
                UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
                NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
                NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_Values valueForKey:@"byname"] attributes:verdanaDict2];
                
                [aAttrString appendAttributedString:vAttrString];
                [aAttrString appendAttributedString:cAttrString];
                
                NSString *myString =[NSString stringWithFormat:@"%@%@%@",@"New challenge",@" from received ",[dic_Values valueForKey:@"byname"]];
                
                NSRange range = [myString rangeOfString:@"New challenge"];
                [aAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1.0] range:range];
                
                cell_PrivateNoti.Label_Name.attributedText = aAttrString;
                
                
                
                CGRect textRect = [cell_PrivateNoti.Label_Name.text boundingRectWithSize:cell_PrivateNoti.Label_Name.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_PrivateNoti.Label_Name.font} context:nil];
                
                int numberOfLines = textRect.size.height / cell_PrivateNoti.Label_Name.font.pointSize;;
                if (numberOfLines==1)
                {
                    [cell_PrivateNoti.Label_Name setFrame:CGRectMake(cell_PrivateNoti.Label_Name.frame.origin.x, cell_PrivateNoti.Label_Name.frame.origin.y, cell_PrivateNoti.Label_Name.frame.size.width, cell_PrivateNoti.Label_Name.frame.size.height*2)];
                }
                
                
                
            }
            else
            {
                [cell_PrivateNoti.image_profile sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                [cell_PrivateNoti.image_profile2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                
                cell_PrivateNoti.image_profile.layer.cornerRadius=cell_PrivateNoti.image_profile.frame.size.height/2;
                cell_PrivateNoti.image_profile2.layer.cornerRadius=9.0f;
                NSString * Str_Notitype;
                UIColor *blue_color;
                if ([[dic_Values valueForKey:@"notificationtype"]isEqualToString:@"accepted"])
                {
                    Str_Notitype=@"Accepted";
                    blue_color=[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0];
                }
                else
                {
                    Str_Notitype=@"Denied";
                    blue_color=[UIColor colorWithRed:234/255.0 green:36/255.0 blue:39/255.0 alpha:1];
                }
                
                UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
                NSString * str_name=[NSString stringWithFormat:@"%@%@",[dic_Values valueForKey:@"byname"],@" "];
                NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:str_name attributes: arialDict];
                
                UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
                NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
                NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:Str_Notitype attributes:verdanaDict];
                
                
                UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:18.0];
                NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
                NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:@" your challenge" attributes:verdanaDict2];
                
                [aAttrString appendAttributedString:vAttrString];
                [aAttrString appendAttributedString:cAttrString];
                
                NSString *myString =[NSString stringWithFormat:@"%@%@%@",str_name,Str_Notitype,@" your challenge"];
                
                NSRange range = [myString rangeOfString:Str_Notitype];
                [aAttrString addAttribute:NSForegroundColorAttributeName value:blue_color range:range];
                
                cell_PrivateNoti.Label_Name.attributedText = aAttrString;
                
                
                
                CGRect textRect = [cell_PrivateNoti.Label_Name.text boundingRectWithSize:cell_PrivateNoti.Label_Name.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_PrivateNoti.Label_Name.font} context:nil];
                
                int numberOfLines = textRect.size.height / cell_PrivateNoti.Label_Name.font.pointSize;;
                if (numberOfLines==1)
                {
                    [cell_PrivateNoti.Label_Name setFrame:CGRectMake(cell_PrivateNoti.Label_Name.frame.origin.x, cell_PrivateNoti.Label_Name.frame.origin.y, cell_PrivateNoti.Label_Name.frame.size.width, cell_PrivateNoti.Label_Name.frame.size.height*2)];
                }
                
                
                
                
                
            }
            

            
            
            
            return cell_PrivateNoti;
            
            
            
            
            
        }
            
            break;
    }
    }

if([CheckedTabbedButtons isEqualToString:@"Contribution"])
{
    switch (indexPath.section)
    {
            
        case 0:
        {
            
            cell_PlegeIncoNoti = [[[NSBundle mainBundle]loadNibNamed:@"PlegeIncomingTableViewCell" owner:self options:nil] objectAtIndex:0];

            
            if (cell_PlegeIncoNoti == nil)
            {
                
                cell_PlegeIncoNoti = [[PlegeIncomingTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid33];
                
                
            }
            if (Array_IcomingPlg.count-1==indexPath.row)
            {
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor clearColor].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_PlegeIncoNoti.frame.size.height-1, cell_PublicNoti.frame.size.width, 1);
                [cell_PlegeIncoNoti.layer addSublayer:Bottomborder_Cell2];
            }
            else
            {
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_PlegeIncoNoti.frame.size.height-1, cell_PublicNoti.frame.size.width, 1);
                [cell_PlegeIncoNoti.layer addSublayer:Bottomborder_Cell2];
            }
            
          
            
            if ([ResultString_Contribute isEqualToString:@"nonotifications"] || Array_IcomingPlg.count==0)
            {
                
                cell_PlegeIncoNoti.Lable_JsonResult.hidden=NO;
                cell_PlegeIncoNoti.Label_Name.hidden=YES;
                cell_PlegeIncoNoti.image_Redmsg.hidden=YES;
                cell_PlegeIncoNoti.image_profile.hidden=YES;
                cell_PlegeIncoNoti.image_profile2.hidden=YES;
                
            }
            else
            {
                
                cell_PlegeIncoNoti.Label_Name.hidden=NO;
                cell_PlegeIncoNoti.image_Redmsg.hidden=NO;
                cell_PlegeIncoNoti.image_profile.hidden=NO;
                cell_PlegeIncoNoti.image_profile2.hidden=NO;
                cell_PlegeIncoNoti.Lable_JsonResult.hidden=YES;
            
            
            NSDictionary * dic_Values=[Array_IcomingPlg objectAtIndex:indexPath.row];
            
            if ([[dic_Values valueForKey:@"msgread"]isEqualToString:@"no"])
            {
                cell_PlegeIncoNoti.image_Redmsg.hidden=NO;
            }
            else
            {
                cell_PlegeIncoNoti.image_Redmsg.hidden=YES;
            }

            
            
            
            
            NSURL *url,*url1;
            url=[NSURL URLWithString:[dic_Values valueForKey:@"challengeurl"]];
            url1=[NSURL URLWithString:[dic_Values valueForKey:@"byprofileimageurl"]];
            
            cell_PlegeIncoNoti.image_profile.clipsToBounds=YES;
            cell_PlegeIncoNoti.image_profile2.clipsToBounds=YES;
            
            
          
                [cell_PlegeIncoNoti.image_profile sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                [cell_PlegeIncoNoti.image_profile2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                
                cell_PlegeIncoNoti.image_profile.layer.cornerRadius=cell_PlegeIncoNoti.image_profile.frame.size.height/2;
                cell_PlegeIncoNoti.image_profile2.layer.cornerRadius=9.0f;
                
            
            
            
            UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
            NSString * str_Name=[NSString stringWithFormat:@"%@%@",[dic_Values valueForKey:@"byname"],@" "];
            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:str_Name attributes: arialDict];
            
            UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
            NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
            NSString * str_ConTotal=[NSString stringWithFormat:@"%@%@%@",@"contributed",@" $",[dic_Values valueForKey:@"totalamount"]];
            
            NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:str_ConTotal attributes:verdanaDict];
            
            
            UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:18.0];
            NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
            NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:@" to your challenge" attributes:verdanaDict2];
            
            [aAttrString appendAttributedString:vAttrString];
            [aAttrString appendAttributedString:cAttrString];
            
            NSString *myString =[NSString stringWithFormat:@"%@%@%@",str_Name,str_ConTotal,@" to your challenge"];
            
            NSRange range = [myString rangeOfString:str_ConTotal];
            [aAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1.0] range:range];
            
            cell_PlegeIncoNoti.Label_Name.attributedText = aAttrString;
            
            
            
            CGRect textRect = [cell_PlegeIncoNoti.Label_Name.text boundingRectWithSize:cell_PlegeIncoNoti.Label_Name.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_PlegeIncoNoti.Label_Name.font} context:nil];
            
            int numberOfLines = textRect.size.height / cell_PlegeIncoNoti.Label_Name.font.pointSize;;
            if (numberOfLines==1)
            {
                [cell_PlegeIncoNoti.Label_Name setFrame:CGRectMake(cell_PlegeIncoNoti.Label_Name.frame.origin.x, cell_PlegeIncoNoti.Label_Name.frame.origin.y, cell_PlegeIncoNoti.Label_Name.frame.size.width, cell_PlegeIncoNoti.Label_Name.frame.size.height*2)];
            }
            }
            
            return cell_PlegeIncoNoti;
            
            
        }
            break;
        case 1:
            
        {
            
            cell_PlegeOutNoti = [[[NSBundle mainBundle]loadNibNamed:@"PledgeOutoingTableViewCell" owner:self options:nil] objectAtIndex:0];
            
            if (cell_PlegeOutNoti == nil)
            {
                
                cell_PlegeOutNoti = [[PledgeOutoingTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid44];
                
                
            }

            
            if (Array_OutgoingPlg.count-1==indexPath.row)
            {
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor clearColor].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_PlegeOutNoti.frame.size.height-1, cell_PlegeOutNoti.frame.size.width, 1);
                [cell_PlegeOutNoti.layer addSublayer:Bottomborder_Cell2];
            }
            else
            {
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_PlegeOutNoti.frame.size.height-1, cell_PlegeOutNoti.frame.size.width, 1);
                [cell_PlegeOutNoti.layer addSublayer:Bottomborder_Cell2];
            }
            
            
            NSDictionary * dic_Values=[Array_OutgoingPlg objectAtIndex:indexPath.row];
            
            if ([[dic_Values valueForKey:@"msgread"]isEqualToString:@"no"])
            {
                cell_PlegeOutNoti.image_Redmsg.hidden=NO;
            }
            else
            {
                cell_PlegeOutNoti.image_Redmsg.hidden=YES;
            }

            
            NSURL *url,*url1;
            url=[NSURL URLWithString:[dic_Values valueForKey:@"challengeurl"]];
            url1=[NSURL URLWithString:[dic_Values valueForKey:@"byprofileimageurl"]];
            
            cell_PlegeOutNoti.image_profile.clipsToBounds=YES;
            cell_PlegeOutNoti.image_profile2.clipsToBounds=YES;
            
            
            [cell_PlegeOutNoti.image_profile sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            [cell_PlegeOutNoti.image_profile2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            
            cell_PlegeOutNoti.image_profile.layer.cornerRadius=cell_PlegeOutNoti.image_profile.frame.size.height/2;
            cell_PlegeOutNoti.image_profile2.layer.cornerRadius=9.0f;
            
            
            
            
            UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
            NSString * str_Name=[NSString stringWithFormat:@"%@%@",@"You",@" "];
            NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:str_Name attributes: arialDict];
            
            UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
            NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
            NSString * str_ConTotal=[NSString stringWithFormat:@"%@%@%@",@"contributed",@" $",[dic_Values valueForKey:@"totalamount"]];
            
            NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:str_ConTotal attributes:verdanaDict];
            
            
            UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:18.0];
            NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
            NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:@" to a challenge" attributes:verdanaDict2];
            
            [aAttrString appendAttributedString:vAttrString];
            [aAttrString appendAttributedString:cAttrString];
            
            NSString *myString =[NSString stringWithFormat:@"%@%@%@",str_Name,str_ConTotal,@" to a challenge"];
            
            NSRange range = [myString rangeOfString:str_ConTotal];
            [aAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1.0] range:range];
            
            cell_PlegeOutNoti.Label_Name.attributedText = aAttrString;
            
            
            
            CGRect textRect = [cell_PlegeOutNoti.Label_Name.text boundingRectWithSize:cell_PlegeOutNoti.Label_Name.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_PlegeOutNoti.Label_Name.font} context:nil];
            
            int numberOfLines = textRect.size.height / cell_PlegeOutNoti.Label_Name.font.pointSize;;
            if (numberOfLines==1)
            {
                [cell_PlegeOutNoti.Label_Name setFrame:CGRectMake(cell_PlegeOutNoti.Label_Name.frame.origin.x, cell_PlegeOutNoti.Label_Name.frame.origin.y, cell_PlegeOutNoti.Label_Name.frame.size.width, cell_PlegeOutNoti.Label_Name.frame.size.height*2)];
            }

            
            
                
            
            

            
            
            return cell_PlegeOutNoti;

            
            
        }
            
            break;
    }
    }

if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
{
    cell_VedioNoti = [[[NSBundle mainBundle]loadNibNamed:@"VedioNotiTableViewCell" owner:self options:nil] objectAtIndex:0];
    
    if (cell_VedioNoti == nil)
    {
        
    cell_VedioNoti = [[VedioNotiTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid55];
        
        
    }
//    byname = "Er Sachin Mokashi";
//    byprofileimageurl = "https://graph.facebook.com/1280357812049167/picture?type=large";
//    byuserid = 20170307091520wFL3;
//    challengeid = C201704041224052UE9;
//    msgread = no;
//    videothumbnailurl = "http://www.care2dareapp.com/app/recordedmedia/R20170307091520wFL3C201704041224052UE9-thumbnail.jpg";
//
    
    
    
    if (Array_AllData_Videos.count-1==indexPath.row)
    {
        Bottomborder_Cell2 = [CALayer layer];
        Bottomborder_Cell2.backgroundColor = [UIColor clearColor].CGColor;
        Bottomborder_Cell2.frame = CGRectMake(0, cell_VedioNoti.frame.size.height-1, cell_VedioNoti.frame.size.width, 1);
        [cell_VedioNoti.layer addSublayer:Bottomborder_Cell2];
    }
    else
    {
        Bottomborder_Cell2 = [CALayer layer];
        Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        Bottomborder_Cell2.frame = CGRectMake(0, cell_VedioNoti.frame.size.height-1, cell_VedioNoti.frame.size.width, 1);
        [cell_VedioNoti.layer addSublayer:Bottomborder_Cell2];
    }
    if ([ResultString_video isEqualToString:@"nonotifications"] || Array_AllData_Videos.count==0)
    {
        
        cell_VedioNoti.Lable_JsonResult.hidden=NO;
        cell_VedioNoti.Label_Name.hidden=YES;
        cell_VedioNoti.image_Redmsg.hidden=YES;
        cell_VedioNoti.image_profile.hidden=YES;
        cell_VedioNoti.image_profile2.hidden=YES;
        
    }
    else
    {
        
        cell_VedioNoti.Label_Name.hidden=NO;
        cell_VedioNoti.image_Redmsg.hidden=NO;
        cell_VedioNoti.image_profile.hidden=NO;
        cell_VedioNoti.image_profile2.hidden=NO;
        cell_VedioNoti.Lable_JsonResult.hidden=YES;
    
    NSDictionary * dic_Values=[Array_AllData_Videos objectAtIndex:indexPath.row];
    if ([[dic_Values valueForKey:@"msgread"]isEqualToString:@"no"])
    {
        cell_VedioNoti.image_Redmsg.hidden=NO;
    }
    else
    {
      cell_VedioNoti.image_Redmsg.hidden=YES;
    }
  
    
    NSURL *url,*url1;
    url=[NSURL URLWithString:[dic_Values valueForKey:@"videothumbnailurl"]];
    url1=[NSURL URLWithString:[dic_Values valueForKey:@"byprofileimageurl"]];
    
    cell_VedioNoti.image_profile.clipsToBounds=YES;
    cell_VedioNoti.image_profile2.clipsToBounds=YES;
    
    
    [cell_VedioNoti.image_profile sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
    [cell_VedioNoti.image_profile2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
    
    cell_VedioNoti.image_profile.layer.cornerRadius=cell_VedioNoti.image_profile.frame.size.height/2;
    cell_VedioNoti.image_profile2.layer.cornerRadius=9.0f;
    
    
    
    
    UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
    NSString * str_Name=[dic_Values valueForKey:@"byname"];
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:str_Name attributes: arialDict];
    
    UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:18.0];
    NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
    NSString * str_ConTotal=@" Recorded a ";
    
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:str_ConTotal attributes:verdanaDict];
    
    
    UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:18.0];
    NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
    NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString:@"new video" attributes:verdanaDict2];
    
    [aAttrString appendAttributedString:vAttrString];
    [aAttrString appendAttributedString:cAttrString];
    
    NSString *myString =[NSString stringWithFormat:@"%@%@%@",str_Name,str_ConTotal,@"new video"];
    
    NSRange range = [myString rangeOfString:@"new video"];
    [aAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1.0] range:range];
    
    cell_VedioNoti.Label_Name.attributedText = aAttrString;
    
    
    
    CGRect textRect = [cell_VedioNoti.Label_Name.text boundingRectWithSize:cell_VedioNoti.Label_Name.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_VedioNoti.Label_Name.font} context:nil];
    
    int numberOfLines = textRect.size.height / cell_VedioNoti.Label_Name.font.pointSize;;
    if (numberOfLines==1)
    {
        [cell_VedioNoti.Label_Name setFrame:CGRectMake(cell_VedioNoti.Label_Name.frame.origin.x, cell_VedioNoti.Label_Name.frame.origin.y, cell_VedioNoti.Label_Name.frame.size.width, cell_VedioNoti.Label_Name.frame.size.height*2)];
    }
    
    }
    
      return cell_VedioNoti;
    
    
}
    return nil;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"] ||[CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
      return 2;
    }
    
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        
        return 1;
        
    }
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor whiteColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"New Videos";
        [sectionView addSubview:Label1];
        
        CALayer*  borderBottom_topheder = [CALayer layer];
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        [sectionView.layer addSublayer:borderBottom_topheder];
        
        sectionView.tag=section;
        
    }
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"] || [CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
        
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor whiteColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
        {
         Label1.text=@"Public Challenges";
        }
        if ([CheckedTabbedButtons isEqualToString:@"Contribution"])
        {
           Label1.text=@"Pledges (Incoming)";
        }
        
        [sectionView addSubview:Label1];
        
        CALayer*  borderBottom_topheder = [CALayer layer];
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        [sectionView.layer addSublayer:borderBottom_topheder];
        
        sectionView.tag=section;
        
    }
    if (section==1)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor whiteColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
        {
             Label1.text=@"Private Challenges";
        }
        if ([CheckedTabbedButtons isEqualToString:@"Contribution"])
        {
            Label1.text=@"Pledges (Outgoing)";
        }
       
        [sectionView addSubview:Label1];
        
        CALayer*  borderBottom_topheder = [CALayer layer];
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        [sectionView.layer addSublayer:borderBottom_topheder];
        
        sectionView.tag=section;
        
    }
    }
    return  sectionView;
    
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
        if(section==0)
        {
            if (Array_Public.count==0)
            {
                return 0;
            }
            else
            {
                return 44;
            }
            
        }
        if(section==1)
        {
            if (Array_Private.count==0)
            {
                return 0;
            }
            else
            {
                return 44;
            }
            
        }
        
    }
    if ([CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
        if(section==0)
        {
            if (Array_IcomingPlg.count==0)
            {
                return 0;
            }
            else
            {
                
                return 44;
            }
            
        }
        if(section==1)
        {
            if (Array_OutgoingPlg.count==0)
            {
                return 0;
            }
            else
            {
                return 44;
            }
            
        }
    }
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        if (Array_AllData_Videos.count==0)
        {
            return 0;
        }
        else
        {
            return 44;
        }

    
        
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
      return 80;
    }
    if([CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
        return 80;
    }
    
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {

    return 80;
    }
    
    return 0;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
        
    }
    if([CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
 
    }
    
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        
        
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [Textfield_Search resignFirstResponder];
    return YES;
}
-(IBAction)ButtonChallenges_Action:(id)sender
{
    
    CheckedTabbedButtons=@"Challenges";
   Textfield_Search.text=@"";
    searchString=@"";
    [Button_Challenges setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [Button_Contribution setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Videos setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    
   // borderBottom_challenges= [CALayer layer];
    borderBottom_challenges.backgroundColor =[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1.0].CGColor;//[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_challenges.frame = CGRectMake(0, Button_Challenges.frame.size.height-2.5, Button_Challenges.frame.size.width,2.5);
    [Button_Challenges.layer addSublayer:borderBottom_challenges];
    
    //borderBottom_Contribution = [CALayer layer];
    borderBottom_Contribution.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Contribution.frame = CGRectMake(0, Button_Contribution.frame.size.height-1, Button_Contribution.frame.size.width,1);
    [Button_Contribution.layer addSublayer:borderBottom_Contribution];
    
   // borderBottom_Vedios = [CALayer layer];
    borderBottom_Vedios.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Vedios.frame = CGRectMake(0, Button_Videos.frame.size.height-1, Button_Videos.frame.size.width,1);
    [Button_Videos.layer addSublayer:borderBottom_Vedios];
    if ([[defaults valueForKey:@"challengecount"] isEqualToString:@"0"])
    {
        _ImageRed_Challenges.hidden=YES;
    }
    else
    {
        _ImageRed_Challenges.hidden=NO;
    }
    if ([[defaults valueForKey:@"contributioncount"] isEqualToString:@"0"])
    {
        _ImageRed_Contribution.hidden=YES;
    }
    else
    {
        _ImageRed_Contribution.hidden=NO;
    }
    if ([[defaults valueForKey:@"videocount"] isEqualToString:@"0"])
    {
        _ImageRed_Videos.hidden=YES;
    }
    else
    {
        _ImageRed_Videos.hidden=NO;
    }
    [defaults setObject:@"0" forKey:@"challengecount"];
    [defaults synchronize];
    [self ClienserverCommAll];
    [Tableview_Notif reloadData];
    
}
-(IBAction)ButtonContribution_Action:(id)sender
{
        CheckedTabbedButtons=@"Contribution";
     Textfield_Search.text=@"";
 searchString=@"";
    [Button_Contribution setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [Button_Challenges setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Videos setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    
    
   // borderBottom_challenges= [CALayer layer];
    borderBottom_challenges.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_challenges.frame = CGRectMake(0, Button_Challenges.frame.size.height-1, Button_Challenges.frame.size.width,1);
    [Button_Challenges.layer addSublayer:borderBottom_challenges];
    
   // borderBottom_Contribution = [CALayer layer];
    borderBottom_Contribution.backgroundColor =[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1.0].CGColor;//[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_Contribution.frame = CGRectMake(0, Button_Contribution.frame.size.height-2.5, Button_Contribution.frame.size.width,2.5);
    [Button_Contribution.layer addSublayer:borderBottom_Contribution];
    
  //  borderBottom_Vedios = [CALayer layer];
    borderBottom_Vedios.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Vedios.frame = CGRectMake(0, Button_Videos.frame.size.height-1, Button_Videos.frame.size.width,1);
    [Button_Videos.layer addSublayer:borderBottom_Vedios];
    
    if ([[defaults valueForKey:@"challengecount"] isEqualToString:@"0"])
    {
        _ImageRed_Challenges.hidden=YES;
    }
    else
    {
        _ImageRed_Challenges.hidden=NO;
    }
    if ([[defaults valueForKey:@"contributioncount"] isEqualToString:@"0"])
    {
        _ImageRed_Contribution.hidden=YES;
    }
    else
    {
        _ImageRed_Contribution.hidden=NO;
    }
    if ([[defaults valueForKey:@"videocount"] isEqualToString:@"0"])
    {
        _ImageRed_Videos.hidden=YES;
    }
    else
    {
        _ImageRed_Videos.hidden=NO;
    }

    [defaults setObject:@"0" forKey:@"contributioncount"];
    [defaults synchronize];
    
    [self ClienserverComm_Contribution];
      [Tableview_Notif reloadData];
}
-(IBAction)ButtonVedio_Action:(id)sender
{
    
  CheckedTabbedButtons=@"Vedio";
    searchString=@"";
     Textfield_Search.text=@"";
    [Button_Videos setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [Button_Contribution setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Challenges setTitleColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] forState:UIControlStateNormal];
    
    //borderBottom_challenges= [CALayer layer];
    borderBottom_challenges.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_challenges.frame = CGRectMake(0, Button_Challenges.frame.size.height-1, Button_Challenges.frame.size.width,1);
    [Button_Challenges.layer addSublayer:borderBottom_challenges];
    
  //  borderBottom_Contribution = [CALayer layer];
    borderBottom_Contribution.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    borderBottom_Contribution.frame = CGRectMake(0, Button_Contribution.frame.size.height-1, Button_Contribution.frame.size.width,1);
    [Button_Contribution.layer addSublayer:borderBottom_Contribution];
    
   // borderBottom_Vedios = [CALayer layer];
    borderBottom_Vedios.backgroundColor =[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1.0].CGColor;//[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1.0].CGColor;
    borderBottom_Vedios.frame = CGRectMake(0, Button_Videos.frame.size.height-2.5, Button_Videos.frame.size.width,2.5);
    [Button_Videos.layer addSublayer:borderBottom_Vedios];
    if ([[defaults valueForKey:@"challengecount"] isEqualToString:@"0"])
    {
        _ImageRed_Challenges.hidden=YES;
    }
    else
    {
        _ImageRed_Challenges.hidden=NO;
    }
    if ([[defaults valueForKey:@"contributioncount"] isEqualToString:@"0"])
    {
        _ImageRed_Contribution.hidden=YES;
    }
    else
    {
        _ImageRed_Contribution.hidden=NO;
    }
    if ([[defaults valueForKey:@"videocount"] isEqualToString:@"0"])
    {
        _ImageRed_Videos.hidden=YES;
    }
    else
    {
        _ImageRed_Videos.hidden=NO;
    }
    [defaults setObject:@"0" forKey:@"videocount"];
    [defaults synchronize];
    
    [self ClienserverComm_Vedios];
      [Tableview_Notif reloadData];
    
}




- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   FlagSearchBar=@"yes";
//    transparancyTuchView.hidden=NO;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    transparancyTuchView.hidden=YES;
}

- (IBAction)SearchEditing_Action:(id)sender
{
    if ([CheckedTabbedButtons isEqualToString:@"Challenges"])
    {
        if (Textfield_Search.text.length==0)
        {
                    FlagSearchBar=@"no";
                    searchString=@"";
                    //transparancyTuchView.hidden=NO;
                    [Array_Public removeAllObjects];
                    [Array_Private removeAllObjects];
                    [Array_AllData removeAllObjects];
                    [Array_Public addObjectsFromArray:Array_Public1];
                   [Array_Private addObjectsFromArray:Array_Private1];
                [Array_AllData addObjectsFromArray:SearchCrickArray_challenge];
            
            
        }
        else
            
        {
                    FlagSearchBar=@"yes";
                    //transparancyTuchView.hidden=YES;
            
                    [Array_Public removeAllObjects];
                    [Array_Private removeAllObjects];
                    [Array_AllData removeAllObjects];
            
                    for (NSDictionary *book in SearchCrickArray_challenge)
                    {
                        NSString * string=[book objectForKey:@"byname"];
            
                        NSRange r=[string rangeOfString:Textfield_Search.text options:NSCaseInsensitiveSearch];
            
                        if (r.location !=NSNotFound )
                        {
                            searchString=Textfield_Search.text;
                            [Array_AllData addObject:book];
            
                        }
            
                    }
            
            
                        for (int i=0; i<Array_AllData.count; i++)
                        {
                            if ([[[Array_AllData objectAtIndex:i]valueForKey:@"challengetype"]isEqualToString:@"PUBLIC"])
                            {
                                [Array_Public addObject:[Array_AllData objectAtIndex:i]];
                            }
                            else
                            {
                                [Array_Private addObject:[Array_AllData objectAtIndex:i]];
                            }
                        }
            
            cell_PublicNoti.Lable_JsonResult.hidden=YES;
            [Tableview_Notif reloadData];
            
        }

                    
                    
                }
    
    if([CheckedTabbedButtons isEqualToString:@"Contribution"])
    {
        if (Textfield_Search.text.length==0)
        {
                    FlagSearchBar=@"no";
                    searchString=@"";
                   // transparancyTuchView.hidden=NO;
                    [Array_IcomingPlg removeAllObjects];
                    [Array_OutgoingPlg removeAllObjects];
                    [Array_AllData_contribution removeAllObjects];
                    [Array_IcomingPlg addObjectsFromArray:Array_IcomingPlg1];
                    [Array_OutgoingPlg addObjectsFromArray:Array_OutgoingPlg1];
                    [Array_AllData_contribution addObjectsFromArray:SearchCrickArray_Contribute];
            
            
        }
        else
            
        {
                    FlagSearchBar=@"yes";
                  //  transparancyTuchView.hidden=YES;
            
                    [Array_IcomingPlg removeAllObjects];
                    [Array_OutgoingPlg removeAllObjects];
                    [Array_AllData_contribution removeAllObjects];
            
                    for (NSDictionary *book in SearchCrickArray_Contribute)
                    {
                        NSString * string=[book objectForKey:@"byname"];
            
                        NSRange r=[string rangeOfString:Textfield_Search.text options:NSCaseInsensitiveSearch];
            
                        if (r.location !=NSNotFound )
                        {
                            searchString=Textfield_Search.text;
                            [Array_AllData_contribution addObject:book];
            
                        }
            
                    }
            
            
            
            for (int i=0; i<Array_AllData_contribution.count; i++)
            {
                if ([[[Array_AllData_contribution objectAtIndex:i]valueForKey:@"contributiontype"]isEqualToString:@"both"])
                {
                    [Array_IcomingPlg addObject:[Array_AllData_contribution objectAtIndex:i]];
                    [Array_OutgoingPlg addObject:[Array_AllData_contribution objectAtIndex:i]];
                }
                else
                {
                    if ([[[Array_AllData_contribution objectAtIndex:i]valueForKey:@"contributiontype"]isEqualToString:@"incoming"])
                    {
                        [Array_IcomingPlg addObject:[Array_AllData_contribution objectAtIndex:i]];
                    }
                    else
                    {
                        
                        [Array_OutgoingPlg addObject:[Array_AllData_contribution objectAtIndex:i]];
                    }
                }
            }
            
                    
                    
                }
            
        }
    
    if ([CheckedTabbedButtons isEqualToString:@"Vedio"])
    {
        if (Textfield_Search.text.length==0)
        {
                    FlagSearchBar=@"no";
                    searchString=@"";
                   // transparancyTuchView.hidden=NO;
            
            [Array_AllData_Videos removeAllObjects];
            
            [Array_AllData_Videos addObjectsFromArray:SearchCrickArray_vedio];
            
            
        }
        else
            
        {
                    FlagSearchBar=@"yes";
                  //  transparancyTuchView.hidden=YES;
            
            
                    [Array_AllData_Videos removeAllObjects];
            
                    for (NSDictionary *book in SearchCrickArray_vedio)
                    {
                        NSString * string=[book objectForKey:@"byname"];
            
                        NSRange r=[string rangeOfString:Textfield_Search.text options:NSCaseInsensitiveSearch];
            
                        if (r.location !=NSNotFound )
                        {
                            searchString=Textfield_Search.text;
                            [Array_AllData_Videos addObject:book];
            
                        }
            
                    }
            
            
    }

    

    }
    [Tableview_Notif reloadData];
}
    
@end
