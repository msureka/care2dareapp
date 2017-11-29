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
#import "UIView+RNActivityView.h"
#import "CreateChallengesViewController.h"
#import "AccOneTableViewCell.h"
#import "ContactListViewController.h"
#import "FacebookListViewController.h"
#import "TwitterListViewController.h"
#import "ProfileFriendasAlluserTableViewCell.h"
#import <TwitterKit/TwitterKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Bolts/Bolts.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "UIViewController+KeyboardAnimation.h"
#import "ProfilePageDetailsViewController.h"
@interface ProfileFriendsViewController ()<UITextFieldDelegate>
{
    UIView *sectionView;
    NSString * SeachCondCheck,*FlagSearchBar,*searchString;;
    NSMutableArray * Array_Friends,*Array_Friends_All,*Array_NewReq,*Array_AddReq,*Array_Allusers;
    NSUserDefaults * defaults;
   UIView *transparancyTuchView;
    NSDictionary *urlplist;
    UIActivityIndicatorView *indicator;
    NSString * string_Actiontype,*useridval2;
    UILabel * Label_result;
     NSArray *SearchCrickArray,*Array_Match1,*Array_Messages1,*Array_Title1,*Array_Images,*SearchCrickArray_All;
    
    NSString *emailFb,*DobFb,*nameFb,*genderfb,*profile_picFb,*Fbid,*regTypeVal,*EmailValidTxt,*Str_fb_friend_id,*Str_fb_friend_id_Count;
    NSMutableArray *fb_friend_id,*userId_second;
     CGFloat tableview_height;
}
@end

@implementation ProfileFriendsViewController
@synthesize cell_req,cell_addreq,Lable_TitleFriends,Button_Back,Button_Search,Textfield_Search,Tableview_Friends,view_Topheader,Str_profiletypr;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    defaults=[[NSUserDefaults alloc]init];
    Array_Title1=[[NSArray alloc]initWithObjects:@"Facebook Friends",@"Twitter Friends",@"Contacts", nil];
    Array_Images=[[NSArray alloc]initWithObjects:@"setting_facebook.png",@"setting_twitter.png",@"setting_contacts.png", nil];
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
     tableview_height=Tableview_Friends.frame.size.height;
    FlagSearchBar=@"no";
    string_Actiontype=@"";
    useridval2=@"";
    [self ClientserverCommFriends];
    [self Communication_listallusers];
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
    [self subscribeToKeyboard];
    [Tableview_Friends reloadData];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self an_unsubscribeKeyboard];
}
- (void)subscribeToKeyboard
{
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing)
        {
            
            [Tableview_Friends setFrame:CGRectMake(0, Tableview_Friends.frame.origin.y, self.view.frame.size.width, tableview_height-keyboardRect.size.height)];
            
            
        } else
        {
            
            [Tableview_Friends setFrame:CGRectMake(0, Tableview_Friends.frame.origin.y, self.view.frame.size.width, tableview_height)];
        }
        [self.view layoutIfNeeded];
    } completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}
#pragma mark-Button_Action
-(IBAction)ButtonBack_Action:(id)sender
{
 
    if ([SeachCondCheck isEqualToString:@"yes"])
    {
        
        FlagSearchBar=@"no";
        searchString=@"";
        transparancyTuchView.hidden=NO;
        [Array_NewReq removeAllObjects];
        [Array_AddReq removeAllObjects];
        [Array_Friends removeAllObjects];
        [Array_Allusers removeAllObjects];
        [Array_AddReq addObjectsFromArray:Array_Messages1];
        [Array_NewReq addObjectsFromArray:Array_Match1];
        [Array_Friends addObjectsFromArray:SearchCrickArray];
        [Array_Allusers addObjectsFromArray:SearchCrickArray_All];

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
        
        if ([_Str_newview isEqualToString:@"yes"])
        {
            
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
//            CreateChallengesViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateChallengesViewController"];
//            
//          
//                for (UIViewController *controller in self.navigationController.viewControllers)
//                {
//                    if ([controller isKindOfClass:[loginController class]])
//                    {
//                        
//                        [self.navigationController popToViewController:controller animated:YES];
//                        
//                        break;
//                    }
//                }
        }
        else
            {
                [Textfield_Search resignFirstResponder];
              [self.navigationController popViewControllerAnimated:YES];
            }
        
        
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
-(void)Button_Addfriends_alluser_Action:(id)sender
{
CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:Tableview_Friends];
NSIndexPath *indexPath = [Tableview_Friends indexPathForRowAtPoint:buttonPosition];
    
    userId_second=[[Array_Allusers objectAtIndex:indexPath.row]valueForKey:@"userid"];
    
    [self.view showActivityViewWithLabel:@"Requesting..."];
    [self ClientserverCommunicatioAddfrnd];
}
#pragma mark-Tableview Delegates.......



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        if ([FlagSearchBar isEqualToString:@"yes"])
        {
            return 0;
        }
        else
        {
           return Array_Title1.count;
        }
       
        
    }
    if(section==1)
    {
        
   return Array_NewReq.count;
        
    }
    if(section==2)
    {
   return Array_AddReq.count;
        
    }
    if(section==3)
    {
return Array_Allusers.count;
        
    }

    
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *mycellid2=@"CellReq";
    static NSString *cellId2=@"CellAddReq";
    static NSString *Cellid1=@"OneCell";
    static NSString *cellId4=@"Cellallusers";
            
            
            switch (indexPath.section)
        {
                
                
            case 0:
            {
                
                
                
             AccOneTableViewCell* onecell = (AccOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
                
                onecell.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
                onecell.layer.borderWidth=1.0f;
                onecell.LabelVal.text=[Array_Title1 objectAtIndex:indexPath.row];
                [onecell.image_View setImage:[UIImage imageNamed:[Array_Images objectAtIndex:indexPath.row]]];
                NSLog(@"Values===%@",[defaults valueForKey:@"makefriendswith"]);
                return onecell;
                
                
            }
                break;
            
            
            
            
        case 1:
        {

            cell_req = (FriendsReqTableViewCell*)[tableView dequeueReusableCellWithIdentifier:mycellid2 forIndexPath:indexPath];
            
            
            [cell_req.image_profile setFrame:CGRectMake(cell_req.image_profile.frame.origin.x, cell_req.image_profile.frame.origin.y, cell_req.image_profile.frame.size.width, cell_req.image_profile.frame.size.width)];
            
            cell_req.image_profile.clipsToBounds=YES;
            cell_req.image_profile.layer.cornerRadius=cell_req.image_profile.frame.size.height/2;
            
            
            cell_req.image_profile.tag=indexPath.row;
            cell_req.image_profile.userInteractionEnabled=YES;
            UITapGestureRecognizer *image_SecProfileTapped2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails11:)];
            [cell_req.image_profile addGestureRecognizer:image_SecProfileTapped2];
            
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
        case 2:
            
        {
           
                cell_addreq =(FriendAddReqTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
                
            
            NSURL *url=[NSURL URLWithString:[[Array_AddReq objectAtIndex:indexPath.row] valueForKey:@"friendprofilepic"]];
            
             cell_addreq.Image_GrayMinus.tag=indexPath.row;
            [cell_addreq.image_profile setFrame:CGRectMake(cell_addreq.image_profile.frame.origin.x, cell_addreq.image_profile.frame.origin.y, cell_addreq.image_profile.frame.size.width, cell_addreq.image_profile.frame.size.width)];
            
    cell_addreq.image_profile.clipsToBounds=YES;
            cell_addreq.image_profile.layer.cornerRadius=cell_addreq.image_profile.frame.size.height/2;
            
            
            cell_addreq.image_profile.tag=indexPath.row;
            cell_addreq.image_profile.userInteractionEnabled=YES;
            UITapGestureRecognizer *image_SecProfileTapped2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails22:)];
            [cell_addreq.image_profile addGestureRecognizer:image_SecProfileTapped2];
            
            
            
            
            
            
            
            
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
                
            case 3:
                
            {
                
    ProfileFriendasAlluserTableViewCell   * cell_alluser =(ProfileFriendasAlluserTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId4 forIndexPath:indexPath];
                
                CALayer *border = [CALayer layer];
                border.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
                
                border.frame = CGRectMake(0, cell_alluser.frame.size.height - 1, self.view.frame.size.width, 1);
                [cell_alluser.layer addSublayer:border];

//                friendstatus = no;
//                name = Tarek;
//                profilepic = "http://www.care2dareapp.com/app/profileimages/20170804142316AJ20.jpg";
//                userid = 20170804142316AJ20;
                
                
              NSURL *url=[NSURL URLWithString:[[Array_Allusers objectAtIndex:indexPath.row] valueForKey:@"profilepic"]];
                
             cell_alluser.image_Profile.tag=indexPath.row;
                
             [cell_alluser.image_Profile setFrame:CGRectMake(cell_alluser.image_Profile.frame.origin.x, cell_alluser.image_Profile.frame.origin.y, cell_alluser.image_Profile.frame.size.width, cell_alluser.image_Profile.frame.size.width)];
               cell_alluser.image_Profile.clipsToBounds=YES;
cell_alluser.image_Profile.layer.cornerRadius=cell_alluser.image_Profile.frame.size.height/2;
 [cell_alluser.image_Profile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
                
                cell_alluser.image_Profile.tag=indexPath.row;
                cell_alluser.image_Profile.userInteractionEnabled=YES;
                UITapGestureRecognizer *image_SecProfileTapped2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails2:)];
                [cell_alluser.image_Profile addGestureRecognizer:image_SecProfileTapped2];
                cell_alluser.Button_Addfriend1.tag=indexPath.row;
                 cell_alluser.Button_Addfriend2.tag=indexPath.row;
                
        if ([[[Array_Allusers objectAtIndex:indexPath.row] valueForKey:@"friendstatus"] isEqualToString:@"no"])
        {
            cell_alluser.Button_Addfriend1.hidden=NO;
            cell_alluser.Button_Addfriend1.enabled=YES;
           // cell_alluser.Button_Addfriend2.enabled=YES;
            cell_alluser.Button_Addfriend2.userInteractionEnabled=YES;
            [cell_alluser.Button_Addfriend1 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [cell_alluser.Button_Addfriend2 setImage:[UIImage imageNamed:@"addfriend.png"] forState:UIControlStateNormal];
                    
            [cell_alluser.Button_Addfriend1 addTarget:self action:@selector(Button_Addfriends_alluser_Action:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell_alluser.Button_Addfriend2 addTarget:self action:@selector(Button_Addfriends_alluser_Action:) forControlEvents:UIControlEventTouchUpInside];
            
                }
                else
                {
                    cell_alluser.Button_Addfriend1.hidden=YES;
                   cell_alluser.Button_Addfriend1.enabled=NO;
                 //  cell_alluser.Button_Addfriend2.enabled=NO;
                    cell_alluser.Button_Addfriend2.userInteractionEnabled=NO;
                    cell_alluser.Button_Addfriend2.alpha=1.0f;
                   [cell_alluser.Button_Addfriend2 setImage:[UIImage imageNamed:@"friendrequested.png"] forState:UIControlStateNormal];
                }
                
              NSString *textfname=[[Array_Allusers objectAtIndex:indexPath.row] valueForKey:@"name"];
                if (searchString.length==0)
                {
                    
                  cell_alluser.Label_name.text=[[Array_Allusers objectAtIndex:indexPath.row] valueForKey:@"name"];
                    
                    cell_alluser.Label_name.textColor=[UIColor lightGrayColor];
                    
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
                        
                        cell_alluser.Label_name.attributedText=mutableAttributedStringfname;
                    }
                    else
                    {
                        
                        
                        
                        cell_alluser.Label_name.text=[[Array_Allusers objectAtIndex:indexPath.row] valueForKey:@"name"];
                    FlagSearchBar=@"no";
                        
                    }
                    
                }
 
              return cell_alluser;
                
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
    
//    [sectionView setBackgroundColor:[UIColor whiteColor]];
//  
//    Label1.backgroundColor=[UIColor whiteColor];
//    Label1.textColor=[UIColor lightGrayColor];
    
    
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"Invite";
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
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
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
    if (section==2)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
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
//    if (section==3)
//    {
//        
//        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
//        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
//        
//        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
//        Label1.backgroundColor=[UIColor clearColor];
//        Label1.textColor=[UIColor lightGrayColor];
//        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
//        Label1.text=@"Friends";
//        [sectionView addSubview:Label1];
//        
//        CALayer*  borderBottom_topheder = [CALayer layer];
//        borderBottom_topheder.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
//        borderBottom_topheder.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width,1);
//        [sectionView.layer addSublayer:borderBottom_topheder];
//        
//        sectionView.tag=section;
//        
//    }
    if (section==3)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, self.view.frame.size.width-40, sectionView.frame.size.height-5)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"All users";
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
        if ([FlagSearchBar isEqualToString:@"yes"])
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
        if (Array_NewReq.count==0)
        {
            return 0;
        }
        else
        {
            return 44;
        }
    }
    if (section==2)
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
    if(section==3)
   {
       if (Array_Allusers.count==0)
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
    if (indexPath.section==0)
    {
        
        if (indexPath.row==0)
        {
            //contact list msg sends
            //    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
            ////    if([MFMessageComposeViewController canSendText])
            ////    {
            //        controller.body = @"Hello  sachin mokashi";
            //       // controller.recipients = [NSArray arrayWithObjects:@"+918237499204", nil];
            //
            //  controller.recipients = [NSArray arrayWithObjects:@"8850519524", @"8237499204", nil];
            //        controller.messageComposeDelegate = self;
            //           [self presentModalViewController:controller animated:YES];
            // }
            
            // facebook freindsintigration
            
            //                FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
            //                NSString *urlString = @"https://fb.me/1317286481660217";
            //                content.appLinkURL = [NSURL URLWithString:urlString];
            //                [FBSDKAppInviteDialog showWithContent:content delegate:self];
            
            
            if (![[defaults valueForKey:@"SettingLogin"]isEqualToString:@"FACEBOOK"] ||[[defaults valueForKey:@"SettingLogin"]isEqualToString:@"EMAIL"])
            {
                if ([[defaults valueForKey:@"facebookconnect"]isEqualToString:@"yes"])
                {
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    FacebookListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FacebookListViewController"];
                    [self.navigationController pushViewController:set animated:YES];
                }
                else
                {
                    [self logingWithFB];
                }
            }
            else
            {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                FacebookListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FacebookListViewController"];
                [self.navigationController pushViewController:set animated:YES];
            }
        }
        
        if (indexPath.row==1)
        {
            if (![[defaults valueForKey:@"SettingLogin"]isEqualToString:@"TWITTER"] ||[[defaults valueForKey:@"SettingLogin"]isEqualToString:@"EMAIL"])
            {
                if ([[defaults valueForKey:@"twitterconnect"]isEqualToString:@"yes"])
                {
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    TwitterListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"TwitterListViewController"];
                    [self.navigationController pushViewController:set animated:YES];
                }
                else
                {
                    [self loginWithTW];
                }
            }
            else
            {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                TwitterListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"TwitterListViewController"];
                [self.navigationController pushViewController:set animated:YES];
            }
            
        }
        
        if (indexPath.row==2)
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ContactListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"ContactListViewController"];
            [self.navigationController pushViewController:set animated:YES];
            
        }
        
    }
  
}
-(void)loginWithTW
{
    
    
    [self.view showActivityViewWithLabel:@"Loading"];
    
    /*   [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
     if (session) {
     NSLog(@"signed in as %@", [session userName]);
     
     } else {
     NSLog(@"error: %@", [error localizedDescription]);
     }
     }];
     */
    
    [[Twitter sharedInstance] logInWithMethods:TWTRLoginMethodWebBased completion:^(TWTRSession *session, NSError *error)
     {
         if (session)
         {
             
             NSLog(@"signed in as %@", [session userName]);
             NSLog(@"signed in as %@", session);
             
             TWTRAPIClient *client = [TWTRAPIClient clientWithCurrentUser];
             NSURLRequest *request = [client URLRequestWithMethod:@"GET"
                                                              URL:@"https://api.twitter.com/1.1/account/verify_credentials.json"
                                                       parameters:@{@"include_email": @"true", @"skip_status": @"true"}
                                                            error:nil];
             
             //@"https://api.twitter.com/1.1/users/show.json";
             
             
             [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError)
              {
                  NSLog(@"datadata in as %@", data);
                  NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                  NSLog(@"ResultString in as %@", ResultString);
                  NSMutableDictionary *  Array_sinupFb=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                  
                  NSLog(@"Array_sinupFbArray_sinupFb in as %@", Array_sinupFb);
                  NSLog(@"emailemail in as %@", [Array_sinupFb valueForKey:@"email"]);
                  NSLog(@"location in as %@", [Array_sinupFb valueForKey:@"location"]);
                  NSLog(@"name in as %@", [Array_sinupFb valueForKey:@"name"]);
                  nameFb=[Array_sinupFb valueForKey:@"name"];
                  emailFb=[Array_sinupFb valueForKey:@"email"];
                  Fbid= [session userID];
                  [defaults setObject:Fbid forKey:@"twitterid"];
                  [defaults setObject:Fbid forKey:@"twitterids"];
                  [defaults synchronize];
                  regTypeVal =@"TWITTER";
                  
                  
                  
                  [self TwitterFriendsList];
                  
                  //         [self FbTwittercommunicationServer];
                  
              }];
             
             
             
         } else
         {
             NSLog(@"error: %@", [error localizedDescription]);
             [self.view hideActivityViewWithAfterDelay:0];
         }
     }];
    
}
-(void)TwitterFriendsList
{
    
    
    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:Fbid];
    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/friends/ids.json";
    NSDictionary *params = @{@"id" : Fbid};
    NSError *clientError;
    
    NSURLRequest *request = [client URLRequestWithMethod:@"GET" URL:statusesShowEndpoint parameters:params error:&clientError];
    
    if (request) {
        [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                // handle the response data e.g.
                NSError *jsonError;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                NSArray *json22=[json objectForKey:@"ids"];
                
                
                NSLog(@"jsonjson: %d",json22.count);
                
                Str_fb_friend_id=[json22 componentsJoinedByString:@","];
                Str_fb_friend_id_Count=[NSString stringWithFormat:@"%d",json22.count];
                NSLog(@"Str_fb_friend_id: %@",Str_fb_friend_id);
                NSLog(@"jsonjson: %@",json22);
                
                [self FbTwittercommunicationServer];
            }
            else
            {
                NSLog(@"Error: %@", connectionError);
                
                [self TwitterFriendsList];
            }
        }];
    }
    else
    {
        NSLog(@"Error: %@", clientError);
        
        [self TwitterFriendsList];
    }
    
    
    
}
-(void)logingWithFB
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        //        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        message.tag=100;
        //        [message show];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2Dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
    else
    {
        [self.view showActivityViewWithLabel:@"Loading"];
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        
        
        
        [login logInWithReadPermissions: @[@"public_profile", @"email",@"user_friends"]
                     fromViewController:self
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
         {
             NSLog(@"Process result=%@",result);
             NSLog(@"Process error=%@",error);
             if (error)
             {
                 [self.view hideActivityViewWithAfterDelay:0];
                 
                 NSLog(@"Process error");
             }
             else if (result.isCancelled)
             {
                 [self.view hideActivityViewWithAfterDelay:0];
                 
                 NSLog(@"Cancelled");
             }
             else
             {
                 
                 
                 NSLog(@"Logged in");
                 NSLog(@"Process result123123=%@",result);
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,friends,name,first_name,last_name,gender,email,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         if ([result isKindOfClass:[NSDictionary class]])
                         {
                             NSLog(@"Results=%@",result);
                             emailFb=[result objectForKey:@"email"];
                             Fbid=[result objectForKey:@"id"];
                             nameFb=[result objectForKey:@"name"];
                             
                             
                             
                             NSArray * allKeys = [[result valueForKey:@"friends"]objectForKey:@"data"];
                             
                             fb_friend_id  =  [[NSMutableArray alloc]init];
                             
                             for (int i=0; i<[allKeys count]; i++)
                             {
                                 [fb_friend_id addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"id"]];
                                 
                             }
                             Str_fb_friend_id_Count=[NSString stringWithFormat:@"%d",fb_friend_id.count];
                             Str_fb_friend_id=[fb_friend_id componentsJoinedByString:@","];
                             ;
                             regTypeVal =@"FACEBOOK";
                             [defaults setObject:Fbid forKey:@"facebookid"];
                             [defaults synchronize];
                             [self FbTwittercommunicationServer];
                             
                         }
                         
                         
                     }
                 }];
                 
             }
             
         }];
    }
    
    
}

#pragma mark-PHP Connection


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
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid1,useridval1,userid2,userId_second];
        
        
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
                                                     
                                                     
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                    
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                [self.view hideActivityViewWithAfterDelay:0];
                                                     NSLog(@"Array_AllData ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"requested"])
                                                     {
                                                         
                                    [self Communication_listallusers];
                                                         
                                                         
                                                     }
                                                     
                                                     
                                                 }
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     
                                                 }
                                             }
                                             else if(error)
                                             {
                                                 [self.view hideActivityViewWithAfterDelay:0];
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                         }];
        [dataTask resume];
    }
    
}
-(void)FbTwittercommunicationServer
{
    
    
    
    //   [self.view showActivityViewWithLabel:@"Loading"];
    
    NSString *userid= @"userid";
    NSString *useridval =[defaults valueForKey:@"userid"];
    
    NSString *email= @"email";
    
    NSString *fbid1;
    
    if ([regTypeVal isEqualToString:@"FACEBOOK"])
    {
        fbid1= @"fbid";
    }
    else
    {
        fbid1= @"twitterid";
    }
    
    NSString *regType= @"regtype";
    
    NSString *friendlist= @"friendlist";
    NSString *friendlistval =[NSString stringWithFormat:@"%@",Str_fb_friend_id];
    
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,Fbid,email,emailFb,regType,regTypeVal,userid,useridval,friendlist,friendlistval];
    
    
    

    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"connect_fb_twitter"];;
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
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                                                 if ([ResultString isEqualToString:@"error"])
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve one of the Account Ids. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                     
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"anotheruser"])
                                                 {
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You already have another account linked with us. Please login through that or delete that account." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                 }
                                                 if ([ResultString isEqualToString:[defaults valueForKey:@"facebookid"]])
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     if ([regTypeVal isEqualToString:@"FACEBOOK"])
                                                     {
                                                         UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                         FacebookListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"FacebookListViewController"];
                                                         [self.navigationController pushViewController:set animated:YES];
                                                         [defaults setObject:@"yes" forKey:@"facebookconnect"];
                                                         [defaults synchronize];
                                                         
                                                     }
                                                 }
                                                 if ([ResultString isEqualToString:[defaults valueForKey:@"twitterids"]])
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     if ([regTypeVal isEqualToString:@"TWITTER"])
                                                     {
                                                         UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                         TwitterListViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"TwitterListViewController"];
                                                         [self.navigationController pushViewController:set animated:YES];
                                                         [defaults setObject:@"yes" forKey:@"twitterconnect"];
                                                         [defaults synchronize];
                                                     }
                                                 }
                                                 
                                                 
                                             }
                                             
                                             else
                                             {
                                                 NSLog(@" error login1 ---%ld",(long)statusCode);
                                                 [self.view hideActivityViewWithAfterDelay:0];
                                             }
                                             
                                             
                                         }
                                         else if(error)
                                         {
                                             [self.view hideActivityViewWithAfterDelay:0];
                                             NSLog(@"error login2.......%@",error.description);
                                         }
                                         
                                         
                                     }];
    [dataTask resume];
    
}
-(void)Communication_listallusers
{
    
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
        
        
        NSString *userid1= @"userid";
        NSString *useridval1= [defaults valueForKey:@"userid"];
        
      
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",userid1,useridval1];
        
   
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"listallusers"];;
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
                                                     
        Array_Allusers=[[NSMutableArray alloc]init];
    SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_Allusers=[objSBJsonParser objectWithData:data];
                                                     
                NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                if ([ResultString isEqualToString:@"nouserid"])
                                {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                     }
                                                     if ([ResultString isEqualToString:@"nousers"])
                                                     {
                                                       
                                                     }
                                                     
                                                     if (Array_Allusers.count !=0)
                                                     {
                                SearchCrickArray_All=[Array_Allusers mutableCopy];
                                [Tableview_Friends reloadData];
                                                         
                                                     
                                                     }
                    
                            [self.view hideActivityViewWithAfterDelay:0];
                                                 }
                                                 else
                                                 {
                    [self.view hideActivityViewWithAfterDelay:0];
                        NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                             }
                                             else if(error)
                                             {
                                                 [self.view hideActivityViewWithAfterDelay:0];
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                         }];
        [dataTask resume];
    }
    
}
-(void)ClientserverCommFriends
{
    
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
        Array_NewReq=[[NSMutableArray alloc]init];
        Array_AddReq=[[NSMutableArray alloc]init];
       
                
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
                    Array_Messages1=[Array_AddReq mutableCopy];
                    Array_Match1=[Array_NewReq mutableCopy];

                    
                     indicator.hidden=YES;
                    [indicator stopAnimating];
                     Label_result.hidden=YES;
                    Tableview_Friends.hidden=NO;
                [Tableview_Friends reloadData];
                }
                
        if (Array_Friends.count !=0)
              {
       
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
                   [indicator stopAnimating];
                  SearchCrickArray=[Array_Friends mutableCopy];
                 
                  Array_Messages1=[Array_AddReq mutableCopy];
                  Array_Match1=[Array_NewReq mutableCopy];

       [Tableview_Friends reloadData];
                                                         
                }
                [self.view hideActivityViewWithAfterDelay:0];
                }
            else
            {
                 [self.view hideActivityViewWithAfterDelay:0];
        NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                    }
                }
        else if(error)
            {
                 [self.view hideActivityViewWithAfterDelay:0];
          NSLog(@"error login2.......%@",error.description);
            }
       }];
        [dataTask resume];
    }
    
}
#pragma mark-Images gesture_action...
-(void)image_SecProfile_ActionDetails11:(UIGestureRecognizer *)reconizer
{
  
    
    NSLog(@"Useridd11==%@",[[Array_NewReq objectAtIndex:0] valueForKey:@"challengersuserid3"]);
    
    UIImageView *imageView = (UIImageView *)reconizer.view;
    
    
    ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
    set.userId_prof=[NSString stringWithFormat:@"%@",[[Array_NewReq objectAtIndex:(long)imageView.tag]valueForKey:@"frienduserid"]];
    
    set.user_name=[NSString stringWithFormat:@"%@",[[Array_NewReq objectAtIndex:(long)imageView.tag]valueForKey:@"friendname"]];
    
    set.user_imageUrl=[NSString stringWithFormat:@"%@",[[Array_NewReq objectAtIndex:(long)imageView.tag]valueForKey:@"friendprofilepic"]];
    
    // set.Images_data=cell_TwoDetails.image_SecProfile2;
    [self.navigationController pushViewController:set animated:YES];
    
    
}
-(void)image_SecProfile_ActionDetails22:(UIGestureRecognizer *)reconizer
{

    
    NSLog(@"Useridd11==%@",[[Array_AddReq objectAtIndex:0] valueForKey:@"challengersuserid3"]);
    
    UIImageView *imageView = (UIImageView *)reconizer.view;
    
    
    ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
    set.userId_prof=[NSString stringWithFormat:@"%@",[[Array_AddReq objectAtIndex:(long)imageView.tag]valueForKey:@"frienduserid"]];
    
    set.user_name=[NSString stringWithFormat:@"%@",[[Array_AddReq objectAtIndex:(long)imageView.tag]valueForKey:@"friendname"]];
    
    set.user_imageUrl=[NSString stringWithFormat:@"%@",[[Array_AddReq objectAtIndex:(long)imageView.tag]valueForKey:@"friendprofilepic"]];
    
    // set.Images_data=cell_TwoDetails.image_SecProfile2;
    [self.navigationController pushViewController:set animated:YES];
    
    
}
-(void)image_SecProfile_ActionDetails2:(UIGestureRecognizer *)reconizer
{
    NSLog(@"Useridd11==%@",[defaults valueForKey:@"userid"]);
    
    NSLog(@"Useridd11==%@",[[Array_Allusers objectAtIndex:0] valueForKey:@"challengersuserid3"]);
    
    UIImageView *imageView = (UIImageView *)reconizer.view;
   
   
        ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
        set.userId_prof=[NSString stringWithFormat:@"%@",[[Array_Allusers objectAtIndex:(long)imageView.tag]valueForKey:@"userid"]];
        
        set.user_name=[NSString stringWithFormat:@"%@",[[Array_Allusers objectAtIndex:(long)imageView.tag]valueForKey:@"name"]];
        
        set.user_imageUrl=[NSString stringWithFormat:@"%@",[[Array_Allusers objectAtIndex:(long)imageView.tag]valueForKey:@"profilepic"]];
        
        // set.Images_data=cell_TwoDetails.image_SecProfile2;
        [self.navigationController pushViewController:set animated:YES];
    
    
}
-(void)Image_RedMinustapped_Action:(UIGestureRecognizer *)sender
{
UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);
    useridval2=[[Array_NewReq objectAtIndex:imageView.tag]valueForKey:@"frienduserid"];
    string_Actiontype=@"DELETE";
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirm" message:@"Are you sure you want to deny this friend request?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Yes"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   [self.view showActivityViewWithLabel:@"Removing..."];
                                 [self ClientserverCommFriends];
                               }];
    UIAlertAction *actioncancel = [UIAlertAction actionWithTitle:@"No"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   
                               }];
    
    [alertController addAction:actionOk];
    [alertController addAction:actioncancel];

    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
}
-(void)Image_BlueMinusTapped_action:(UIGestureRecognizer *)sender
{
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSLog(@"indextuches1Friendss==:==%ld", (long)imageView.tag);
 [self.view showActivityViewWithLabel:@"Accepting..."];
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
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirm" message:@"Are you sure you want to unfriend your friend?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Yes"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                    [self.view showActivityViewWithLabel:@"Removing..."];
                                 [self ClientserverCommFriends];
                               }];
    UIAlertAction *actioncancel = [UIAlertAction actionWithTitle:@"No"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
    
    [alertController addAction:actionOk];
    [alertController addAction:actioncancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
   
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
         [Array_Allusers removeAllObjects];
        
        [Array_AddReq addObjectsFromArray:Array_Messages1];
        [Array_NewReq addObjectsFromArray:Array_Match1];
        [Array_Friends addObjectsFromArray:SearchCrickArray];
        [Array_Allusers addObjectsFromArray:SearchCrickArray_All];
        
        
    }
    else
        
    {
         FlagSearchBar=@"yes";
        transparancyTuchView.hidden=YES;
        
        [Array_AddReq removeAllObjects];
        [Array_NewReq removeAllObjects];
        [Array_Friends removeAllObjects];
        [Array_Allusers removeAllObjects];
        
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
        
        for (NSDictionary *book in SearchCrickArray_All)
        {
            NSString * string=[book objectForKey:@"name"];
            
            NSRange r=[string rangeOfString:Textfield_Search.text options:NSCaseInsensitiveSearch];
            
            if (r.location !=NSNotFound )
            {
                searchString=Textfield_Search.text;
                [Array_Allusers addObject:book];
                
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
