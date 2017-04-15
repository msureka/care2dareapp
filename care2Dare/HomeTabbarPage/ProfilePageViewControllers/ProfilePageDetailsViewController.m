//
//  ProfilePageDetailsViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/31/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ProfilePageDetailsViewController.h"
#import "AccountSettViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileFriendsViewController.h"
#import "ProfileChallengesViewController.h"
#import "ProfileNotificationViewController.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "CreateChallengesViewController.h"
#import "ContributeDaetailPageViewController.h"
#import "AcceptContributeDetailViewController.h"

@interface ProfilePageDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CALayer *borderBottom_topheder,*borderBottom_Public,*borderBottom_Private;
    
    UIView *sectionView;
    UIView *Button_Public,*Button_Private;
    UIImageView *Image_ButtinPublic,*Image_ButtonPrivate;
    NSUserDefaults * defaults;
    NSMutableArray * Array_Public,*Array_Profile,*Array_Public1;
    NSDictionary *urlplist;
    CALayer *Bottomborder_Cell2;
    UIButton *Button_Dareyou;
}

@end

@implementation ProfilePageDetailsViewController

@synthesize view_Topheader,cell_Public,cell_Private,cell_Profile,userId_prof,Images_data,user_name,user_imageUrl,Button_SetValues;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
    
    self.tabBarController.tabBar.hidden=NO;
   
    
    
    
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    
    UIColor *bgRefreshColor = [UIColor whiteColor];
    
    // Creating refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl setBackgroundColor:bgRefreshColor];
    self.refreshControl = self.refreshControl;
    
    // Creating view for extending background color
    CGRect frame = _Tableview_Profile.bounds;
    frame.origin.y = -frame.size.height;
    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = bgRefreshColor;
    
    // Adding the view below the refresh control
    [_Tableview_Profile insertSubview:bgView atIndex:0];
    self.refreshControl = self.refreshControl;
    
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(PulltoRefershtable)
                  forControlEvents:UIControlEventValueChanged];
    
    [_Tableview_Profile addSubview:self.refreshControl];
    [self ClientserverCommprofile];
    [self ClienserverCommAll];
    
    
    
}
-(void)PulltoRefershtable
{
      [self ClientserverCommprofile];
    [self ClienserverCommAll];
    
    
    [_Tableview_Profile reloadData];
    [self.refreshControl endRefreshing];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
      [self ClientserverCommprofile];
    [self ClienserverCommAll];
    
    
    [_Tableview_Profile reloadData];
}
-(void)ClientserverCommprofile
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
        
        
        NSString *userid1= @"userid1";
        NSString *useridval1= [defaults valueForKey:@"userid"];
        
        NSString *userid2= @"userid2";
       
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid1,useridval1,userid2,userId_prof];
        
        
        
#pragma mark - swipe sesion
    
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"profile"];;
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
                                                     
                    Array_Profile=[[NSMutableArray alloc]init];
                       SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
              Array_Profile=[objSBJsonParser objectWithData:data];
                                                     
 NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
    NSLog(@"Array_AllData %@",Array_Public);
                                                     
    NSLog(@"Array_AllData ResultString %@",ResultString);
       if ([ResultString isEqualToString:@"nouserid"])
                                                     {
                                                         
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
style:UIAlertActionStyleDefault
        handler:nil];
        [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
   if (Array_Profile.count !=0)
       {
           user_imageUrl=[[Array_Profile objectAtIndex:0]valueForKey:@"profileimage"];
           user_name=[[Array_Profile objectAtIndex:0]valueForKey:@"name"];
    if ([[[Array_Profile objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"no"])
           {
               Button_SetValues.enabled=YES;
               [Button_SetValues setImage:[UIImage imageNamed:@"addfriend.png"] forState:UIControlStateNormal];
           }
    if ([[[Array_Profile objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"yes"])
           {
                Button_SetValues.enabled=NO;
                  [Button_SetValues setImage:[UIImage imageNamed:@"addfriend1.png"] forState:UIControlStateNormal];
               
           }
    if ([[[Array_Profile objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"waiting"])
           {
               Button_SetValues.enabled=NO;
               [Button_SetValues setImage:[UIImage imageNamed:@"friendrequested.png"] forState:UIControlStateNormal];
               
           }
   
 
    
                                                         
          [_Tableview_Profile reloadData];
                                                         
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
       
        
        NSString *typeprofile= @"typeprofile";
        NSString *typeprofileval =@"PUBLIC";
        
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,userId_prof,typeprofile,typeprofileval];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"profile_explore"];;
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
                                                     
        Array_Public1=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_Public1=[objSBJsonParser objectWithData:data];
                                                     
            NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
       ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
  ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                NSLog(@"Array_AllData %@",Array_Public1);
                                                     
                                                     
                                                     NSLog(@"Array_AllData ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"nouserid"])
                                                     {
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     
  if (Array_Public.count !=0)
     {
    Array_Public=[[NSMutableArray alloc]init];

for (int i=0; i<Array_Public1.count; i++)
              {
if ([[[Array_Public1 objectAtIndex:i]valueForKey:@"accepted"]isEqualToString:@"no"])
                    {
    [Array_Public addObject:[Array_Public1 objectAtIndex:i]];
                       }
//                    else
//                    {
//        [Array_Private addObject:[Array_AllData objectAtIndex:i]];
//                    }
                }
         
         [_Tableview_Profile reloadData];
                                                         
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
-(void)ClientserverCommunicatioAddfrnd
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
        
        
        NSString *userid1= @"userid1";
        NSString *useridval1= [defaults valueForKey:@"userid"];
        
        NSString *userid2= @"userid2";
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid1,useridval1,userid2,userId_prof];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"addfriend"];;
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
                                                     
                                                     Array_Profile=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_Profile=[objSBJsonParser objectWithData:data];
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"Array_AllData %@",Array_Public);
                                                     
                                                     NSLog(@"Array_AllData ResultString %@",ResultString);
  if ([ResultString isEqualToString:@"requested"])
                    {
                                                         
    [Button_SetValues setImage:[UIImage imageNamed:@"friendrequested.png"] forState:UIControlStateNormal];
                                                         
                                                         
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
    
    if(section==0)
    {
        
        
        return 1;
        
    }
    if(section==1)
    {
        
       
            return Array_Public.count;
    }
    
    
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *mycellid2=@"ProfileCell";
    static NSString *cellId2=@"CellPublic";
    static NSString *cellId3=@"CellPrivate";
    
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            cell_Profile = (profilePageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:mycellid2 forIndexPath:indexPath];
            
            
            
            
           
        cell_Profile.Image_ProfileImg.image=Images_data.image;
        NSURL *url=[NSURL URLWithString:user_imageUrl];
        [cell_Profile.Image_ProfileImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            
            
            
            cell_Profile.Label_Friends22.userInteractionEnabled=YES;
            cell_Profile.Label_Challenges11.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *ViewTap11 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapTapped_Label_Friends22:)];
            [cell_Profile.Label_Friends22 addGestureRecognizer:ViewTap11];
            
            
            UITapGestureRecognizer *ViewTap22 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTapTapped_Label_Challenges11:)];
            [cell_Profile.Label_Challenges11 addGestureRecognizer:ViewTap22];
            
            
            cell_Profile.Name_profile.text=user_name;
            
            
            cell_Profile.Label_Challenges.text= [[Array_Profile objectAtIndex:0] valueForKey:@"challenges"];
            cell_Profile.Label_Friends.text=[[Array_Profile objectAtIndex:0] valueForKey:@"friends"];
            
            
            
            return cell_Profile;
            
            
        }
            break;
        case 1:
            
        {
            
                
                cell_Public = [[[NSBundle mainBundle]loadNibNamed:@"PublicTableViewCell" owner:self options:nil] objectAtIndex:0];
                
                
                
                
                if (cell_Public == nil)
                {
                    
                    cell_Public = [[PublicTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId2];
                    
                    
                }
                
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_Public.frame.size.height-1, cell_Public.frame.size.width, 1);
                [cell_Public.layer addSublayer:Bottomborder_Cell2];
                
                NSDictionary * dic_worldexp=[Array_Public objectAtIndex:indexPath.row];
                cell_Public.Label_Raised.text=[NSString stringWithFormat:@"%@%@",@"$",[dic_worldexp valueForKey:@"backamount"]];
                cell_Public.Label_Backer.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"backers"]];
                cell_Public.Label_Titile.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
                NSString *text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"title"]];
            if ([[dic_worldexp valueForKey:@"accepted"]isEqualToString:@"yes"])
            {
                cell_Public.Image_NewFrnd.hidden=YES;
                
            }
            else
            {
                cell_Public.Image_NewFrnd.hidden=NO;
            }
            
                CGRect textRect = [text boundingRectWithSize:cell_Public.Label_Titile.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell_Public.Label_Titile.font} context:nil];
                
                int numberOfLines = textRect.size.height / cell_Public.Label_Titile.font.pointSize;;
                if (numberOfLines==1)
                {
                    [cell_Public.Label_Titile setFrame:CGRectMake(cell_Public.Label_Titile.frame.origin.x, cell_Public.Label_Titile.frame.origin.y, cell_Public.Label_Titile.frame.size.width, cell_Public.Label_Titile.frame.size.height/2)];
                }
                
                
                
                NSLog(@"number of lines=%d",numberOfLines);
                
                cell_Public.Label_Time.text=[NSString stringWithFormat:@"%@",[dic_worldexp valueForKey:@"createtime"]];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengeid"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"challengerdetails"];
                
                //cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediatype"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"mediaurl"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"noofchallengers"];
                // cell_WorldExp.Label_Time.text=[dic_worldexp valueForKey:@"payperchallenger"];
                
                
                if ([[dic_worldexp valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
                {
                    cell_Public.Image_PalyBuutton.hidden=YES;
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediaurl"]];
                    
                    [cell_Public.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                }
                else
                {
                    
                    NSURL *url=[NSURL URLWithString:[dic_worldexp valueForKey:@"mediathumbnailurl"]];
                    
                    [cell_Public.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                    cell_Public.Image_PalyBuutton.hidden=NO;
                    
                    
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
                
                
                cell_Public.Label_Changename.attributedText = aAttrString;
                
                
                return cell_Public;
                
            
                    }
            
            break;
    }
    return nil;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,375,100)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        
        sectionView.tag=section;
        
        
    }
    if (section==1)
    {
        
      
        //        sectionView.layer.borderWidth=1.0f;
        //        sectionView.layer.borderColor=[UIColor redColor].CGColor;
        /*---------- Borderleft,right,top,bottom for View------------*/
        
        //        sectionView.clipsToBounds = YES;
        //        CALayer *borderBottom = [CALayer layer];
        //      borderBottom.backgroundColor = [UIColor blueColor].CGColor;
        //        borderBottom.frame = CGRectMake(0, sectionView.frame.size.height - 1, sectionView.frame.size.width, 1);
        //        [sectionView.layer addSublayer:borderBottom];
        //
        //        CALayer *borderTop = [CALayer layer];
        //        borderTop.backgroundColor = [UIColor blueColor].CGColor;
        //
        //        borderTop.frame = CGRectMake(0, 0, sectionView.frame.size.width, 1);
        //        [sectionView.layer addSublayer:borderTop];
        
        
        
        /*---------- End color Borders------------*/
        
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1]];
        
        
        
        Button_Dareyou=[[UIButton alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,44)];
        [Button_Dareyou setTitle:@"I DARE YOU" forState:UIControlStateNormal];
        Button_Dareyou.backgroundColor=[UIColor clearColor];
        Button_Dareyou.tag=section;
        Button_Dareyou.titleLabel.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24.0];
        [Button_Dareyou addTarget:self action:@selector(ButtonCreateChalenge_Action:)
                    forControlEvents:UIControlEventTouchUpInside];
        Button_Dareyou.enabled=NO;
        Button_Dareyou.enabled=YES;
       
              [sectionView addSubview:Button_Dareyou];

        
        
        sectionView.tag=section;
        
    }
    
    
    //         /********** Add a custom Separator with Section view *******************/
    //         UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,375, 2)];
    //         separatorLineView.backgroundColor = [UIColor whiteColor];
    //         [sectionView addSubview:separatorLineView];
    return  sectionView;
    
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 0;
    }
    if (section==1)
    {
        return 44;
    }
    return 0;
    //
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return 140;
    }
    if (indexPath.section==1)
    {
        return 140;
    }
    return 0;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        ContributeDaetailPageViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeDaetailPageViewController"];
        
        AcceptContributeDetailViewController * set2=[self.storyboard instantiateViewControllerWithIdentifier:@"AcceptContributeDetailViewController"];
        NSLog(@"Data selected array1=%@",Array_Profile);
        NSLog(@"Data selected array2=%@",Array_Public);
        
        NSDictionary *  didselectDic;
        NSMutableArray * Array_new=[[NSMutableArray alloc]init];
       
            didselectDic=[Array_Public  objectAtIndex:indexPath.row];
            cell_Public = [_Tableview_Profile cellForRowAtIndexPath:indexPath];
            
            [Array_new addObject:didselectDic];
            if ([[NSString stringWithFormat:@"%@",[didselectDic valueForKey:@"accepted"] ]isEqualToString:@"yes"])
            {
                set.ProfileImgeData =cell_Public.Image_Profile;
                set.AllArrayData =Array_new;
                [self.navigationController pushViewController:set animated:YES];
                
            }
            else
            {
                set2.ProfileImgeData =cell_Public.Image_Profile;
                set2.AllArrayData =Array_new;
                [self.navigationController pushViewController:set2 animated:YES];
            }
            
            
        
        
        NSLog(@"Array_new11=%@",Array_new);;
        
        
        
        
        NSLog(@"Array_new22=%@",Array_new);;
        NSLog(@"indexPathrow=%ld",(long)indexPath.row);;
        
        
    }
  
}



- (void)ViewTapTapped_Label_Friends22:(UITapGestureRecognizer *)recognizer
{
   
    
//        ProfileFriendsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileFriendsViewController"];
//        [self.navigationController pushViewController:set animated:YES];
    
    
    
}
- (void)ViewTapTapped_Label_Challenges11:(UITapGestureRecognizer *)recognizer
{
    
   
//    ProfileChallengesViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileChallengesViewController"];
//    [self.navigationController pushViewController:set animated:YES];
    
}


-(IBAction)SettingButton_Action:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];
    
    //  [self performSegueWithIdentifier:@"sa" sender:self];
}
-(IBAction)NotificationButton_Action:(id)sender
{
    
if ([[[Array_Profile objectAtIndex:0]valueForKey:@"friendstatus"] isEqualToString:@"no"])
    {
        Button_SetValues.enabled=YES;
        [self ClientserverCommunicatioAddfrnd];
        
    }
    else
    {
        Button_SetValues.enabled=NO;
        
    }
//    ProfileNotificationViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileNotificationViewController"];
//    [self.navigationController pushViewController:set animated:YES];
    
    //  [self performSegueWithIdentifier:@"sa" sender:self];
}
-(void)ButtonCreateChalenge_Action:(UIButton *)sender
{
    [defaults setObject:@"yes" forKey:@"flag"];
    [defaults setObject:user_name forKey:@"usernames"];
    [defaults setObject:userId_prof forKey:@"userids"];
    [defaults synchronize];
    CreateChallengesViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateChallengesViewController"];
    [self.navigationController presentViewController:set animated:YES completion:NULL];
}
@end
