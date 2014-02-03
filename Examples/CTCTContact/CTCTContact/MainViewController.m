//
//  ViewController.m
//  CTCTContact
//
//  Created by Sergiu Grigoriev on 3/28/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
//

#import "MainViewController.h"
#import "CTCTLoginViewController.h"
#import "ContactsCollection.h"
#import "LoadingView.h"
#import "ContactViewController.h"
#import "CTCTGlobal.h"
#import "VerifiedEmailAddresses.h"
#import "ResultSet.h"

@interface MainViewController () <CTCTLoginDelegate>

@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) ContactViewController *contactVC;
@property (nonatomic, readwrite) BOOL addContact;

@end

@implementation MainViewController

@synthesize wasAdded = _wasAdded;
@synthesize emailTextField = _emailTextField;
@synthesize tableView = _tableView;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Contacts";
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
        
    self.contactVC = [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:nil];
    self.contactVC.mainViewController = self;
    self.addContact = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        
    if ([CTCTGlobal shared].token.length == 0)
    {
        CTCTLoginViewController *loginViewController = [[CTCTLoginViewController alloc] init];
        loginViewController.delegate = self;
        
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 60000)
        [self presentViewController:loginViewController animated:YES completion:nil];
#else
        [self presentModalViewController:loginViewController animated:YES];
#endif
    }
    
    else if (self.wasAdded)
    {
        [self onSearch:nil];
        self.wasAdded = NO;
    }
}

- (void)viewDidUnload
{
    [self setEmailTextField:nil];
    [self setTableView:nil];
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    [self setEmailTextField:nil];
    [self setTableView:nil];
}

#pragma mark - IB

- (IBAction)onSearch:(id)sender
{
    if (self.emailTextField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter email" message:@"Email address cannot be empty" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else if (![self isValidEmail:self.emailTextField.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a valid email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self showLoading];
        [self.emailTextField resignFirstResponder];
        
        dispatch_queue_t callService = dispatch_queue_create("callService", nil);
        dispatch_async(callService, ^{
            
            
            HttpResponse *response =  [ContactsCollection contactsWithAccessToken:[CTCTGlobal shared].token andEmail:self.emailTextField.text withALimitOf:0];
            
            if(response.statusCode != 200)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:((HttpError*)[response.errors objectAtIndex:0]).message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                ResultSet *set = response.data;
                self.contacts = set.results;
                if (self.contacts.count == 0)
                    self.addContact = YES;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                [self hideLoading];
                
            });
        });
        dispatch_release(callService);

    }
}

#pragma mark - CTCTLogin delegate

- (void)loginViewController:(CTCTLoginViewController *)loginViewController didLoginWithAccessToken:(NSString *)accessToken
{
    [CTCTGlobal shared].token = accessToken;
    
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 60000)
        [self dismissViewControllerAnimated:YES completion:nil];
#else
        [self dismissModalViewControllerAnimated:YES];
#endif
    
    [self showLoading];
    
    dispatch_queue_t callService = dispatch_queue_create("callService", nil);
    dispatch_async(callService, ^{
        
        
        HttpResponse *response = [VerifiedEmailAddresses getEmailAddresses:accessToken andConfirmedStatus:@"CONFIRMED"];
        
        if(response.statusCode != 200)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:((HttpError*)[response.errors objectAtIndex:0]).message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            NSArray *verifiedEmails = response.data;
            EmailAddress *vEmail = [verifiedEmails objectAtIndex:0];
            [CTCTGlobal shared].email = vEmail.emailAddress;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideLoading];
            
        });
    });

}

- (void)loginViewControllerDidCancelAuthentication:(CTCTLoginViewController *)loginViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginViewControllerDidDeniedAccess:(CTCTLoginViewController *)loginViewController
{
    [loginViewController reloadLogin];
}

#pragma mark - UITableView delegate and dataSource

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Contacts";
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.addContact)
        return 1;
    
    return self.contacts.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ContactCell"];
    }
    
    if (self.contacts.count > 0)
    {
        Contact *contact = [self.contacts objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
        cell.detailTextLabel.text = contact.status;
    }
    else
    {
        cell.textLabel.text = @"Add contact";
        cell.detailTextLabel.text = self.emailTextField.text;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    Contact *contact = nil;
    
    if (self.contacts.count > 0)
    {
        contact = [self.contacts objectAtIndex:indexPath.row];
    }
    else
    {
        contact = [[Contact alloc] init];
        EmailAddress *emailAddress = [[EmailAddress alloc] initWithEmailAddress:self.emailTextField.text];
        [contact.emailAddresses addObject:emailAddress];
       
        if (self.contactVC.listsVC && self.contactVC.listsVC.selectedLists.count > 0)
            [self.contactVC.listsVC.selectedLists removeAllObjects];
        
        if (self.contactVC.customFieldsVC)
            [self.contactVC.customFieldsVC clearAll];
        
        self.addContact = NO;
    }
    
    self.contactVC.contactToEdit = contact;

    [self.navigationController pushViewController:self.contactVC animated:YES];
}

#pragma mark - Loading

- (void)showLoading
{
    [self.loadingView showLoadingInView:self.view];
}

- (void)hideLoading
{
    [self.loadingView hideLoading];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Utilities

- (BOOL)isValidEmail:(NSString *)emailString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailString];
}

@end
