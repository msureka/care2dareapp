//
//  LoginWithEmailViewController.m
//  care2Dare
//
//  Created by MacMini2 on 06/07/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "LoginWithEmailViewController.h"
#import "SignUpViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Reachability.h"
#import "UIView+RNActivityView.h"
#import <TwitterKit/TwitterKit.h>
#import <Fabric/Fabric.h>
#import "SBJsonParser.h"
#import "HomeTabBarViewController.h"
#import "TabNavigationViewController.h"

#define Buttonlogincolor [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]
@interface LoginWithEmailViewController ()
{
    NSUserDefaults *defaults;
    NSDictionary *urlplist;
    NSMutableArray *array_login;
    NSString *emailFb,*DobFb,*nameFb,*genderfb,*profile_picFb,*Fbid,*regTypeVal,*EmailValidTxt,*Str_fb_friend_id,*Str_fb_friend_id_Count;
    NSString *String_Forgot;
    NSMutableArray *fb_friend_id;
}
@end

@implementation LoginWithEmailViewController
@synthesize textfield_uname,textfield_password,Button_Login;
@synthesize view_LoginFB,View_LoginEmail,View_LoginTW,Button_LoginFb,Button_LoginTw,Button_Email,Image_LoginTw,Image_LoginFb;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    CALayer *borderBottom_uname = [CALayer layer];
    borderBottom_uname.backgroundColor = [UIColor whiteColor].CGColor;
    borderBottom_uname.frame = CGRectMake(0, textfield_uname.frame.size.height-0.8, textfield_uname.frame.size.width,0.5f);
    [textfield_uname.layer addSublayer:borderBottom_uname];
    
    CALayer *borderBottom_passeord = [CALayer layer];
    borderBottom_passeord.backgroundColor = [UIColor whiteColor].CGColor;
    borderBottom_passeord.frame = CGRectMake(0, textfield_password.frame.size.height-0.8, textfield_password.frame.size.width,0.5f);
    [textfield_password.layer addSublayer:borderBottom_passeord];
    
    
    Button_Login.clipsToBounds=YES;
    Button_Login.layer.cornerRadius=5.0f;
    Button_Login.layer.borderColor=[UIColor whiteColor].CGColor;
    Button_Login.layer.borderWidth=0.5;
    
    view_LoginFB.clipsToBounds=YES;
    view_LoginFB.layer.cornerRadius=5.0f;
    view_LoginFB.layer.borderColor=[UIColor whiteColor].CGColor;
    view_LoginFB.layer.borderWidth=1.0f;
    
    View_LoginTW.clipsToBounds=YES;
    View_LoginTW.layer.cornerRadius=5.0f;
    View_LoginTW.layer.borderColor=[UIColor whiteColor].CGColor;
    View_LoginTW.layer.borderWidth=1.0f;
    
    
    CALayer *borderLeftFb = [CALayer layer];
    borderLeftFb.backgroundColor = [UIColor whiteColor].CGColor;
    
    borderLeftFb.frame = CGRectMake(0, 0, 1.0,Button_LoginFb.frame.size.height);
    [Button_LoginFb.layer addSublayer:borderLeftFb];
    
    CALayer *borderLeftTw = [CALayer layer];
    borderLeftTw.backgroundColor = [UIColor whiteColor].CGColor;
    
    borderLeftTw.frame = CGRectMake(0, 0, 1.0, Button_LoginTw.frame.size.height);
    [Button_LoginTw.layer addSublayer:borderLeftTw];
    
    
    
    
    
    
  
    Image_LoginFb.userInteractionEnabled=YES;
    Image_LoginTw.userInteractionEnabled=YES;;
    
    
    UITapGestureRecognizer *tapFb = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TappedFb:)]; // this is the current problem like a lot of people out there...
    [Image_LoginFb addGestureRecognizer:tapFb];
    
    UITapGestureRecognizer *tapTW = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TappedTwitter:)]; // this is the current problem like a lot of people out there...
    [Image_LoginTw addGestureRecognizer:tapTW];
    
    
    FRHyperLabel *label = self.termLabel;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"San Francisco Display" size:12]];
    
    NSString *string = @"By signing in, you agree to our Terms of Service and Privacy Policy";
    
    //    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]};
    //
    
    // NSString *myString = @"Care2Dare";
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:@"Terms of Service"];
    NSRange range1 = [string rangeOfString:@"Privacy Policy"];
    [attString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:12.0] range:range];
    [attString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:12.0] range:range1];
    
    
    
    //    Label_TitleName.attributedText = attString;
    
    
    
    
    
    label.attributedText = attString;
    
    
    
    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring)
    {
        
        if ([substring isEqualToString:@"Terms of Service"])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.care2dareapp.com/terms.html"]];
            
        }
        if ([substring isEqualToString:@"Privacy Policy"])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.care2dareapp.com/privacy.html"]];
            
        }
    };
    
    //Step 3: Add link substrings
    
    [label setLinksForSubstrings:@[@"Terms of Service", @"Privacy Policy"] withLinkHandler:handler];
    [Button_Login setTitleColor:Buttonlogincolor forState:UIControlStateNormal];
    Button_Login.enabled=NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)ForgetPasswordAction:(id)sender
{
    
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Forgot Password" message:@"To send your password, please enter your registered email address." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av textFieldAtIndex:0].delegate = self;
    [av show];
    NSLog(@"dddd=%@",av);
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100)
    {
        exit(0);
    }
    else
    {
        if (buttonIndex==1)
        {
            if ([[alertView textFieldAtIndex:0].text isEqualToString:@""])
            {
                
            }
            else
            {
                String_Forgot=[alertView textFieldAtIndex:0].text;
                [self ForgetPasswordCommunication];
                NSLog(@"%@", [alertView textFieldAtIndex:0].text);
            }
        }
        
    }
}
-(void)ForgetPasswordCommunication
{
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    
    
    if ([emailTest evaluateWithObject:String_Forgot] == NO)
        
    {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"This seems to be incorrect. Please enter a valid email address and try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        [self.view endEditing:YES];
    }
    
    else
    {
        
        [self.view endEditing:YES];
        [self.view showActivityViewWithLabel:@"Loading"];
        NSString *email= @"email";
        
        
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",email,String_Forgot];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"forgotpassword"];;
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
                                                     
                                                     
                                                     if ([ResultString isEqualToString:@"noemail"])
                                                     {
                                                         [self.view hideActivityViewWithAfterDelay:0];
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"The email address you have entered is not registered in our system or your account has been deactivated. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"facebooklogin"])
                                                     {
                                                         [self.view hideActivityViewWithAfterDelay:0];
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You have registered with us via Facebook. Please use the Login with Facebook feature." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"twitterlogin"])
                                                     {
                                                         [self.view hideActivityViewWithAfterDelay:0];
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You have registered with us via Twitter. Please use the Login with Twitter feature." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"sent"])
                                                     {
                                                         [self.view hideActivityViewWithAfterDelay:0];
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Password Sent" message:@"Your password has been sent to your registered email address. Thank-you!" preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                                         
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     
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
-(IBAction)LoginButtonAction:(id)sender
{
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    
    
    if ([emailTest evaluateWithObject:textfield_uname.text] == NO)
        
    {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Invalid email address.Please try again" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        [textfield_uname becomeFirstResponder];
    }
    
    else
    {
        
        [self.view endEditing:YES];
        [self.view showActivityViewWithLabel:@"Loading"];
        NSString *email= @"email";
        NSString *emailVal =textfield_uname.text;
        
        
        NSString *password= @"password";
        NSString *passwordVal =textfield_password.text;
        
        NSString *city= @"city";
        NSString *cityVal =[defaults valueForKey:@"Cityname"];;
        
        NSString *country= @"country";
        NSString *countryVal =[defaults valueForKey:@"Countryname"];
        
        NSString *devicetoken= @"devicetoken";
        NSString *devicetokenVal =@"123";
        
        NSString *regType= @"regtype";
        NSString *regTypeVal =@"LOGINEMAIL";
        
        NSString *Platform= @"platform";
        NSString *PlatformVal =@"ios";
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",email,emailVal,password,passwordVal,regType,regTypeVal,city,cityVal,country,countryVal,devicetoken,devicetokenVal,Platform,PlatformVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"loginsignup"];;
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
                                                     
                                                     array_login=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     array_login=[objSBJsonParser objectWithData:data];
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"array_loginarray_login %@",array_login);
                                                     
                                                     
                                                     NSLog(@"array_login ResultString %@",ResultString);
                                                     if ([ResultString isEqualToString:@"loginerror"])
                                                     {
                                                         [self.view hideActivityViewWithAfterDelay:0];
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Incorrect Login" message:@"Please enter your registered email address and password and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"deactive"])
                                                     {
                                                         [self.view hideActivityViewWithAfterDelay:0];
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account has been deactivated." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"nullerror"])
                                                     {
                                                         [self.view hideActivityViewWithAfterDelay:0];
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve one of the Account Ids. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                         
                                                         
                                                     }
                                                     if(array_login.count !=0)
                                                     {
                                                         
                                                         
                                                         
                                                         [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"challenges"]] forKey:@"challenges"];
                                                         
                                                         
                                                         
                                                         [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"email"]] forKey:@"email"];
                                                         
                                                         [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"friends"]] forKey:@"friends"];
                                                         
                                                         [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"name"]] forKey:@"name"];
                                                         
                                                         
                                                         [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"profileimage"]] forKey:@"profileimage"];
                                                         
                                                         [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"userid"]] forKey:@"userid"];
                                                         
                                                         [defaults setObject:@"EMAIL" forKey:@"SettingLogin"];
                                                         [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"regtype"]] forKey:@"logintype"];
                                                         [defaults setObject:@"yes" forKey:@"LoginView"];
                                                         [defaults synchronize];
                                                         
                                                         
                                                         
                                                         
                                                         [self.view hideActivityViewWithAfterDelay:0];
                                                         TabNavigationViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabNavigationViewController"];
                                                         
                                                         //                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                         //                        HomeTabBarViewController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"HomeTabBarViewController"];
                                                         [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
                                                         
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

- (IBAction)usernameTxtAction:(id)sender
{
    UITextField *textField = (UITextField*)sender;
    
    
    
    if(textfield_uname.text.length !=0 && textfield_password.text.length !=0 )
    {
        Button_Login.enabled=YES;
        [Button_Login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        Button_Login.enabled=NO;
        [Button_Login setTitleColor:Buttonlogincolor forState:UIControlStateNormal];
    }
    NSLog(@"sendertag %ld",(long)textField.tag);
}
-(IBAction)LoginWithFbAction:(id)sender
{
    [self.view endEditing:YES];
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
                 [self.view hideActivityViewWithAfterDelay:1];
                 
                 NSLog(@"Process error");
             }
             else if (result.isCancelled)
             {
                 [self.view hideActivityViewWithAfterDelay:1];
                 
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
                             //  nameFb=[NSString stringWithFormat:@"%@%@%@",[result objectForKey:@"first_name"],@" ",[result objectForKey:@"last_name"]];
                             nameFb=[result objectForKey:@"name"];
                             genderfb=[result objectForKey:@"gender"];
                             
                             
                             NSArray * allKeys = [[result valueForKey:@"friends"]objectForKey:@"data"];
                             
                             //                             fb_friend_Name = [[NSMutableArray alloc]init];
                             fb_friend_id  =  [[NSMutableArray alloc]init];
                             
                             for (int i=0; i<[allKeys count]; i++)
                             {
                                 //   [fb_friend_Name addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"name"]];
                                 
                                 [fb_friend_id addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"id"]];
                                 
                             }
                             Str_fb_friend_id_Count=[NSString stringWithFormat:@"%d",fb_friend_id.count];
                             Str_fb_friend_id=[fb_friend_id componentsJoinedByString:@","];
                             NSLog(@"Friends ID : %@",Str_fb_friend_id);
                             ///NSLog(@"Friends Name : %@",fb_friend_Name);
                             
                             profile_picFb= [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",Fbid];
                             
                             NSLog(@"my url DataFBB=%@",result);
                             regTypeVal =@"FACEBOOK";
                             [defaults setObject:@"FACEBOOK" forKey:@"SettingLogin"];
                             [defaults synchronize];
                             [self FbTwittercommunicationServer];
                             
                         }
                         
                         
                     }
                 }];
                 
             }
             
         }];
    }
    
}
-(IBAction)LoginWithTwitterAction:(id)sender
{
    [self.view endEditing:YES];
    
    
    
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
                  [defaults synchronize];
                  regTypeVal =@"TWITTER";
                  genderfb=@"";
                  profile_picFb=[Array_sinupFb valueForKey:@"profile_image_url"];
                  [defaults setObject:@"TWITTER" forKey:@"SettingLogin"];
                  [defaults synchronize];
                  
                  
                  [self TwitterFriendsList];
                  
                  //         [self FbTwittercommunicationServer];
                  
              }];
             
             
             
         } else
         {
             NSLog(@"error: %@", [error localizedDescription]);
             [self.view hideActivityViewWithAfterDelay:1];
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
//- (void) TappedEmail: (UIGestureRecognizer *) gesture
//{
//    [self LoginWithEmailAction:nil];
//}
- (void) TappedFb: (UIGestureRecognizer *) gesture
{
    [self LoginWithFbAction:nil];
}
- (void) TappedTwitter: (UIGestureRecognizer *) gesture
{
    [self LoginWithTwitterAction:nil];
}

-(void)FbTwittercommunicationServer
{
    
    
    
    //   [self.view showActivityViewWithLabel:@"Loading"];
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
    
    
    NSString *gender= @"gender";
    NSString *name= @"name";
    NSString *imageurl= @"imageurl";
    // [defautls valueForKey:@""];
    
    NSString *password= @"password";
    NSString *passwordVal =@"";
    
    NSString *Dob= @"dateofbirth";
    NSString *DobVal =@"";
    
    NSString *city= @"city";
    NSString *cityVal =[defaults valueForKey:@"Cityname"];;
    
    NSString *country= @"country";
    NSString *countryVal =[defaults valueForKey:@"Countryname"];
    
    NSString *devicetoken= @"devicetoken";
    NSString *devicetokenVal =@"123";
    
    NSString *regType= @"regtype";
    
    
    NSString *Platform= @"platform";
    NSString *PlatformVal =@"ios";
    
    NSString *nooffriends= @"nooffriends";
    
    NSString *friendlist= @"friendlist";
    NSString *friendlistval =[NSString stringWithFormat:@"%@",Str_fb_friend_id];
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",fbid1,Fbid,email,emailFb,gender,genderfb,name,nameFb,password,passwordVal,Dob,DobVal,regType,regTypeVal,city,cityVal,country,countryVal,devicetoken,devicetokenVal,Platform,PlatformVal,imageurl,profile_picFb,nooffriends,Str_fb_friend_id_Count,friendlist,friendlistval];
    
    
    
#pragma mark - swipe sesion
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url;
    NSString *  urlStrLivecount=[urlplist valueForKey:@"loginsignup"];;
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
                                                 
                                                 array_login=[[NSMutableArray alloc]init];
                                                 SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                 array_login=[objSBJsonParser objectWithData:data];
                                                 NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                 //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                 
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                 
                                                 NSLog(@"array_loginarray_login %@",array_login);
                                                 
                                                 
                                                 NSLog(@"array_login ResultString %@",ResultString);
                                                 if ([ResultString isEqualToString:@"emailexists-facebook"])
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You already have a Facebook Account registered with this email id. Please login with Facebook." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"emailexists-twitter"])
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You already have a Twitter Account registered with this email id. Please login with Twitter." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"emailexists-email"])
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You already have an Account registered with this email id. Please login with your registered email." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                 }
                                                 
                                                 if ([ResultString isEqualToString:@"nullerror"])
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve one of the Account Ids. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                     
                                                     
                                                     
                                                 }
                                                 if ([ResultString isEqualToString:@"inserterror"])
                                                 {
                                                     
                                                     
                                                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not insert  Please try again" preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                        style:UIAlertActionStyleDefault
                                                                                                      handler:nil];
                                                     [alertController addAction:actionOk];
                                                     [self presentViewController:alertController animated:YES completion:nil];
                                                     
                                                 }
                                                 
                                                 if(array_login.count !=0)
                                                 {
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"challenges"]] forKey:@"challenges"];
                                                     
                                                     
                                                     
                                                     [defaults setObject:[[array_login objectAtIndex:0]valueForKey:@"email"] forKey:@"email"];
                                                     
                                                     [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"friends"]] forKey:@"friends"];
                                                     
                                                     [defaults setObject:[[array_login objectAtIndex:0]valueForKey:@"name"] forKey:@"name"];
                                                     
                                                     
                                                     [defaults setObject:[[array_login objectAtIndex:0]valueForKey:@"profileimage"] forKey:@"profileimage"];
                                                     
                                                     [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"userid"]] forKey:@"userid"];
                                                     [defaults setObject:[NSString stringWithFormat:@"%@",[[array_login objectAtIndex:0]valueForKey:@"regtype"]] forKey:@"logintype"];
                                                     
                                                     [defaults setObject:@"yes" forKey:@"LoginView"];
                                                     [defaults synchronize];
                                                     
                                                     
                                                     TabNavigationViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabNavigationViewController"];
                                                     
                                                     //                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                     //                        HomeTabBarViewController *   Home_add= [mainStoryboard instantiateViewControllerWithIdentifier:@"HomeTabBarViewController"];
                                                     [[UIApplication sharedApplication].keyWindow setRootViewController:loginController];
                                                     
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
-(IBAction)LoginviewViewBack:(id)sender;
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)SignUpView:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SignUpViewController * set=[mainStoryboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
     set.chkview=@"MainEmail";
    [self.navigationController pushViewController:set animated:NO];
}
@end
