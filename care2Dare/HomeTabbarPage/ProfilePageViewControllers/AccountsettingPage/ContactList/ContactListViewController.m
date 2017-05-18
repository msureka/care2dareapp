//
//  ContactListViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 5/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ContactListViewController.h"
#import <Contacts/Contacts.h>

@interface ContactListViewController ()
{
    NSString * name,*phoneNumber,*emailAddress;
    NSMutableArray * Array_contatList;
    CNContactStore *store;
}
@end

@implementation ContactListViewController
@synthesize cell_contact,tableview_contact;
- (void)viewDidLoad {
    [super viewDidLoad];
    Array_contatList=[[NSMutableArray alloc]init];
    store = [[CNContactStore alloc] init];
    [self contactListData];
}
-(IBAction)Button_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)contactListData
{
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error)
     {
        if (granted == YES)
        {
            //keys with fetching properties
            NSArray *keys = @[CNContactFamilyNameKey,CNContactEmailAddressesKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
            NSString *containerId = store.defaultContainerIdentifier;
            NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
            NSError *error;
            NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
            if (error)
            {
                NSLog(@"error fetching contacts %@", error);
            } else
            {
                for (CNContact *contact in cnContacts)
                {
                    NSLog(@"Contacts123== %@",contact);
                    NSLog(@"Name== %@%@%@", contact.givenName,@" ",contact.familyName);
                    name=[NSString stringWithFormat:@"%@%@%@", contact.givenName,@" ",contact.familyName];
                    
                    for (CNLabeledValue * label in contact.emailAddresses)
                    {
                        NSString *Email = label.value;
                        if ([Email length] > 0)
                        {
                            emailAddress=[NSString stringWithFormat:@"%@",Email];
                            NSLog(@"Email==%@", Email);
                        }
                    }
                    
                    for (CNLabeledValue *label in contact.phoneNumbers)
                    {
                        NSString *phone = [label.value stringValue];
                        if ([phone length] > 0)
                        {
                            phoneNumber=[NSString stringWithFormat:@"%@",phone];
                            NSLog(@"phone=== %@", phone);
                        }
                    }
                    
                    NSMutableDictionary *Contact_dict = [[NSMutableDictionary alloc] init];
                    if (name !=nil && ![name isEqualToString:@" "])
                    {
                    [Contact_dict setObject:name forKey:@"name"];
                    }
                    else
                    {
                        [Contact_dict setObject:@"Unkown" forKey:@"name"];
                    }
                    if (phoneNumber !=nil && ![phoneNumber isEqualToString:@""])
                    {
                        [Contact_dict setObject:phoneNumber forKey:@"phone"];
                    }
                    if (emailAddress !=nil && ![emailAddress isEqualToString:@""])
                    {
                        [Contact_dict setObject:emailAddress forKey:@"email"];
                    }
                    
                    
                    if ((emailAddress !=nil && ![emailAddress isEqualToString:@""]) || (phoneNumber !=nil && ![phoneNumber isEqualToString:@""]) )
                    {
                         [Array_contatList addObject:Contact_dict];
                    }
                   
                    name=nil;
                    emailAddress=nil;
                    phoneNumber=nil;
                }
                
                
                NSLog(@"Array_contatList11==%@", Array_contatList);
                if (Array_contatList.count!=0)
                {
                    [tableview_contact reloadData];
                }
            }
        }        
    }];
    
    NSLog(@"Array_contatList22==%@", Array_contatList);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return Array_contatList.count;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellone=@"CellCon";
    
    
    cell_contact = (ContactTableViewCell *)[tableview_contact dequeueReusableCellWithIdentifier:cellone forIndexPath:indexPath];
    NSDictionary * dictVal=[Array_contatList objectAtIndex:indexPath.row];
    cell_contact.label_one.text=[dictVal valueForKey:@"name"];
    cell_contact.label_two.text=[dictVal valueForKey:@"email"];
    cell_contact.label_three.text=[dictVal valueForKey:@"phone"];
    
    
    return cell_contact;
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

@end
