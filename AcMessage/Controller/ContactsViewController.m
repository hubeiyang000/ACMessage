//
//  ContactsViewController.m
//  AcMessage
//
//  Created by liuyang1204 on 14-10-23.
//  Copyright (c) 2014年 pro. All rights reserved.
//

#import "ContactsViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    //读取通讯录
    ABAddressBookRef addressBookRef = nil;
    if ([Util systemVersion] > 6.0) {
        addressBookRef = ABAddressBookCreateWithOptions(nil, nil);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            dispatch_semaphore_signal(sema);
        });
    }
    else
    {
        addressBookRef = ABAddressBookCreate();
    }
    
    //读取通讯录失败
    if (addressBookRef == nil) {
        return;
    }
    NSArray *peoples = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    //遍历通讯录中的联系人
    for(id tmpPerson in peoples)
    {
        //获取的联系人单一属性:First name
        NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        NSLog(@"First name:%@", tmpFirstName);
        
        //获取的联系人单一属性:Last name
        NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
        NSLog(@"Last name:%@", tmpLastName);
       
        //获取的联系人单一属性:Nickname
        NSString* tmpNickname = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonNicknameProperty);
        NSLog(@"Nickname:%@", tmpNickname);
       
        //获取的联系人单一属性:Company name
        NSString* tmpCompanyname = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonOrganizationProperty);
        NSLog(@"Company name:%@", tmpCompanyname);
        
        //获取的联系人单一属性:Job Title
        NSString* tmpJobTitle= (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonJobTitleProperty);
        NSLog(@"Job Title:%@", tmpJobTitle);
        
        //获取的联系人单一属性:Department name
        NSString* tmpDepartmentName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonDepartmentProperty);
        NSLog(@"Department name:%@", tmpDepartmentName);
     
        //获取的联系人单一属性:Email(s)
        ABMultiValueRef tmpEmails = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonEmailProperty);
        for(NSInteger j = 0; j < ABMultiValueGetCount(tmpEmails); j++)
        {
            NSString* tmpEmailIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpEmails, j);
            NSLog(@"Emails%d:%@", j, tmpEmailIndex);
        }
        CFRelease(tmpEmails);
        
        //获取的联系人单一属性:Birthday
        NSDate* tmpBirthday = (__bridge NSDate*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonBirthdayProperty);
        NSLog(@"Birthday:%@", tmpBirthday);
        
        //获取的联系人单一属性:Note
        NSString* tmpNote = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonNoteProperty);
        NSLog(@"Note:%@", tmpNote);
        
        //获取的联系人单一属性:Generic phone number
        ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
        for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
        {
            NSString* tmpPhoneIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
            NSLog(@"tmpPhoneIndex%d:%@", j, tmpPhoneIndex);
        }
        CFRelease(tmpPhones);
    }
}

- (NSFetchedResultsController *)fetchedResultControllerWithcontext:(NSManagedObjectContext *)managedObjectContext
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest= [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:managedObjectContext];
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
