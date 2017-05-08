//
//  StatsViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "StatsViewController.h"
#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH self.view.frame.size.width-138
#define CELL_CONTENT_MARGIN 0.0f
@interface StatsViewController ()
{
    UIView *sectionView;
       NSUserDefaults *defaults;
    NSDictionary *urlplist;
    NSMutableArray * Array_Stats;
  
}
@end

@implementation StatsViewController
@synthesize oneCell,twoCell,threeCell,fourCell,Tableview_Stats,view_Topheader,str_ChallengeidVal1,indicator_view;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self coomunicationServer_Stats];
}
- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    CALayer * borderBottom_topheder = [CALayer layer];
    
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    
    [view_Topheader.layer addSublayer:borderBottom_topheder];
    
    [indicator_view startAnimating];
    Tableview_Stats.hidden=YES;
    indicator_view.hidden=NO;
   
}
-(void)coomunicationServer_Stats
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
        
   
        
        NSString *challengeid= @"challengeid";
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",challengeid,str_ChallengeidVal1];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"stats"];;
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
                                                     
            Array_Stats=[[NSMutableArray alloc]init];
                                                     
                                                     
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     
        Array_Stats=[objSBJsonParser objectWithData:data];
                                                     
                                                     
                                                     
  NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     
   ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
       
                    if(Array_Stats.count !=0)
                            {
                                indicator_view.hidden=YES;
                                [indicator_view stopAnimating];
                                Tableview_Stats.hidden=NO;
                                
                            }
                             else
                             {
                                 indicator_view.hidden=YES;
                        [indicator_view stopAnimating];
                        Tableview_Stats.hidden=NO;
     
                             }
                         [Tableview_Stats reloadData];
                                                     
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
-(IBAction)ButtonBack_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 100;
    }
    if (indexPath.section==1)
    {
        if (Array_Stats.count==0)
        {
                      return 0;
        }
        else
        {
            return 160;
        }
    }
    if (indexPath.section==2)
    {
        return 100;
    }
    if (indexPath.section==3)
    {
        return 100;
    }
    
        return 0;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid1=@"statsone";
    static NSString *cellId2=@"statstwo";
    static NSString *cellId3=@"statsthree";
    static NSString *cellId4=@"statsfour";
    
    
    switch (indexPath.section)
    {
            
            
        case 0:
        {
            
            oneCell = (StatsOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
            if (Array_Stats.count==0)
            {
                
                oneCell.Label_ChallengeAmount.text=@"This challenge \nRaised: $0";
                
            }
            
            else
            {
                 oneCell.Label_ChallengeAmount.text=[NSString stringWithFormat:@"%@%@",@"This challenge \nRaised: $",[[Array_Stats objectAtIndex:0]valueForKey:@"totalpledge"]];
                           }
           
            return oneCell;
            
            
        }
            break;
        case 1:
            
        {
            twoCell = (StatsTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
            
            NSURL *url=[NSURL URLWithString:[[Array_Stats objectAtIndex:0]valueForKey: @"backersprofilepic"]];
            
            [twoCell.image_profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            
            twoCell.Label_ChallengeName.text=[[Array_Stats objectAtIndex:0]valueForKey: @"backersname"];
            
            
        
            
            return twoCell;
            
        }
            break;
            
        case 2:
            
        {
            
            
            threeCell = (StatsThreeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId3 forIndexPath:indexPath];
            
            threeCell.Label_ChallengeAmount.clipsToBounds=YES;
            threeCell.Label_ChallengeAmount.layer.cornerRadius=15.0f;
            
            
            
            
           
            
            
            
            if (Array_Stats.count==0)
            {
                
                threeCell.Label_ChallengeAmount.text=@"0";
               

            }
            
            else
            {
            threeCell.Label_ChallengeAmount.text=[NSString stringWithFormat:@"%@",[[Array_Stats objectAtIndex:0]valueForKey:@"pledgecount"]];
                NSString * text=[NSString stringWithFormat:@"%@",[[Array_Stats objectAtIndex:0]valueForKey:@"pledgecount"]];
                
                
                
                
                
                
                CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
                
                CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
                
                CGFloat height = MAX(size.height, 30.0f);
                NSLog(@"Dynamic label height====%f",height);
                threeCell.Label_ChallengeAmount.numberOfLines=0;
                threeCell.Label_ChallengeAmount.lineBreakMode=UILineBreakModeWordWrap;
                
                
                NSInteger rHeight = size.height/FONT_SIZE;
                NSLog(@"No of lines: %ld",(long)rHeight);
                
                [threeCell.Label_ChallengeAmount setFrame:CGRectMake(threeCell.Label_ChallengeAmount.frame.origin.x,threeCell.Label_ChallengeAmount.frame.origin.y, size.width+60,threeCell.Label_ChallengeAmount.frame.size.height)];
                
                
            }

            
            return threeCell;
            
        }
            
            break;
            
        case 3:
            
        {
            
            
            fourCell = (StatsFourTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId4 forIndexPath:indexPath];
            
         
           
            return fourCell;
            
        }
            
            break;
            
            
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
       
    }
    if (section==1)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,34)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:16.0f];
        Label1.text=@"Highest contributor";
        [sectionView addSubview:Label1];
        
        CALayer * borderBottom_topheder = [CALayer layer];
        
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        
        [sectionView.layer addSublayer:borderBottom_topheder];
        
        
        sectionView.tag=section;
        
    }
    if (section==2)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,34)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:16.0f];
        Label1.text=@"Supporters";
        [sectionView addSubview:Label1];
        CALayer * borderBottom_topheder = [CALayer layer];
        
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        
        [sectionView.layer addSublayer:borderBottom_topheder];
        sectionView.tag=section;
        
        
    }
    
    if (section==3)
    {

        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,34)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:16.0f];
        Label1.text=@"Charities";
        [sectionView addSubview:Label1];
        CALayer * borderBottom_topheder = [CALayer layer];
        
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        
        [sectionView.layer addSublayer:borderBottom_topheder];
        sectionView.tag=section;
    }
    
    
    return  sectionView;
    
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    
//        return 45;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 0;
    }
    else if (section==1)
    {
    if (Array_Stats.count==0)
    {
           return 0;
    }
        else
        {
          return 34;
        }
    }
    else
    {
      return 34;
    }
  
    
}

@end
