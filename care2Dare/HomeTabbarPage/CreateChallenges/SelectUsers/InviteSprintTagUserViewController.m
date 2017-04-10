//
//  InviteSprintTagUserViewController.m
//  SprintTags_Pro
//
//  Created by Spiel's Macmini on 9/1/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "InviteSprintTagUserViewController.h"
#import "CLToken.h"
#import "SBJsonParser.h"
#import "InviteSprintUserTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LCNContactPickerView.h"
@interface InviteSprintTagUserViewController ()<LCNContactPickerViewDelegate>

{
    NSDictionary *urlplist;
    NSURLConnection *Connection_Recomm_GetUser;
    NSMutableData *webData_Recomm_GetUser;
    NSMutableArray *Array_Reomm_GetUser;
    NSMutableArray *Array_SearchData;
    NSArray *Search_Array_Recoom;
    NSString *ResultString_getUser,*ResultString_getUser_send, *strInvite_users,*ResultString_Recomm_getUser;
    NSMutableDictionary * didselectDic;
    UIView *HeadingView;
    
    UIButton *headerLabel1,*headerLabel2;
    UITableView * Table_ContactView;
    NSUserDefaults * defaults;
}
@property (nonatomic, strong) LCNContactPickerView *contactPickerView;
@property (strong, nonatomic) NSArray *names;

@property (strong, nonatomic) NSMutableArray *selectedNames;
@property (strong, nonatomic) NSMutableArray *selectedUserid;

@end

@implementation InviteSprintTagUserViewController
@synthesize selectedUserid,selectedNames,Array_InviteUserTags,Send_Button;
- (void)viewDidLoad {
    [super viewDidLoad];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived1:) name:@"PassDataArrayBack" object:nil];

  defaults=[[NSUserDefaults alloc]init];
         Array_SearchData=[[NSMutableArray alloc]init];

    Search_Array_Recoom=[[NSMutableArray alloc]init];
   Search_Array_Recoom=[[NSArray alloc]init];
     [[self navigationController] setNavigationBarHidden:YES animated:NO];
    selectedNames = [NSMutableArray arrayWithCapacity:Search_Array_Recoom.count];
    selectedUserid= [NSMutableArray arrayWithCapacity:Search_Array_Recoom.count];
    Table_ContactView.hidden = YES;
    Send_Button.enabled=NO;
    Send_Button.backgroundColor=[UIColor clearColor];
    Send_Button.alpha=0.8;

    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
  urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
   [self Communication_Invite_user];
    NSLog(@"Mewwwwww=%@",_Names_UserId);
   
  
    self.contactPickerView = [[LCNContactPickerView alloc] initWithFrame:CGRectMake(10,75, self.view.frame.size.width - 20, 0)];
    
    Table_ContactView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
   
    Table_ContactView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:Table_ContactView];
 
    self.contactPickerView.backgroundColor=[UIColor clearColor];

    Table_ContactView.delegate = self;
    Table_ContactView.dataSource = self;
    self.contactPickerView.delegate = self;
       
    [self.view addSubview:self.contactPickerView];
 
    for (int i=0; i<_Names.count; i++)
    {
        [self.contactPickerView addContact:[_Names objectAtIndex:i] withDisplayName:[_Names objectAtIndex:i]];
        NSLog(@"Mewwwwww=%@",[_Names objectAtIndex:i]);
        
        NSLog(@"Mewwwwww=%@",[_Names_UserId objectAtIndex:i]);
        [selectedUserid addObject:[_Names_UserId objectAtIndex:i]];
        [selectedNames addObject:[_Names objectAtIndex:i]];
        
    }
     Table_ContactView.hidden=YES;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Array_SearchData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 48;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"Cell";
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UIImageView *Proimage_View=nil;
    UILabel *Labelname=nil;
    
   
   
        
    
    
    
    
   
   
        if (cell == nil) {
    
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            Proimage_View=[[UIImageView alloc]initWithFrame:CGRectZero];
            Labelname=[[UILabel alloc]initWithFrame:CGRectZero];
  [Proimage_View setTag:2];
            [Labelname setTag:1];
            
            [[cell contentView] addSubview:Proimage_View];
            [[cell contentView] addSubview:Labelname];
           

          
        }
    
    [cell addSubview:Proimage_View];
    [cell addSubview:Labelname];
    Proimage_View.frame=CGRectMake(10, 8, 32, 32);
            Proimage_View.clipsToBounds=YES;
            Proimage_View.layer.cornerRadius=Proimage_View.frame.size.height/2;
            Labelname.frame=CGRectMake(50, 0, self.view.frame.size.width-67, 48);
    
//        Proimage_View.backgroundColor=[UIColor greenColor];
//        Labelname.text =@"vvdsdsdsfddfsdsddggdfgdfgdfggdgdfgfgdfgdfgdfgdfgdfgdfgdgdfgsfdsfdsf";
   
        NSString *name = [[Array_SearchData valueForKey:@"name"]objectAtIndex:indexPath.row];
      NSString *nameTag = [[Array_SearchData valueForKey:@"userid"]objectAtIndex:indexPath.row];
    if (!Labelname)
        Labelname = (UILabel*)[cell viewWithTag:1];
    
    [Labelname setText:name];
   
        Labelname.text=name;
        NSMutableDictionary *dict_Sub=[Array_SearchData objectAtIndex:indexPath.row];
     NSURL * url=[dict_Sub valueForKey:@"profilepic"];
    if (!Proimage_View)
        Proimage_View = (UIImageView*)[cell viewWithTag:2];
    
        [Proimage_View sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]];
        if ([self.selectedUserid containsObject:nameTag])
        {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    NSLog(@"SEACH CELL  Array_SearchData=%@", Array_SearchData);
     NSLog(@"SEACH CELL  Array_SearchData=%@", [Array_SearchData objectAtIndex:indexPath.row]);
        return cell;
    
   
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name2;
    name2= [[Array_SearchData valueForKey:@"name"]objectAtIndex:indexPath.row];
    NSString *name1 = [[Array_SearchData valueForKey:@"userid"]objectAtIndex:indexPath.row];
    
    if ((selectedUserid.count==0 && self.selectedNames.count==0)||![selectedUserid containsObject:name1] )
    {
          Send_Button.enabled=YES;
            Send_Button.backgroundColor=[UIColor clearColor];
            Send_Button.alpha=1;
        
 
           // NSString *displayName = name2.text;
    [self.contactPickerView addContact:name2 withDisplayName:name2];
        

//        CLToken *token = [[CLToken alloc] initWithDisplayText:name2 context:nil];
        [selectedUserid addObject:name1];
         [selectedNames addObject:name2];
        
       
//        NSLog(@"tokentokentoken=%@",token);
//        NSLog(@"token1111111=%@",token);
    }
    

    Table_ContactView.hidden=YES;
    
   NSLog(@"didRemoveToken=%@",self.selectedNames);
     NSLog(@"selectedUserid=%@",selectedUserid);
  
}

-(void)Communication_Invite_user
{
    
    
    
    NSURL *url11;//=[NSURL URLWithString:[urlplist valueForKey:@"singup"]];
    NSString *  urlStrLivecount11=[urlplist valueForKey:@"createchallenge_addfriends"];
    url11 =[NSURL URLWithString:urlStrLivecount11];
    NSMutableURLRequest *request11 = [NSMutableURLRequest requestWithURL:url11];
    
    [request11 setHTTPMethod:@"POST"];
    
    [request11 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSString *tagName11=@"userid";
    NSString *tagnameV11=[defaults valueForKey:@"userid"];
    
    
    
    NSString *reqStringFUll11=[NSString stringWithFormat:@"%@=%@",tagName11,tagnameV11];
    
    
    NSData *requestData11 = [NSData dataWithBytes:[reqStringFUll11 UTF8String] length:[reqStringFUll11 length]];
    [request11 setHTTPBody: requestData11];
    
    Connection_Recomm_GetUser = [[NSURLConnection alloc] initWithRequest:request11 delegate:self];
    {
        if( Connection_Recomm_GetUser)
        {
            webData_Recomm_GetUser =[[NSMutableData alloc]init];
            
            
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
    }
 

    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    if(connection==Connection_Recomm_GetUser)
    {
        [webData_Recomm_GetUser setLength:0];
        
        
    }
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    if(connection==Connection_Recomm_GetUser)
    {
        [webData_Recomm_GetUser appendData:data];
    }
    
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
    
    if (connection==Connection_Recomm_GetUser)
    {
        
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];

        ResultString_Recomm_getUser=[[NSString alloc]initWithData:webData_Recomm_GetUser encoding:NSUTF8StringEncoding];
        Array_Reomm_GetUser= [objSBJsonParser objectWithData:webData_Recomm_GetUser];
        Search_Array_Recoom= [objSBJsonParser objectWithData:webData_Recomm_GetUser];
        [Array_SearchData addObjectsFromArray:Search_Array_Recoom];
        ResultString_Recomm_getUser = [ResultString_Recomm_getUser stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        ResultString_Recomm_getUser = [ResultString_Recomm_getUser stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"Array_Reomm_GetUser== %@",Array_Reomm_GetUser);
        NSLog(@"ResultString_Recomm_getUser %@",ResultString_Recomm_getUser);
        
        
        
        
    }
     Table_ContactView.hidden = YES;
    [Table_ContactView reloadData];
    
  
}
-(IBAction)BackButton:(id)sender
{
     strInvite_users= [selectedNames componentsJoinedByString:@","];
    NSDictionary *theInfo = [NSDictionary dictionaryWithObjectsAndKeys:selectedNames,@"desc", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArray" object:self
                                                      userInfo:theInfo];
    NSDictionary *theInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:selectedUserid,@"descId", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArrayUserId" object:self
                                                      userInfo:theInfo1];
    NSLog(@"concat_UserId ==%@ ",strInvite_users);
    NSLog(@"concat_UserId ==%@ ",selectedNames);
    [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)SendButtons:(id)sender
{
    strInvite_users= [selectedNames componentsJoinedByString:@","];
//      [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArray" object:[NSDictionary dictionaryWithObject:strInvite_users forKey:@"desc"]];
//     [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArray" object:[NSDictionary dictionaryWithObject:strInvite_users forKey:@"desc"]];
    
    NSDictionary *theInfo = [NSDictionary dictionaryWithObjectsAndKeys:selectedNames,@"desc", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArray" object:self
userInfo:theInfo];
    NSDictionary *theInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:selectedUserid,@"descId", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PassDataArrayUserId" object:self
                                                      userInfo:theInfo1];
    NSLog(@"concat_UserId ==%@ ",strInvite_users);
    NSLog(@"concat_UserId ==%@ ",selectedNames);
       [self.navigationController popViewControllerAnimated:YES];
   
    
}

-(void)dataReceived1:(NSNotification *)noti
{
    NSLog(@"days1111=%@",noti.object);
   NSArray * Array_Names= [[noti userInfo] objectForKey:@"desc"];
    NSLog(@"theArraytheArray=%@",Array_Names);
   NSString * String_Cont_Name=[Array_Names componentsJoinedByString:@","];
    NSLog(@"strInvite_usersstrInvite_users=%@",String_Cont_Name);
}

- (void)LCNContactPickerTextViewDidChange:(NSString *)textViewText
{
    
    
    if (textViewText.length==0)
    {
        [Array_SearchData removeAllObjects];
        
        
        [Array_SearchData addObjectsFromArray:Search_Array_Recoom];
        
        Table_ContactView.hidden = YES;
        
        
    }
    else
        
    {
        
        
        [Array_SearchData removeAllObjects];
        
        for (NSDictionary *book in Search_Array_Recoom)
        {
            NSString * string=[book objectForKey:@"name"];
            NSString * string1=[book objectForKey:@"name"];
            NSRange r=[string rangeOfString:textViewText options:NSCaseInsensitiveSearch];
            if (r.location !=NSNotFound)
            {
                
                NSLog(@"IMAGE PROBLEM=%@",string1);
                NSLog(@"book PROBLEM=%@",book);
                [Array_SearchData addObject:book];
                
            }
            
        }
         NSLog(@"Array_SearchDataSearch=======%@",Array_SearchData);
        Table_ContactView.hidden = NO;
    }
    
    
    [Table_ContactView reloadData];
    
    
    
    //    NSInteger indexValue = [_selectedNames indexOfObject:name];
    //    NSLog(@"index of contain object didAddToken==%ld",(long)indexValue);
    //    NSLog(@"selectedUserid contain object didAddToken==%@",selectedUserid);
    //    NSLog(@"Array count object didAddToken==%lu",(unsigned long)_selectedNames.count);
    //    NSLog(@"Array count object didAddToken==%lu",(unsigned long)selectedUserid.count);
    
    NSLog(@">>>>>TextChanged:%@",textViewText);
}

- (void)LCNContactPickerDidRemoveContact:(id)contact
{
    NSLog(@"didAddToken=%@",contact);
    NSLog(@">>>>>ContactRemoved");
    if(selectedNames.count !=0)
    {
    if (!contact)
    {
        NSString *name = contact;
        
        NSInteger indexValue = [selectedNames indexOfObject:name];
        NSLog(@"index of contain object didRemoveToken==%ld",(long)indexValue);
        
        [selectedUserid removeObjectAtIndex:indexValue];
        
        NSLog(@"selectedUserid removeObjectAtIndex didRemoveToken==%@",selectedUserid);
        [self.selectedNames removeObjectAtIndex:indexValue];
        
        NSLog(@"Array count object didAddToken1111==%lu",(unsigned long)selectedNames.count);
        NSLog(@"Array count object didAddToken1111==%lu",(unsigned long)selectedUserid.count);
    }
    else
    {
//        NSInteger indexValue = [_selectedNames indexOfObject:_selectedNames.count-1];
//        NSLog(@"index of contain object didRemoveToken==%ld",(long)indexValue);
        if(selectedNames !=0)
        {
        [selectedUserid removeObjectAtIndex:selectedNames.count-1];
        
        NSLog(@"selectedUserid removeObjectAtIndex didRemoveToken==%@",selectedUserid);
        [self.selectedNames removeObjectAtIndex:selectedNames.count-1];
        
        NSLog(@"Array count object didAddToken1111==%lu",(unsigned long)selectedNames.count);
        NSLog(@"Array count object didAddToken1111==%lu",(unsigned long)selectedUserid.count);
        }
    }
    
  
    
    
    }
    if (self.selectedNames.count==0)
    {
        Send_Button.enabled=NO;
        Send_Button.backgroundColor=[UIColor clearColor];
        Send_Button.alpha=0.8;
        [Table_ContactView reloadData];
    }
    else
    {
        Send_Button.enabled=YES;
        Send_Button.backgroundColor=[UIColor clearColor];
        Send_Button.alpha=1;
    }
}

- (void)LCNContactPickerDidResize:(LCNContactPickerView *)contactPickerView{
    NSLog(@">>>>>ResizeViewHeight:%f",contactPickerView.frame.size.height);
    Table_ContactView.frame=CGRectMake(0, contactPickerView.frame.size.height+100, self.view.frame.size.width, self.view.frame.size.height-(contactPickerView.frame.size.height+100));
    [Table_ContactView reloadData];
}

- (BOOL)LCNContactPickerTextFieldShouldReturn:(LCNTextField *)textField{
//        NSString *displayName = textField.text;
//        [self.contactPickerView addContact:displayName withDisplayName:displayName];
     //  textField.text = @"";
   
    return YES;
}

- (void)LCNContactPickerDidSelectedContactView:(LCNContactView *)contactView
{
    NSLog(@">>>>>ContactView  selected=%@",contactView);
}

@end
