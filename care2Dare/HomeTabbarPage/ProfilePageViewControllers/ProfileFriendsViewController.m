//
//  ProfileFriendsViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/7/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ProfileFriendsViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "AFNetworking.h"
@interface ProfileFriendsViewController ()<UITextFieldDelegate>
{
    UIView *sectionView;
    NSString * SeachCondCheck,*FlagSearchBar,*searchString;;
    NSMutableArray * Array_Friends,*Array_NewReq,*Array_AddReq;
    NSUserDefaults * defaults;
   UIView *transparancyTuchView;
    NSDictionary *urlplist;
    UIActivityIndicatorView *indicator;
    NSString * string_Actiontype,*useridval2;
    UILabel * Label_result;
     NSArray *SearchCrickArray,*Array_Match1,*Array_Messages1;
}
@end

@implementation ProfileFriendsViewController
@synthesize cell_req,cell_addreq,Lable_TitleFriends,Button_Back,Button_Search,Textfield_Search,Tableview_Friends,view_Topheader,Str_profiletypr;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    defaults=[[NSUserDefaults alloc]init];
    Textfield_Search.hidden=YES;
    SeachCondCheck=@"no";
    Textfield_Search.delegate=self;
  CALayer*  borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
    Tableview_Friends.hidden=YES;
    
     Label_result=[[UILabel alloc]initWithFrame:CGRectMake(20,0, self.view.frame.size.width-40,60)];
    Label_result.backgroundColor=[UIColor clearColor];
    Label_result.textAlignment=NSTextAlignmentCenter;
    Label_result.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:18.0f];
    Label_result.center=self.view.center;
    Label_result.text=@"Your complete friend list and friend requests will be shown here.";
    Label_result.numberOfLines=2.0f;
    Label_result.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    [self.view addSubview:Label_result];
    Label_result.hidden=YES;
    
    indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    [indicator startAnimating];
    indicator.color=[UIColor darkGrayColor];
    indicator.center = self.view.center;
    indicator.hidden=NO;

    
    transparancyTuchView=[[UIView alloc]initWithFrame:CGRectMake(0, view_Topheader.frame.size.height+44, self.view.frame.size.width,self.view.frame.size.height-view_Topheader.frame.size.height-44)];
    transparancyTuchView.backgroundColor=[UIColor whiteColor];
    [transparancyTuchView setAlpha:0.5];
    [self.view addSubview:transparancyTuchView];
    transparancyTuchView.hidden=YES;
    UITapGestureRecognizer * ViewTap51 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewTap51Tapped:)];
    [transparancyTuchView addGestureRecognizer:ViewTap51];
    
    FlagSearchBar=@"no";
    string_Actiontype=@"";
    useridval2=@"";
    [self ClientserverCommFriends];
}
- (void)ViewTap51Tapped:(UITapGestureRecognizer *)recognizer
{
    transparancyTuchView.hidden=YES;
    [self.view endEditing:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
      [super viewWillAppear:YES];
    transparancyTuchView.hidden=YES;
    Textfield_Search.text=@"";
    FlagSearchBar=@"no";
    [Tableview_Friends reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

-(IBAction)ButtonBack_Action:(id)sender
{
    if ([SeachCondCheck isEqualToString:@"yes"])
    {
         [Textfield_Search resignFirstResponder];
        Lable_TitleFriends.hidden=NO;
        Textfield_Search.hidden=YES;
         Button_Search.hidden=NO;
        SeachCondCheck=@"no";
        searchString=@"";
        Textfield_Search.text=@"";
        [Tableview_Friends reloadData];
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
    Lable_TitleFriends.hidden=YES;
    Textfield_Search.hidden=NO;
    Button_Search.hidden=YES;
    
    
    
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section==0)
    {
        
   return Array_NewReq.count;
        
    }
    if(section==1)
    {
   return Array_AddReq.count;
        
    }
    
    
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *mycellid2=@"CellReq";
    static NSString *cellId2=@"CellAddReq";

    
    
    switch (indexPath.section)
    {
            
        case 0:
        {

            cell_req = (FriendsReqTableViewCell*)[tableView dequeueReusableCellWithIdentifier:mycellid2 forIndexPath:indexPath];
            
            
            [cell_req.image_profile setFrame:CGRectMake(cell_req.image_profile.frame.origin.x, cell_req.image_profile.frame.origin.y, cell_req.image_profile.frame.size.width, cell_req.image_profile.frame.size.width)];
            
            cell_req.image_profile.clipsToBounds=YES;
            cell_req.image_profile.layer.cornerRadius=cell_req.image_profile.frame.size.height/2;
            
            
            NSURL *url=[NSURL URLWithString:[[Array_NewReq objectAtIndex:indexPath.row] valueForKey:@"friendprofilepic"]];
            
            [cell_req.image_profile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
            
        cell_req.Label_Name.text=[[Array_NewReq objectAtIndex:indexPath.row] valueForKey:@"friendname"];
      NSString *textfname=[[Array_NewReq objectAtIndex:indexPath.row] valueForKey:@"friendname"];
           
            if (searchString.length==0)
            {
                
               cell_req.Label_Name.text=[[Array_NewReq objectAtIndex:indexPath.row] valueForKey:@"friendname"];
            cell_req.Label_Name.textColor=[UIColor lightGrayColor];
                
            }
            else
            {
                
                
                
               
                NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                
              
                NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                
                NSRange rangefname = NSMakeRange(0 ,textfname.length);
                
                               [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                    
                    NSRange subStringRange = [result rangeAtIndex:0];
                    [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] range:subStringRange];
                }];
                
                if ([FlagSearchBar isEqualToString:@"yes"])
                {
                  
                   cell_req.Label_Name.attributedText=mutableAttributedStringfname;
                }
                else
                {
                    
                    
                    
        cell_req.Label_Name.text=[[Array_NewReq objectAtIndex:indexPath.row] valueForKey:@"friendname"];
                 
                    
                    FlagSearchBar=@"no";
                    
                }

            }
            
//            cell_Profile.Label_Challenges.text= [defaults valueForKey:@"challenges"];
//            cell_Profile.Label_Friends.text=[defaults valueForKey:@"friends"];
            cell_req.Image_RedMinus.tag=indexPath.row;
            cell_req.Image_BlueMinus.tag=indexPath.row;
            
            cell_req.Image_RedMinus.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *Image_RedMinustapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_RedMinustapped_Action:)];
            [cell_req.Image_RedMinus addGestureRecognizer:Image_RedMinustapped];
            
             cell_req.Image_BlueMinus.userInteractionEnabled=YES;
            UITapGestureRecognizer *Image_BlueMinusTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_BlueMinusTapped_action:)];
            [cell_req.Image_BlueMinus addGestureRecognizer:Image_BlueMinusTapped];
            

            
            
            return cell_req;
            
            
        }
            break;
        case 1:
            
        {
           
                cell_addreq =(FriendAddReqTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
                
            
            NSURL *url=[NSURL URLWithString:[[Array_AddReq objectAtIndex:indexPath.row] valueForKey:@"friendprofilepic"]];
            
             cell_addreq.Image_GrayMinus.tag=indexPath.row;
            [cell_addreq.image_profile setFrame:CGRectMake(cell_addreq.image_profile.frame.origin.x, cell_addreq.image_profile.frame.origin.y, cell_addreq.image_profile.frame.size.width, cell_addreq.image_profile.frame.size.width)];
            
    cell_addreq.image_profile.clipsToBounds=YES;
            cell_addreq.image_profile.layer.cornerRadius=cell_addreq.image_profile.frame.size.height/2;
            
            [cell_addreq.image_profile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
            
            cell_addreq.Label_Name.text=[[Array_AddReq objectAtIndex:indexPath.row] valueForKey:@"friendname"];
            
            cell_addreq.Image_GrayMinus.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *Image_GrayMinusTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_GrayMinusTapped_Action:)];
            [cell_addreq.Image_GrayMinus addGestureRecognizer:Image_GrayMinusTapped];
                
            NSString *textfname=[[Array_AddReq objectAtIndex:indexPath.row] valueForKey:@"friendname"];

            if (searchString.length==0)
            {
                
                cell_addreq.Label_Name.text=[[Array_AddReq objectAtIndex:indexPath.row] valueForKey:@"friendname"];
                
                cell_addreq.Label_Name.textColor=[UIColor lightGrayColor];
                
            }
            else
            {
                
                
                
                
                NSMutableAttributedString *mutableAttributedStringfname = [[NSMutableAttributedString alloc] initWithString:textfname];
                
                
                NSRegularExpression *regexfname = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:nil];
                
                NSRange rangefname = NSMakeRange(0 ,textfname.length);
                
                [regexfname enumerateMatchesInString:textfname options:kNilOptions range:rangefname usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                    
                    NSRange subStringRange = [result rangeAtIndex:0];
                    [mutableAttributedStringfname addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] range:subStringRange];
                }];
                
                if ([FlagSearchBar isEqualToString:@"yes"])
                {

                cell_addreq.Label_Name.attributedText=mutableAttributedStringfname;
                }
                else
                {
                    
                    
                    
                    cell_addreq.Label_Name.text=[[Array_AddReq objectAtIndex:indexPath.row] valueForKey:@"friendname"];
                    FlagSearchBar=@"no";
                    
                }
                
            }
            
            
            
            
            
            
            
            
                return cell_addreq;
                
            
          

            
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
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor whiteColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"New Requests";
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
        Label1.text=@"Friends";
        [sectionView addSubview:Label1];
        
        CALayer*  borderBottom_topheder = [CALayer layer];
        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
        [sectionView.layer addSublayer:borderBottom_topheder];
        
        sectionView.tag=section;
        
    }
    return  sectionView;
    
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        if (Array_NewReq.count==0)
        {
            return 0;
        }
        else
        {
            return 44;
        }
    }
    if (section==1)
    {
        if (Array_AddReq.count==0)
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
    
   
        return 55;
   
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
}

-(void)ClientserverCommFriends
{
    [self.view endEditing:YES];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
    style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
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
        
        NSString *actiontype= @"actiontype";
        NSString *profiletype,*profiletypeval;
        if ([Str_profiletypr isEqualToString:@"SELF"])
        {
            profiletype= @"profiletype";
            profiletypeval=@"SELF";
        }
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",userid1,useridval1,userid2,useridval2,actiontype,string_Actiontype,profiletype,profiletypeval];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"profile_friends"];;
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
                                                     
        Array_Friends=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
    Array_Friends=[objSBJsonParser objectWithData:data];
                                                     
    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
NSLog(@"Array_AllData ResultString %@",ResultString);
    if ([ResultString isEqualToString:@"nouserid"])
            {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
style:UIAlertActionStyleDefault handler:nil];
[alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
          }
                if ([ResultString isEqualToString:@"nofriends"])
                {
                     indicator.hidden=YES;
                     Label_result.hidden=NO;
                    Tableview_Friends.hidden=YES;

                }
                
        if (Array_Friends.count !=0)
              {
        Array_NewReq=[[NSMutableArray alloc]init];
        Array_AddReq=[[NSMutableArray alloc]init];
                  for (int i=0; i<Array_Friends.count; i++)
                  {
    if ([[[Array_Friends objectAtIndex:i]valueForKey:@"friendstatus"]isEqualToString:@"waiting"])
                      {
            [Array_NewReq addObject:[Array_Friends objectAtIndex:i]];
                      }
                      else
                      {
        [Array_AddReq addObject:[Array_Friends objectAtIndex:i]];
                      }
                      
                  }
                    Label_result.hidden=YES;
                Tableview_Friends.hidden=NO;
                indicator.hidden=YES;
                  
                  SearchCrickArray=[Array_Friends mutableCopy];
                  Array_Messages1=[Array_AddReq mutableCopy];
                  Array_Match1=[Array_NewReq mutableCopy];

       [Tableview_Friends reloadData];
                                                         
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
-(void)Image_RedMinustapped_Action:(UIGestureRecognizer *)sender
{
UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);
    useridval2=[[Array_NewReq objectAtIndex:imageView.tag]valueForKey:@"frienduserid"];
    string_Actiontype=@"DELETE";
    [self ClientserverCommFriends];
}
-(void)Image_BlueMinusTapped_action:(UIGestureRecognizer *)sender
{
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);

    useridval2=[[Array_NewReq objectAtIndex:imageView.tag]valueForKey:@"frienduserid"];
    string_Actiontype=@"ACCEPT";
   [self ClientserverCommFriends];
}
-(void)Image_GrayMinusTapped_Action:(UIGestureRecognizer *)sender
{
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);

     useridval2=[[Array_AddReq objectAtIndex:imageView.tag]valueForKey:@"frienduserid"];
    string_Actiontype=@"DELETE";
   [self ClientserverCommFriends];
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
        [Array_NewReq removeAllObjects];
        [Array_AddReq removeAllObjects];
        [Array_Friends removeAllObjects];
        [Array_AddReq addObjectsFromArray:Array_Messages1];
        [Array_NewReq addObjectsFromArray:Array_Match1];
        [Array_Friends addObjectsFromArray:SearchCrickArray];
        
        
    }
    else
        
    {
         FlagSearchBar=@"yes";
        transparancyTuchView.hidden=YES;
        
        [Array_AddReq removeAllObjects];
        [Array_NewReq removeAllObjects];
        [Array_Friends removeAllObjects];
        
        for (NSDictionary *book in SearchCrickArray)
        {
            NSString * string=[book objectForKey:@"friendname"];
            
            NSRange r=[string rangeOfString:Textfield_Search.text options:NSCaseInsensitiveSearch];
            
            if (r.location !=NSNotFound )
            {
                searchString=Textfield_Search.text;
                [Array_Friends addObject:book];
                
            }
            
        }
        
        
        
        for (int i=0; i<Array_Friends.count; i++)
        {
            if ([[[Array_Friends objectAtIndex:i]valueForKey:@"friendstatus"]isEqualToString:@"waiting"])
            {
                
                
                [Array_NewReq addObject:[Array_Friends objectAtIndex:i]];
                
                
            }
            
            else
            {
                
                [Array_AddReq addObject:[Array_Friends objectAtIndex:i]];
                
                
            }
        }
        
        
    }
   
    
    [Tableview_Friends reloadData];
}
@end
