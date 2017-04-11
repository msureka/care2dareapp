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
    NSMutableArray *Array_Watch,*Array_Watch1;
    NSUserDefaults *defaults;
    NSDictionary *urlplist;
    NSString *SeachCondCheck,*searchString,*FlagSearchBar;
    NSArray *SearchCrickArray;
    UIView *transparancyTuchView;
}
@end

@implementation WatchPageViewController
@synthesize Tableview_watch,cell_one;
@synthesize Lable_TitleFriends,Button_Back,Button_Search,Textfield_Search,view_Topheader;
- (void)viewDidLoad {
    [super viewDidLoad];
   //
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    SearchCrickArray=[[NSArray alloc]init];
    
    Textfield_Search.hidden=YES;
    SeachCondCheck=@"no";
    Textfield_Search.delegate=self;
    CALayer*  borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
   
    transparancyTuchView=[[UIView alloc]initWithFrame:CGRectMake(0, view_Topheader.frame.size.height+44, self.view.frame.size.width,self.view.frame.size.height-view_Topheader.frame.size.height-44)];
    transparancyTuchView.backgroundColor=[UIColor whiteColor];
    [transparancyTuchView setAlpha:0.5];
    [self.view addSubview:transparancyTuchView];
    transparancyTuchView.hidden=YES;
    UITapGestureRecognizer * ViewTap51 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTap51Tapped:)];
    [transparancyTuchView addGestureRecognizer:ViewTap51];
    
    FlagSearchBar=@"no";
   
    Button_Back.hidden=YES;
    
    
    [self ClienserverComm_watchView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
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
                Array_Watch1=[[NSMutableArray alloc]init];
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
                    
                     SearchCrickArray=[Array_Watch mutableCopy];
                               NSLog(@"arra new watch==%@",Array_Watch1);
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
    
    NSDictionary * dic_value=[Array_Watch objectAtIndex:indexPath.row];
            
            NSURL *url=[NSURL URLWithString:[dic_value valueForKey:@"profileimage"]];
            
            [cell_one.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
    
    
    
    NSURL *url1=[NSURL URLWithString:[dic_value valueForKey:@"thumbnailurl1"]];
    
    [cell_one.Image_Thumbnail sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
    
    cell_one.Label_title.text=[dic_value valueForKey:@"challengetitle"];
    NSInteger countVedio=[[dic_value valueForKey:@"videocount"] integerValue];
    if (countVedio >=5)
    {
        cell_one.Label_mores.hidden=NO;
        cell_one.Label_moreVedios.hidden=NO;
        cell_one.Label_mores.text=[dic_value valueForKey:@"videocount"];
    }
    else
    {
       cell_one.Label_mores.hidden=YES;
         cell_one.Label_moreVedios.hidden=YES;
    }
    
    NSURL *urlthum1,*urlthum2,*urlthum3,*urlthum4;
    
    
    if([NSNull null] ==[dic_value valueForKey:@"thumbnailurl2"] || [[dic_value valueForKey:@"thumbnailurl2"]isEqualToString:@""])
    {
        
        cell_one.Image_ThumbnailVedio1.hidden=YES;
    }
    else
    {
         cell_one.Image_ThumbnailVedio1.hidden=NO;
       urlthum1=[NSURL URLWithString:[dic_value valueForKey:@"thumbnailurl2"]];
          [cell_one.Image_ThumbnailVedio1 sd_setImageWithURL:urlthum1 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
    }

    if([NSNull null] ==[dic_value valueForKey:@"thumbnailurl3"]|| [[dic_value valueForKey:@"thumbnailurl3"]isEqualToString:@""])
    {
        
        cell_one.Image_ThumbnailVedio2.hidden=YES;
    }
    else
    {
        cell_one.Image_ThumbnailVedio2.hidden=NO;
        urlthum2=[NSURL URLWithString:[dic_value valueForKey:@"thumbnailurl3"]];
        [cell_one.Image_ThumbnailVedio2 sd_setImageWithURL:urlthum2 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
    }

    if([NSNull null] ==[dic_value valueForKey:@"thumbnailurl4"] || [[dic_value valueForKey:@"thumbnailurl4"]isEqualToString:@""])
    {
        
        cell_one.Image_ThumbnailVedio3.hidden=YES;
    }
    else
    {
        cell_one.Image_ThumbnailVedio3.hidden=NO;
        urlthum3=[NSURL URLWithString:[dic_value valueForKey:@"thumbnailurl4"]];
        [cell_one.Image_ThumbnailVedio3 sd_setImageWithURL:urlthum3 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
    }

    if([NSNull null] ==[dic_value valueForKey:@"thumbnailurl5"]|| [[dic_value valueForKey:@"thumbnailurl5"]isEqualToString:@""])
    {
        
        cell_one.Image_ThumbnailVedio4.hidden=YES;
    }
    else
    {
        cell_one.Image_ThumbnailVedio4.hidden=NO;
        urlthum4=[NSURL URLWithString:[dic_value valueForKey:@"thumbnailurl5"]];
        [cell_one.Image_ThumbnailVedio4 sd_setImageWithURL:urlthum4 placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
    }

    
    if([NSNull null] ==[dic_value valueForKey:@"newstatus2"]|| [[dic_value valueForKey:@"newstatus2"]isEqualToString:@""]|| [[dic_value valueForKey:@"newstatus2"]isEqualToString:@"no"])
    {
        cell_one.Image_New_ThumbnailVedio1.hidden=YES;
       
    }
    else
    {
         cell_one.Image_New_ThumbnailVedio1.hidden=NO;
    }
    
    if([NSNull null] ==[dic_value valueForKey:@"newstatus3"]|| [[dic_value valueForKey:@"newstatus3"]isEqualToString:@""]|| [[dic_value valueForKey:@"newstatus3"]isEqualToString:@"no"])
    {
        
        cell_one.Image_New_ThumbnailVedio2.hidden=YES;
    }
    else
    {
        
        cell_one.Image_New_ThumbnailVedio2.hidden=NO;
            
            
        }
    if([NSNull null] ==[dic_value valueForKey:@"newstatus4"]|| [[dic_value valueForKey:@"newstatus4"]isEqualToString:@""]|| [[dic_value valueForKey:@"newstatus4"]isEqualToString:@"no"])
    {
        
        cell_one.Image_New_ThumbnailVedio3.hidden=YES;
    }
    else
    {
         cell_one.Image_New_ThumbnailVedio3.hidden=NO;
    }
    
    if([NSNull null] ==[dic_value valueForKey:@"newstatus5"]|| [[dic_value valueForKey:@"newstatus5"]isEqualToString:@""] || [[dic_value valueForKey:@"newstatus5"]isEqualToString:@"no"])
    {
        
         cell_one.Image_New_ThumbnailVedio4.hidden=YES;
    }
    else
    {
         cell_one.Image_New_ThumbnailVedio4.hidden=NO;
    }
    
    if([NSNull null] ==[dic_value valueForKey:@"newstatus1"]|| [[dic_value valueForKey:@"newstatus1"]isEqualToString:@""] || [[dic_value valueForKey:@"newstatus1"]isEqualToString:@"no"])
    {
        
        cell_one.Image_NewFrndThumbnail.hidden=YES;
    }
    else
    {
        cell_one.Image_NewFrndThumbnail.hidden=NO;
    }

    UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Posted by " attributes: arialDict];
    
    UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
    NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[dic_value valueForKey:@"name"]  attributes:verdanaDict];
    
    
    [aAttrString appendAttributedString:vAttrString];
    
    
    
    cell_one.Label_Changename.attributedText = aAttrString;

 
    
    
//    challengeid = C20170404122329IEXZ;
//    challengetitle = Sachin;
//    name = "Er Sachin Mokashi";
//    newstatus1 = no;
//    newstatus2 = yes;
//    newstatus3 = "<null>";
//    newstatus4 = "<null>";
//    newstatus5 = "<null>";
//    posttime = "5d ago";
//    profileimage = "https://graph.facebook.com/1280357812049167/picture?type=large";
//    recorddate = "2017-04-06 05:30:29";
//    "registration_status" = ACTIVE;
//    thumbnailurl1 = "http://www.care2dareapp.com/app/recordedmedia/RArrayC20170404122329IEXZ-thumbnail.jpg";
//    thumbnailurl2 = "http://www.care2dareapp.com/app/recordedmedia/RArrayC20170404122329IEXZ-thumbnail.jpg";
//    thumbnailurl3 = "<null>";
//    thumbnailurl4 = "<null>";
//    thumbnailurl5 = "<null>";
//    useridvideo1 = 20170307091520wFL3;
//    useridvideo2 = 20170304123911MZFg;
//    useridvideo3 = "<null>";
//    useridvideo4 = "<null>";
//    useridvideo5 = "<null>";
//    videocount = 2;
//    videourl1 = "http://www.care2dareapp.com/app/recordedmedia/RArrayC20170404122329IEXZ.mp4";
//    videourl2 = "http://www.care2dareapp.com/app/recordedmedia/RArrayC20170404122329IEXZ.mp4";
//    videourl3 = "<null>";
//    videourl4 = "<null>";
//    videourl5 = "<null>";

   
    
    
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

-(IBAction)ButtonBack_Action:(id)sender
{
    [Textfield_Search resignFirstResponder];
   
    Lable_TitleFriends.hidden=NO;
    Textfield_Search.hidden=YES;
    Button_Search.hidden=NO;
    Button_Back.hidden=YES;
    Textfield_Search.text=@"";
    [Array_Watch removeAllObjects];
    [Array_Watch addObjectsFromArray:SearchCrickArray];
    [Tableview_watch reloadData];
    
}
-(IBAction)ButtonSearch_Action:(id)sender
{
    [Textfield_Search becomeFirstResponder];
    Lable_TitleFriends.hidden=YES;
    Textfield_Search.hidden=NO;
    Button_Search.hidden=YES;
       Button_Back.hidden=NO;
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [Textfield_Search resignFirstResponder];
    return YES;
}




- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    FlagSearchBar=@"yes";
    transparancyTuchView.hidden=NO;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    transparancyTuchView.hidden=YES;
}

- (IBAction)SearchEditing_Action:(id)sender
{
    
    
    if (Textfield_Search.text.length==0)
    {
        FlagSearchBar=@"no";
        searchString=@"";
        transparancyTuchView.hidden=NO;
        [Array_Watch removeAllObjects];
        [Array_Watch addObjectsFromArray:SearchCrickArray];
        Button_Back.hidden=NO;
        
    }
    else
        
    {
        FlagSearchBar=@"yes";
        transparancyTuchView.hidden=YES;
        Button_Back.hidden=NO;
        [Array_Watch removeAllObjects];
       
        
        for (NSDictionary *book in SearchCrickArray)
        {
            NSString * string=[book objectForKey:@"name"];
            
            NSRange r=[string rangeOfString:Textfield_Search.text options:NSCaseInsensitiveSearch];
            
            if (r.location !=NSNotFound )
            {
                searchString=Textfield_Search.text;
                [Array_Watch addObject:book];
                
            }
            
        }
        
    
        
        
    }
    
    
    [Tableview_watch reloadData];
}
- (void)ViewTap51Tapped:(UITapGestureRecognizer *)recognizer
{
    [Textfield_Search resignFirstResponder];
    
    Lable_TitleFriends.hidden=NO;
    Textfield_Search.hidden=YES;
    Button_Search.hidden=NO;
    Button_Back.hidden=YES;
    Textfield_Search.text=@"";
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}
@end
