//
//  RaisedContributeViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "RaisedContributeViewController.h"
#import "UIImageView+WebCache.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "ContributeMoneyViewController.h"
#import "ProfilePageDetailsViewController.h"
@interface RaisedContributeViewController ()
{
    UIView *sectionView;
    UIScrollView * scrollView;
     NSDictionary *urlplist;
    CGFloat Xpostion, Ypostion, Xwidth, Yheight, ScrollContentSize,Xpostion_label, Ypostion_label, Xwidth_label, Yheight_label;
     CGRect scrollFrame;
   
    NSMutableArray * Array_raised,* Array_Backer,*Array_Challengers;
    NSUserDefaults * defaults;
    CALayer *borderBottom_SectionView1,*borderBottom_SectionView2,*borderBottom_SectionView3,*borderBottom_SectionView4;
    UIView * IndicatorView;
    
    UIActivityIndicatorView * indicator;
}
@end


@implementation RaisedContributeViewController
@synthesize view_Topheader,Label_RaisedAmt,cell_one,cell_two,cell_Four,cell_three,Tableview_Raised,Str_Channel_Id,Str_Raised_Amount,Label_PayTopheader,Image_PayTopheader,Str_Raised_StartDateTime,Label_Resultserver,indicatorView,Str_DonateRaisedType,Str_ChallengecompleteType;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults=[[NSUserDefaults alloc]init];
     borderBottom_SectionView1 = [CALayer layer];
     borderBottom_SectionView2 = [CALayer layer];
     borderBottom_SectionView3 = [CALayer layer];
     borderBottom_SectionView4 = [CALayer layer];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    CALayer * borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
//    NSLog(@"AllArrayData=%@",AllArrayData);;
//    Label_RaisedAmt.text=[NSString stringWithFormat:@"%@%@",@"Raised: $",[[AllArrayData objectAtIndex:0] valueForKey:@"backamount"]];
   
    
    Xpostion=12;
    Ypostion=7;
    Xwidth=60;
    Yheight=60;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=67;
    Xwidth_label=60;
    Yheight_label=20;
    
    
    indicatorView.hidden=NO;
    Label_Resultserver.hidden=YES;
    [indicatorView startAnimating];
    
    self.sendButton.userInteractionEnabled = NO;
    self.sendButton.hidden=NO;
    self.sendButton.enabled=NO;
    self.placeholderLabel.hidden=NO;
    [self.sendButton setBackgroundColor:[UIColor lightGrayColor]];//colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]];
    self.sendButton.layer.cornerRadius=self.sendButton.frame.size.height/2;
    self.sendButton.frame=CGRectMake((self.view.frame.size.width-self.sendButton.frame.size.width)-4, self.sendButton.frame.origin.y,self.sendButton.frame.size.width, self.sendButton.frame.size.height);
    
    self.BlackViewOne.frame=CGRectMake(self.view.frame.size.width,self.BlackViewOne.frame.origin.y,self.BlackViewOne.frame.size.width, self.BlackViewOne.frame.size.height);
    
    
    
    
    
    
    
    
    
    self.ImageGalButton.userInteractionEnabled = YES;
    _ImageGalButton.hidden=NO;
    _ImageGalButton.enabled=YES;
    [self.ImageGalButton setBackgroundColor:[UIColor clearColor]];
    
    
    Label_RaisedAmt.text=[NSString stringWithFormat:@"%@%@",@"Raised: $",Str_Raised_Amount];
    
   
    //    SendButton.hidden=YES;
    //    SendButton.layer.cornerRadius=8.0f;

    Tableview_Raised.hidden=YES;
    
   
   
    
     indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    [indicator startAnimating];
    indicator.color=[UIColor darkGrayColor];
    indicator.center = self.view.center;
    indicator.hidden=NO;
    Image_PayTopheader.userInteractionEnabled=YES;
    UITapGestureRecognizer * Image_Pay_Tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_Pay_Action:)];
    [Image_PayTopheader addGestureRecognizer:Image_Pay_Tapped];
    
        Label_PayTopheader.userInteractionEnabled=YES;
    
    UITapGestureRecognizer * Label_Pay_Tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_Pay_Action:)];
    [Label_PayTopheader addGestureRecognizer:Label_Pay_Tapped];
    
    
    
    Image_PayTopheader.hidden=YES;
    Label_PayTopheader.hidden=YES;
    
    [self Communicaion_Raised];
  
}
-(void)Image_Pay_Action:(UIGestureRecognizer *)reconizer
{
    if (Array_Challengers.count !=0)
    {
        ContributeMoneyViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeMoneyViewController"];
        set.total_players=[NSString stringWithFormat:@"%lu",(unsigned long)Array_Challengers.count ];
        set.Str_DonateRaisedTypePlayer=Str_DonateRaisedType;
        set.challengerID=Str_Channel_Id;
        [self.navigationController pushViewController:set animated:YES];
    }
   
}
-(void)Communicaion_Raised
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
        
        
       
        NSString *challengeid= @"challengeid";
   
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",challengeid,Str_Channel_Id];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"raised"];;
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
    Array_raised=[[NSMutableArray alloc]init];
      
    SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
    Array_raised=[objSBJsonParser objectWithData:data];
     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    if(Array_raised.count !=0)
        {
            indicator.hidden=YES;
            Tableview_Raised.hidden=NO;
            
            Array_Backer=[[NSMutableArray alloc]init];
            Array_Challengers=[[NSMutableArray alloc]init];
            for (int i=0; i<Array_raised.count; i++)
            {
                if ([[[Array_raised objectAtIndex:i]valueForKey:@"arraytype"]isEqualToString:@"backers"])
                {
                    [Array_Backer addObject:[Array_raised objectAtIndex:i]];
                }
                else
                {
                 [Array_Challengers addObject:[Array_raised objectAtIndex:i]];
                }
                
            }
            if (Array_Challengers.count !=0)
            {
                
                if ([Str_ChallengecompleteType isEqualToString:@"COMPLETE"])
                {
                    Image_PayTopheader.hidden=YES;
                    Label_PayTopheader.hidden=YES;
                }
                else
                {
                    Image_PayTopheader.hidden=NO;
                    Label_PayTopheader.hidden=NO;
                }

            }
            else
            {
                Image_PayTopheader.hidden=YES;
                Label_PayTopheader.hidden=YES;
            }
            [Tableview_Raised reloadData];
            NSLog(@"Backers Array==%@",Array_Backer);
             NSLog(@"Challengers Array==%@",Array_Challengers);
            indicatorView.hidden=YES;
            Label_Resultserver.hidden=YES;
            [indicatorView stopAnimating];
        }
                         else
                         {
                             indicatorView.hidden=YES;
                             Label_Resultserver.hidden=NO;
                             [indicatorView stopAnimating];
                         }
                         ResultString=nil;
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


-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:YES];
    Xpostion=12;
    Ypostion=7;
    Xwidth=60;
    Yheight=60;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=67;
    Xwidth_label=60;
    Yheight_label=20;
    indicator.hidden=YES;
     [indicator stopAnimating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)ButtonBack_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    if (section==0)
    {
        return 1;
    }
    if (section==1)
    {
         return 1;
    }
    if (section==2)
    {
         return Array_Backer.count+1;
    }
//    if (section==3)
//    {
//        return 80;//Array_Backer.count;
//    }
    
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 88;
    }
    if (indexPath.section==1)
    {
        return 88;
    }
    if (indexPath.section==2)
    {
        return 48;
    }
//    if (indexPath.section==3)
//    {
//        return 48;
//    }
    

    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid1=@"Cellone";
    static NSString *cellId2=@"Celltwo";
    static NSString *cellId3=@"Cellthree";
    static NSString *cellId4=@"Cellfour";
    
    
    
    switch (indexPath.section)
    {
            
            
        case 0:
        {
            
            
            
            cell_one = (RaisedoneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellid1 forIndexPath:indexPath];
            

            
//            CALayer *borderBottomViewTap6 = [CALayer layer];
//            borderBottomViewTap6.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
//            borderBottomViewTap6.frame = CGRectMake(0, cell_one.myscrollView.frame.size.height - 1, cell_one.myscrollView.frame.size.width, 1);
//            [cell_one.myscrollView.layer addSublayer:borderBottomViewTap6];
            
            for (int i=0; i<Array_Challengers.count; i++)
            {
                
                UIImageView * Imagepro = [[UIImageView alloc] initWithFrame:CGRectMake(Xpostion, Ypostion, Xwidth, Yheight)];
                UILabel * Label_name = [[UILabel alloc] initWithFrame:CGRectMake(Xpostion, Ypostion_label, Xwidth, Yheight_label)];
                
                
                Imagepro.userInteractionEnabled=YES;
                
                [Imagepro setTag:i];
                
                Imagepro.contentMode=UIViewContentModeScaleAspectFill;
                UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(ImageTapped_profile:)];
                [Imagepro addGestureRecognizer:ImageTap];
                
                
                Imagepro.clipsToBounds=YES;
                Imagepro.layer.cornerRadius=Imagepro.frame.size.height/2;
                [Imagepro setBackgroundColor:[UIColor clearColor]];
                Label_name.backgroundColor=[UIColor clearColor];
                Label_name.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                //                [Imagepro setImage:[UIImage imageNamed:[Array_Match objectAtIndex:i]]];
                
                Label_name.text=[[Array_Challengers objectAtIndex:i] valueForKey:@"challengersname"];
                
                Label_name.font = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14]; //custom font
//                Label_name.numberOfLines = 1;
//                Label_name.adjustsFontSizeToFitWidth=YES;
//                Label_name.minimumScaleFactor=0.5;
                //                Label_name.baselineAdjustment = YES;
                //                Label_name.adjustsFontSizeToFitWidth = YES;
                //                Label_name.adjustsLetterSpacingToFitWidth = YES;
                
                Label_name.textAlignment=NSTextAlignmentCenter;
                
                [cell_one.myscrollView addSubview:Label_name];
                [cell_one.myscrollView addSubview:Imagepro];
                
                
                
                NSURL * url=[[Array_Challengers objectAtIndex:i]valueForKey:@"challengersprofilepic"];
              
                    
                    
                    [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                    
              
                
                
                
                Xpostion+=Xwidth+20;
                //Xpostion_label+=Xwidth_label+12;
                
                ScrollContentSize+=Xwidth;
                cell_one.myscrollView.contentSize=CGSizeMake(Xpostion, 88);
            }
            Xpostion=12;
            Ypostion=7;
            Xwidth=60;
            Yheight=60;
            ScrollContentSize=0;
            Xpostion_label=12;
            Ypostion_label=67;
            Xwidth_label=60;
            Yheight_label=20;
//            if (Array_Challengers==0)
//            {
//                cell_one.Label_Noresult.hidden=NO;
//            }
//            else
//            {
//                cell_one.Label_Noresult.hidden=YES;
//            }
            
             return cell_one;
            
            
        }
            break;
        case 1:
            
        {
            cell_two = (RaisedTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
//            cell_two.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
//            cell_two.layer.borderWidth=1.0f;
            
            
            return cell_two;
            
        }
            break;
            
            
            
//        case 2:
//            
//        {
//            
//            
//            cell_three = (RaisedThreeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId3 forIndexPath:indexPath];
//            
//            
//            
////            cell_three.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
////            cell_three.layer.borderWidth=1.0f;
//            
//           
//            
//            
//            return cell_three;
//            
//        }
//            
//            break;
            
        case 2:
            
        {
            
            
            cell_Four = (RaisedFourTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId4 forIndexPath:indexPath];
            
            cell_Four.label_name.tag=indexPath.row;
            cell_Four.label_RaisedAmt.tag=indexPath.row;
            cell_Four.Image_likes.tag=indexPath.row;
            cell_Four.Image_Profile.tag=indexPath.row;
            cell_Four.Image_LikesProf.tag=indexPath.row;
            cell_Four.Button_likesProf.tag=indexPath.row;
            
            if (indexPath.row==0)
            {
                cell_Four.label_name.hidden=YES;
                cell_Four.label_RaisedAmt.hidden=YES;
                cell_Four.Image_likes.hidden=YES;
                cell_Four.Image_Profile.hidden=YES;
                cell_Four.Image_LikesProf.hidden=NO;
                cell_Four.Button_likesProf.hidden=NO;
                [cell_Four.Button_likesProf setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)Array_Backer.count] forState:UIControlStateNormal];
            }
            else
            {
                
                
                cell_Four.label_name.hidden=NO;
                cell_Four.label_RaisedAmt.hidden=NO;
                cell_Four.Image_likes.hidden=NO;
                cell_Four.Image_Profile.hidden=NO;
                cell_Four.Image_LikesProf.hidden=YES;
                cell_Four.Button_likesProf.hidden=YES;
                
                NSDictionary * dict=[Array_Backer objectAtIndex:indexPath.row-1];
        cell_Four.label_name.text=[dict valueForKey:@"backersname"];
        cell_Four.label_RaisedAmt.text=[NSString stringWithFormat:@"%@%@",@"$",[dict valueForKey:@"totalpledge"]];
            
            
            NSURL * url=[dict valueForKey:@"backersprofilepic"];
            [cell_Four.Image_Profile sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
            
            
            if([[dict valueForKey:@"backeruserid"]isEqualToString:[defaults valueForKey:@"userid"]])
            {
             
                cell_Four.label_name.textColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
                cell_Four.label_RaisedAmt.textColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
            }
            else
            {
               
                cell_Four.label_name.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
                cell_Four.label_RaisedAmt.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
            }
            
            
            
            cell_Four.Image_likes.tag=indexPath.row;
            if(indexPath.row==1)
            {
                cell_Four.Image_likes.hidden=NO;
                cell_Four.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:0.2];
            }
            else
            {
             cell_Four.Image_likes.hidden=YES;
                cell_Four.backgroundColor=[UIColor whiteColor];
            }
            }
            return cell_Four;
            
        }
            
            break;
            
    }
  //  return nil;
    abort();
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
      
        borderBottom_SectionView2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_SectionView2.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width, 1);
        [sectionView.layer addSublayer:borderBottom_SectionView2];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
      //  Label1.text=@"Challenged on:";
//        Label1.text=[NSString stringWithFormat:@"%@%@",@"Challenged on: ",Str_Raised_StartDateTime];
        

        
      
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *dte = [dateFormat dateFromString:Str_Raised_StartDateTime];
        [dateFormat setDateFormat:@"EEE, MMM d, yyyy"];
        
        NSLog(@"Date format saecond %@",[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte]]);
        NSString *str_Date=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:dte]];
        
            NSString *myString = [NSString stringWithFormat:@"%@%@",@"Challenged on: ",str_Date];
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
            NSRange range = [myString rangeOfString:str_Date];
            [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0] range:range];
        NSRange range1 = [myString rangeOfString:str_Date];
        [attString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:15.0f] range:range1];
        
        Label1.attributedText=attString;
        
        
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }
    if (section==1)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"My charities";
        [sectionView addSubview:Label1];
        
          sectionView.tag=section;
        borderBottom_SectionView3.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_SectionView3.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width, 1);
        [sectionView.layer addSublayer:borderBottom_SectionView3];
        
      
        
    }
    if (section==2)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        borderBottom_SectionView4.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_SectionView4.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width, 1);
        [sectionView.layer addSublayer:borderBottom_SectionView4];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"Supporters";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
        
    }
    
//   if (section==3)
//    {
//    
//    
//    }
//    
    
    return  sectionView;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
            return 40;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)ImageTapped_profile:(UIGestureRecognizer *)reconizer
{
    UIGestureRecognizer *recognizer1 = (UIGestureRecognizer*)reconizer;
    UIImageView *imageView = (UIImageView *)recognizer1.view;
    
    if([[defaults valueForKey:@"userid"] isEqualToString:[[Array_Challengers objectAtIndex:(long)imageView.tag] valueForKey:@"challengeruserid"]])
    {
        
    }
    else
    {
        ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
        set.userId_prof=[NSString stringWithFormat:@"%@",[[Array_Challengers objectAtIndex:(long)imageView.tag]valueForKey:@"challengeruserid"]];
        
        set.user_name=[NSString stringWithFormat:@"%@",[[Array_Challengers objectAtIndex:(long)imageView.tag]valueForKey:@"challengersname"]];
        
        set.user_imageUrl=[NSString stringWithFormat:@"%@",[[Array_Challengers objectAtIndex:(long)imageView.tag]valueForKey:@"challengersprofilepic"]];
        
//        set.Images_data=imageView;
        [self.navigationController pushViewController:set animated:YES];
    }
    
}
@end
