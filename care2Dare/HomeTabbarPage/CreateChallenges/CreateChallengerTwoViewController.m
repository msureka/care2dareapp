//
//  CreateChallengerTwoViewController.m
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "CreateChallengerTwoViewController.h"
#import "InviteSprintTagUserViewController.h"
#import "CreateFundriserThreeViewController.h"
@interface CreateChallengerTwoViewController ()
{
    NSUserDefaults *defaults;
    NSString *_String_Cont_UserId,*String_Cont_Name;
}
@end

@implementation CreateChallengerTwoViewController
@synthesize Array_Names,Array_UserId,Button_next,Button_Dot1,Button_Dot2,Button_Dot3,Dict_values2;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    
    
    [Button_Dot2 setBackgroundColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
    
    Button_Dot1.layer.cornerRadius=Button_Dot1.frame.size.height/2;
    Button_Dot2.layer.cornerRadius=Button_Dot2.frame.size.height/2;
    Button_Dot3.layer.cornerRadius=Button_Dot3.frame.size.height/2;
    Button_next.layer.cornerRadius=Button_next.frame.size.height/2;
    Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
    Button_next.layer.borderWidth=1.0f;
    Button_next.enabled=NO;
    
    
    
    
    
    
    
    _Label_ChallengesName.userInteractionEnabled=YES;
    
    NSLog(@"flaaaaag==%@",[defaults valueForKey:@"flag"]);
    
    if ( ![[defaults valueForKey:@"flag"]isEqualToString:@"yes"])
    {
        _Label_ChallengesName.text=@"Who are you challenging?";
        
    }
    else
    {
        
        NSLog(@"defaults valueForKey:username==%@",[defaults valueForKey:@"usernames"]);
        NSString * Str_ArrayUsernames=[defaults valueForKey:@"usernames"];
        
        _Label_ChallengesName.text=[defaults valueForKey:@"usernames"];
        
        if (![Str_ArrayUsernames isEqualToString:@""])
        {
            
            
            Array_Names=[[NSMutableArray arrayWithObjects:[defaults valueForKey:@"usernames"], nil]mutableCopy];
            
            Array_UserId=[[NSMutableArray arrayWithObjects:[defaults valueForKey:@"userids"], nil]mutableCopy];
        }
        
        //        [defaults setObject:userId_prof forKey:@"userids"];
    }
    
    _Label_ChallengesName.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24];
    
    _Label_ChallengesName.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
    
    
    UITapGestureRecognizer *LabelTap_Label_ChallengesName =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_Label_ChallengesName_Tapped:)];
    [_Label_ChallengesName addGestureRecognizer:LabelTap_Label_ChallengesName];
   
    
    
    
    
    _Label_ChallengesName.textColor = [UIColor lightGrayColor];
//    _Button_Create.enabled=NO;
//    [_Button_Create setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    _Button_Create.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"PassDataArray" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceivedId:) name:@"PassDataArrayUserId" object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (Array_Names.count !=0)
    {
        
   
        _Label_ChallengesName.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:20];
        _Label_ChallengesName.textColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
        
        if (Array_Names.count==1)
        {
            
            
            _Label_ChallengesName.text=[NSString stringWithFormat:@"%@",[Array_Names objectAtIndex:0]];
        }
        else
        {
            
            _Label_ChallengesName.text=[NSString stringWithFormat:@"%@%@%lu%@",[Array_Names objectAtIndex:0],@" & ",(unsigned long)Array_Names.count-1,@" more"];
        }
       
            
            _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
            _Label_totalAmount.hidden=NO;
            }
    else
    {
      
        
        _Label_ChallengesName.text=@"Who are you challenging?";
        _Label_ChallengesName.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24];
        
        _Label_ChallengesName.textColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
        
    
            
            _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
            _Label_totalAmount.hidden=NO;
    }
//    float totalamt=[_Textfield_Amount.text floatValue]*(Array_Names.count);
    if (Array_Names.count ==0)
    {
        Button_next.enabled=NO;
        [Button_next setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
        Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
    }
    else
    {
        Button_next.enabled=YES;
        [Button_next setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        Button_next.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    }
}
- (void)_Label_ChallengesName_Tapped:(UITapGestureRecognizer *)recognizer
{
    InviteSprintTagUserViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"InviteSprintTagUserViewController"];
    if (Array_Names.count!=0)
    {
        
        NSDictionary *theInfo = [NSDictionary dictionaryWithObjectsAndKeys:Array_Names,@"descBack", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArrayBack" object:self
                                                          userInfo:theInfo];
        set.Names=Array_Names;
        set.Names_UserId=Array_UserId;
        
        
        [self.navigationController pushViewController:set animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:set animated:YES];
    }
    
    
}
-(void)dataReceived:(NSNotification *)noti
{
    
    Array_Names= [[noti userInfo] objectForKey:@"desc"];
    
    NSLog(@"days1111=%@",noti.object);
    NSLog(@"theArraytheArray=%@",Array_Names);
    String_Cont_Name=[Array_Names componentsJoinedByString:@","];
    NSLog(@"strInvite_usersstrInvite_users=%@",String_Cont_Name);
}
-(void)dataReceivedId:(NSNotification *)notif
{
    
    Array_UserId= [[notif userInfo] objectForKey:@"descId"];
    NSLog(@"theArraytheArray222222=%@",Array_UserId);
    _String_Cont_UserId=[Array_UserId componentsJoinedByString:@","];
    NSLog(@"_String_Cont_UserId=%@",_String_Cont_UserId);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Textfield_Amount_Action:(id)sender
{
    
    
    
        _Label_totalAmount.text=[NSString stringWithFormat:@"%@%.f",@"total: $ ",[_Textfield_Amount.text floatValue]*(Array_Names.count)];
    
        _Label_totalAmount.hidden=NO;
   // float totalamt=[_Textfield_Amount.text floatValue]*(Array_Names.count);
    if (Array_Names.count==0)
    {
        Button_next.enabled=NO;
        [Button_next setTitleColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1] forState:UIControlStateNormal];
        Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
    }
    else
    {
        Button_next.enabled=YES;
        [Button_next setTitleColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        Button_next.layer.borderColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1].CGColor;
    }
        
    
}

- (IBAction)Button_Next_Action:(id)sender
{
    [Dict_values2 setValue:[NSString stringWithFormat:@"%lu",(unsigned long)Array_Names.count] forKey:@"noofchallengers"];
    [Dict_values2 setValue:_Textfield_Amount.text forKey:@"payperchallenger"];
    [Dict_values2 setValue:_String_Cont_UserId forKey:@"challengerslist"];
    
   
    CreateFundriserThreeViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateFundriserThreeViewController"];
    set.Dict_values3=Dict_values2;
    [self.navigationController pushViewController:set animated:YES];
}
- (IBAction)Button_Back_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
