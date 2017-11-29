//
//  CreateFundriserThreeViewController.m
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "CreateFundriserThreeViewController.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "ShareCreatechallengeViewController.h"
@interface CreateFundriserThreeViewController ()
{
    NSString * challengetypeVal;
     NSURLSessionDataTask *dataTaskupload;
    NSUserDefaults *defaults;
    float pixelsPerValue;
    float leftAdjust;
       NSMutableArray * array_CreateChallenges;
     NSDictionary *urlplist;
    UIView * transperentViewIndicator11,*whiteView111;
     UILabel * Label_confirm11;
     UILabel * Label_confirm;
     UIButton *Button_close;
}
@end

@implementation CreateFundriserThreeViewController
@synthesize Button_Dot3,Button_Dot2,Button_Dot1,Button_next,Button_Image_Public,Button_Label_Public,Button_Image_Private,Button_Label_Private,Dict_values3,Label_Heding,Label_Hedingtitle;
@synthesize slider_Days,Label_Currentsdays;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    if ([[Dict_values3 valueForKey:@"challengetype"] isEqualToString:@"RAISE"])
    {
       
        Label_Heding.text=@"Create a Fundraiser";
        Label_Hedingtitle.text=@"Is this a Public or Private fundraiser?";
    }
    else
    {
        
        Label_Heding.text=@"Create a Challenge";
        Label_Hedingtitle.text=@"Is this a Public or Private challenge?";
    }
    
    [Button_Dot3 setBackgroundColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
    
    Button_Dot1.layer.cornerRadius=Button_Dot1.frame.size.height/2;
    Button_Dot2.layer.cornerRadius=Button_Dot2.frame.size.height/2;
    Button_Dot3.layer.cornerRadius=Button_Dot3.frame.size.height/2;
    Button_next.layer.cornerRadius=Button_next.frame.size.height/2;
    Button_next.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    [Button_next setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    
    Button_next.layer.borderWidth=1.0f;
    Button_next.enabled=YES;
    challengetypeVal=@"PUBLIC";
    [Button_Image_Public setImage:[UIImage imageNamed:@"blueworld.png"] forState:UIControlStateNormal];
    [Button_Image_Private setImage:[UIImage imageNamed:@"private.png"] forState:UIControlStateNormal];
    [Button_Label_Public setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Label_Private setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];;

    
    
    Label_Currentsdays.text=[NSString stringWithFormat:@"%.f%@%@",slider_Days.value,@" ",@"day"];
    float width = slider_Days.frame.size.width;
    pixelsPerValue = width / (slider_Days.maximumValue - slider_Days.minimumValue);
    leftAdjust = slider_Days.frame.origin.x-Label_Currentsdays.frame.size.width;
    
    
    
    
    
    
    transperentViewIndicator11=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transperentViewIndicator11.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    whiteView111=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150,150)];
    whiteView111.center=transperentViewIndicator11.center;
    [whiteView111 setBackgroundColor:[UIColor blackColor]];
    whiteView111.layer.cornerRadius=9;
    //   indicatorAlert = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //    indicatorAlert.frame=CGRectMake(40, 40, 20, 20);
    //    [indicatorAlert startAnimating];
    //    [indicatorAlert setColor:[UIColor whiteColor]];
    
    Label_confirm11=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 150, 40)];
    
    [Label_confirm11 setFont:[UIFont systemFontOfSize:12]];
    Label_confirm11.text=@"0 %";
    Label_confirm11.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:40.0];
    Label_confirm11.textColor=[UIColor whiteColor];
    Label_confirm11.textAlignment=NSTextAlignmentCenter;
    
    Label_confirm=[[UILabel alloc]initWithFrame:CGRectMake(0, 110, 150, 28)];
    
    [Label_confirm setFont:[UIFont systemFontOfSize:12]];
    Label_confirm.text=@"Creating...";
    Label_confirm.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:20.0];
    Label_confirm.textColor=[UIColor whiteColor];
    Label_confirm.textAlignment=NSTextAlignmentCenter;
    
    Button_close=[[UIButton alloc]initWithFrame:CGRectMake(whiteView111.frame.size.width-23, -4, 28,28)];
    Button_close.layer.cornerRadius=Button_close.frame.size.height/2;
    
    Button_close.backgroundColor=[UIColor whiteColor];
    [Button_close setTitle:@"X" forState:UIControlStateNormal];
    [Button_close setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    Button_close.titleLabel.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
    [Button_close addTarget:self action:@selector(UploadinView_Close:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView111 addSubview:Button_close];
    [whiteView111 addSubview:Label_confirm];
    [whiteView111 addSubview:Label_confirm11];
    
    [transperentViewIndicator11 addSubview:whiteView111];
    
    [self.view addSubview:transperentViewIndicator11];
    
    transperentViewIndicator11.hidden=YES;
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Button_Public_Action:(id)sender
{
    [self.view endEditing:YES];
    challengetypeVal=@"PUBLIC";
    [Button_Image_Public setImage:[UIImage imageNamed:@"blueworld.png"] forState:UIControlStateNormal];
    [Button_Image_Private setImage:[UIImage imageNamed:@"private.png"] forState:UIControlStateNormal];
    [Button_Label_Public setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [Button_Label_Private setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];;
}
- (IBAction)Button_Private_Action:(id)sender
{
    [self.view endEditing:YES];
    challengetypeVal=@"PRIVATE";
    [Button_Image_Public setImage:[UIImage imageNamed:@"profile_world.png"]forState:UIControlStateNormal];
    [Button_Image_Private setImage:[UIImage imageNamed:@"blueprivate.png"]forState:UIControlStateNormal];
    
     [Button_Label_Private setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]forState:UIControlStateNormal];
     [Button_Label_Public setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1]forState:UIControlStateNormal];
}
- (IBAction)Button_Next_Action:(id)sender
{
    //NSString * Str_message;
    
    if ([[Dict_values3 valueForKey:@"challengetype"] isEqualToString:@"DONATE"])
    {
        //        Str_message=[NSString stringWithFormat:@"%@%@%.f",@"Here's how your Challenge campaign works: \n\n1. Supporters donate using a PayPal account or a credit/debit card. Donations are made to a Fund, who delivers these funds to your chosen charities on a monthly basis. \n\n2. To earn the donations made to your challenge campaign, you will have to perform the challenge set by uploading a relevant video response within the time limit or up to 48 hours later.\n\n3. Donations will be split 25/75 between you and your chosen charities. \n\n By continuing, you agree to deductions of 7.9% +US$0.30 from each donation to Payment Gateway fee's and Care2dare processing policies.",@"\n\nAre you sure you wish to donate $",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
        
        
        
        
        
        NSString * messeageRed=[NSString stringWithFormat:@"%@",@"\n\nHere's how your Challenge campaign works: \n\n1. Supporters donate using a PayPal account or a credit/debit card. Donations are made to a Fund, who delivers these funds to your chosen charities on a monthly basis. \n\n2. To earn the donations made to your challenge campaign, you will have to perform the challenge set by uploading a relevant video response within the time limit or up to 48 hours later.\n\n3. Donations will be split 25/75 between you and your chosen charities. \n\n By continuing, you agree to deductions of 7.9% +US$0.30 from each donation to Payment Gateway fee's and Care2dare processing policies."];
        
        
        
        NSString * messagePayVal=[NSString stringWithFormat:@"%@%.f%@",@"\n\nAre you sure you wish to donate $",[[Dict_values3 valueForKey:@"payperchallenger"] floatValue]*[[Dict_values3 valueForKey:@"noofchallengers"]floatValue],@"?"];
        
        UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Challenge for Charity campaign details" attributes: arialDict];
        
        UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:messeageRed attributes:verdanaDict];
        
        UIFont *name3 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *verdanaDict2 = [NSDictionary dictionaryWithObject:name3 forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString2 = [[NSMutableAttributedString alloc]initWithString:messagePayVal attributes:verdanaDict2];
        
        [aAttrString appendAttributedString:vAttrString];
        [aAttrString appendAttributedString:vAttrString2];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert setValue:aAttrString forKey:@"attributedTitle"];
        
        NSArray *viewArray = [[[[[[[[[[[[alert view] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews];
        
        UILabel *alertTitle = viewArray[0];
        alertTitle.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel *alertMessage = viewArray[1];
        alertMessage.textAlignment = NSTextAlignmentLeft;
        
        viewArray=nil;
        alertMessage=nil;
        
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Go Back"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
        
        UIAlertAction *actionOk1 = [UIAlertAction actionWithTitle:@"Continue"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self Communication_createChallenges];
                                    }];
        
        [alert addAction:actionOk];
        
        [alert addAction:actionOk1];
        
        
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        
    }
    else
    {
        //     Str_message=@"Here's how your Challenge campaign works: \n\n1. Supporters donate using a PayPal account or a credit/debit card. Donations are made to a Fund, who delivers these funds to your chosen charities on a monthly basis. \n\n2. To earn the donations made to your challenge campaign, you will have to perform the challenge set by uploading a relevant video response within the time limit or up to 48 hours later.\n\n3. Donations will be split 25/75 between you and your chosen charities. \n\n By continuing, you agree to deductions of 7.9% +US$0.30 from each donation to Payment Gateway fee's and Care2dare processing policies.";
        
        
        
        
        NSString * messeageRed=[NSString stringWithFormat:@"%@",@"\n\nHere's how your Challenge campaign works: \n\n1. Supporters donate using a PayPal account or a credit/debit card. Donations are made to a Fund, who delivers these funds to your chosen charities on a monthly basis. \n\n2. To earn the donations made to your challenge campaign, you will have to perform the challenge set by uploading a relevant video response within the time limit or up to 48 hours later.\n\n3. Donations will be split 25/75 between you and your chosen charities. \n\n By continuing, you agree to deductions of 7.9% +US$0.30 from each donation to Payment Gateway fee's and Care2dare processing policies."];
        
        
        UIFont *name1 = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:name1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:@"Challenge for Charity campaign details" attributes: arialDict];
        
        UIFont *name2 = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:name2 forKey:NSFontAttributeName];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:messeageRed attributes:verdanaDict];
        
        
        
        [aAttrString appendAttributedString:vAttrString];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert setValue:aAttrString forKey:@"attributedTitle"];
        
        NSArray *viewArray = [[[[[[[[[[[[alert view] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews];
        
        UILabel *alertTitle = viewArray[0];
        alertTitle.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel *alertMessage = viewArray[1];
        alertMessage.textAlignment = NSTextAlignmentLeft;
        
        viewArray=nil;
        alertMessage=nil;
        
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Go Back"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
        
        UIAlertAction *actionOk1 = [UIAlertAction actionWithTitle:@"Continue"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self Communication_createChallenges];
                                    }];
        
        [alert addAction:actionOk];
        
        [alert addAction:actionOk1];
        
        
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Challenge for Charity campaign details" message:Str_message preferredStyle:UIAlertControllerStyleAlert];
    //
    //
    //
    //     NSArray *viewArray = [[[[[[[[[[[[alert view] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews];
    //
    //    UILabel *alertTitle = viewArray[0];
    //    alertTitle.textAlignment = NSTextAlignmentCenter;
    //
    //
    //    UILabel *alertMessage = viewArray[1];
    //    alertMessage.textAlignment = NSTextAlignmentLeft;
    //
    //    viewArray=nil;
    //    alertMessage=nil;
    //
    //
    //        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Go Back"
    //                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    //                                   {
    //
    //                                   }];
    //
    //        UIAlertAction *actionOk1 = [UIAlertAction actionWithTitle:@"Continue"
    //                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    //                                    {
    //                                        [self createChallengesComm];
    //                                    }];
    //
    //        [alert addAction:actionOk];
    //
    //        [alert addAction:actionOk1];
    //    
    //    
    //  
    //    
    //        [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)Button_Back_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES]; 
}
- (IBAction)progressSliderSlides:(id)sender
{
    NSInteger sliderVal=[[NSString stringWithFormat:@"%.f",slider_Days.value]integerValue];
    if (sliderVal<2)
    {
        Label_Currentsdays.text=[NSString stringWithFormat:@"%.f%@%@",slider_Days.value,@" ",@"day"];
    }
    else
    {
        Label_Currentsdays.text=[NSString stringWithFormat:@"%.f%@%@",slider_Days.value,@" ",@"days"];
    }
    NSLog(@"changed==%f",slider_Days.value);
    //
    //    CGRect frame = Label_Currentsdays.frame;
    //    frame.origin.x = leftAdjust + (5 * slider_Days.value)+33;
    //    Label_Currentsdays.frame = frame;
    CGRect trackRect = [slider_Days trackRectForBounds:slider_Days.bounds];
    
    CGRect thumbRect = [slider_Days thumbRectForBounds:slider_Days.bounds
                                             trackRect:trackRect
                                                 value:slider_Days.value];
    
    Label_Currentsdays.center = CGPointMake(15+thumbRect.origin.x + slider_Days.frame.origin.x, slider_Days.frame.origin.y-10);
    NSLog(@"changedLabel_Currentsdays==%f",Label_Currentsdays.frame.origin.x);
}

-(void)UploadinView_Close:(UIButton *)sender
{
    
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"Cancel?" message:@"Are you sure you want to cancel your upload?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Resume"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    [dataTaskupload resume];
                                    transperentViewIndicator11.hidden=NO;
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   [dataTaskupload cancel];
                                   transperentViewIndicator11.hidden=YES;
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}
#pragma mark-Php Connection

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    float progress = ((double)totalBytesSent / (double)totalBytesExpectedToSend)*100;
    NSLog(@"percentage  of dattataa==%f",progress);
    Label_confirm11.text=[NSString stringWithFormat:@"%.f%@",progress,@" %"];
}

-(void)Communication_createChallenges
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
                // [self.view showActivityViewWithLabel:@"Loading"];
                transperentViewIndicator11.hidden=NO;
                Label_confirm11.text=@"0 %";
                NSString *userid= @"userid";
                NSString *useridVal =[defaults valueForKey:@"userid"];
                
                
                NSString *title= @"title";
                NSString *titleVal =(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)[Dict_values3 valueForKey:@"title"],NULL,(CFStringRef)@"!*\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;
                
                NSString *challengetype= @"challengetype";
                
                NSString *contributiontype= @"contributiontype";
                NSString *contributiontypeval=[Dict_values3 valueForKey:@"challengetype"];
                
                NSString *mediatype= @"mediatype";
                NSString *mediatypeval=[Dict_values3 valueForKey:@"mediatype"];
                
                
                NSString *enddays= @"enddays";
                NSString *enddaysVal =[NSString stringWithFormat:@"%.f",slider_Days.value];
                
                NSString *payperchallenger= @"payperchallenger";
                NSString *payperchallengerVal =[Dict_values3 valueForKey:@"payperchallenger"];
                
                
                
                
                NSString *noofchallengers= @"noofchallengers";
                NSString *noofchallengersVal=[Dict_values3 valueForKey:@"noofchallengers"];
                
                
                NSString *challengerslist= @"challengerslist";
               NSString *challengerslistval=[Dict_values3 valueForKey:@"challengerslist"];
                
                NSString *media= @"media";
                NSString *mediaval= [Dict_values3 valueForKey:@"media"];
                
                NSString *mediaimagethumb=@"mediathumbnail";
                NSString *mediaimagethumbval=[Dict_values3 valueForKey:@"mediathumbnail"];
                
                
                NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,title,titleVal,challengetype,challengetypeVal,contributiontype,contributiontypeval,mediatype,mediatypeval,enddays,enddaysVal,payperchallenger,payperchallengerVal,noofchallengers,noofchallengersVal,challengerslist,challengerslistval,media,mediaval,mediaimagethumb,mediaimagethumbval];
                
                
                
#pragma mark - swipe sesion
                
                NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue: [NSOperationQueue mainQueue]];
                
                NSURL *url;
                NSString *  urlStrLivecount=[urlplist valueForKey:@"createchallenge"];;
                url =[NSURL URLWithString:urlStrLivecount];
                
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                
                [request setHTTPMethod:@"POST"];//Web API Method
                
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                
                request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
                
                
                
                dataTaskupload =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                 {
                                     if(data)
                                     {
                                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                         NSInteger statusCode = httpResponse.statusCode;
                                         if(statusCode == 200)
                                         {
                                             
                                             array_CreateChallenges=[[NSMutableArray alloc]init];
                                             SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                             array_CreateChallenges=[objSBJsonParser objectWithData:data];
                                             NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                             //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                             
                                             ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                             ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                             
                                             NSLog(@"array_CreateChallenges %@",array_CreateChallenges);
                                             
                                             
                                             NSLog(@"array_CreateChallenges ResultString %@",ResultString);
                                             if ([ResultString isEqualToString:@"nouserid"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                             }
                                             if ([ResultString isEqualToString:@"nomedia"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please insert an image or video and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                             }
                                             
                                             if ([ResultString isEqualToString:@"nullerror"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please enter all details and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                                 
                                                 
                                             }
                                             if ([ResultString isEqualToString:@"imageerror"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in uploading your media. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                                 
                                                 
                                             }
                                             if ([ResultString isEqualToString:@"inserterror"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in creating your challenge. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                 
                                                 
                                                 
                                                 
                                             }
                                             if (array_CreateChallenges.count !=0)
                                             //if ([ResultString isEqualToString:@"done"])
                                             {
                                                 transperentViewIndicator11.hidden=YES;
                                                 
                                                 [defaults setObject:@"yes" forKey:@"ExpView_Update"];
                                                 [defaults setObject:@"no" forKey:@"falg"];
                                                 [defaults setObject:@"" forKey:@"usernames"];
                                                 [defaults setObject:@"" forKey:@"userids"];
                                                 [defaults synchronize];
                                                 
                                
                                                 NSString * Str_msgTitle,*Str_msgTitle1;
                if ([[Dict_values3 valueForKey:@"challengetype"]isEqualToString:@"RAISE"])
                    {
                        Str_msgTitle=@"Fundraiser Created!";
                        Str_msgTitle1=@"Your fundraiser has been successfully created! Do you want to share it with your friends?";
                }
                else
                    {
                    Str_msgTitle =@"Challenge Created!";
                                                Str_msgTitle1=@"Your challenge has been successfully created! Do you want to share it with your friends?";
                                                 }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Str_msgTitle message:Str_msgTitle1 preferredStyle:UIAlertControllerStyleAlert];
                                                 
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                                                                 {
                                                                                                                     
        ShareCreatechallengeViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ShareCreatechallengeViewController"];
//            set.str_donateType=[Dict_values3 valueForKey:@"challengetype"];
                    set.Array_Values=array_CreateChallenges;
    [self.navigationController pushViewController:set animated:YES];
                                                                                                                     
       
                                                                                                                 }];
            [alertController addAction:actionYes];
                                                 
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                             {
                                                                               
                                                                                 
                                                                                 
           
            [self dismissViewControllerAnimated:YES completion:nil];
                                                                                 
                                                                             }];
                [alertController addAction:actionNo];
                                                 
    [self presentViewController:alertController animated:YES completion:nil];
                                                
                                                 
                                                 
                                          
                                             
                                             
                                             }
                                         }
                                         
                                         else
                                         {
                                             NSLog(@" error login1 ---%ld",(long)statusCode);
                                             transperentViewIndicator11.hidden=YES;
                                         }
                                         
                                         
                                     }
                                     else if(error)
                                     {
                                         
                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"server connection timeout." preferredStyle:UIAlertControllerStyleAlert];
                                         
                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                            style:UIAlertActionStyleDefault handler:nil];
                                         [alertController addAction:actionOk];
                                         [self presentViewController:alertController animated:YES completion:nil];
                                         
                                         transperentViewIndicator11.hidden=YES;
                                         
                                         NSLog(@"error login2.......%@",error.description);
                                     }
                                     
                                     
                                 }];
                [dataTaskupload resume];
            }
   
        
    }


@end
