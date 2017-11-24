//
//  CreateFundriserTwoViewController.m
//  care2Dare
//
//  Created by MacMini2 on 21/11/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "CreateFundriserTwoViewController.h"
#import "CreateFundriserThreeViewController.h"
@interface CreateFundriserTwoViewController ()

@end

@implementation CreateFundriserTwoViewController
@synthesize TextView_amount,Button_next,Button_Dot1,Button_Dot2,Button_Dot3,Dict_values2;
- (void)viewDidLoad {
    [super viewDidLoad];
    
   [Button_Dot2 setBackgroundColor:[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1]];
    
    Button_Dot1.layer.cornerRadius=Button_Dot1.frame.size.height/2;
    Button_Dot2.layer.cornerRadius=Button_Dot2.frame.size.height/2;
    Button_Dot3.layer.cornerRadius=Button_Dot3.frame.size.height/2;
    Button_next.layer.cornerRadius=Button_next.frame.size.height/2;
    Button_next.layer.borderColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1].CGColor;
    Button_next.layer.borderWidth=1.0f;
    Button_next.enabled=NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Button_Action.....

- (IBAction)Button_Next_Action:(id)sender
{
    
    [Dict_values2 setValue:TextView_amount.text forKey:@"payperchallenger"];
     [Dict_values2 setValue:@"" forKey:@"noofchallengers"];
     [Dict_values2 setValue:@"" forKey:@"challengerslist"];
    
    
        CreateFundriserThreeViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateFundriserThreeViewController"];
    
    set.Dict_values3=Dict_values2;
    
        [self.navigationController pushViewController:set animated:YES];
   

}
- (IBAction)Button_Back_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Textfield_amount_Action:(id)sender
{
    if (TextView_amount.text.length==0)
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
