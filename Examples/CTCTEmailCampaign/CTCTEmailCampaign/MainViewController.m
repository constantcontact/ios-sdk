//
//  MainViewController.m
//  CTCTEmailCampaign
//
//  Created by Vasile Gales on 4/18/13.
//  Copyright (c) 2013 Vasile Gales. All rights reserved.
//

#import "MainViewController.h"
#import "CTCTLoginViewController.h"
#import "LoadingView.h"
#import "CTCTGlobal.h"
#import "CampaignScheduleService.h"
#import "EmailCampaignService.h"
#import "ScheduleEmailCampaignViewController.h"
#import "VerifiedEmailAddresses.h"


@interface MainViewController ()


@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) ScheduleEmailCampaignViewController *scheduleEmailCampaignVC;
@property (nonatomic, readwrite) BOOL fromLists;
@property (nonatomic, weak) UITextField *currentFirstResponder;

@end

@implementation MainViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(0, 730);
    self.title = @"Email Campaign";
    self.listsVC = [[ListsTableViewController alloc] initWithNibName:@"ListsTableViewController" bundle:nil];
    self.scheduleEmailCampaignVC = [[ScheduleEmailCampaignViewController alloc] initWithNibName:@"ScheduleEmailCampaignViewController" bundle:nil];
    self.listsVC.selectedLists = [[NSMutableArray alloc] init];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
        
    self.emailCampaign = [[EmailCampaign alloc] init];
    
    self.navigationController.delegate = self;
}

- (void)viewDidUnload
{
    self.listsVC = nil;
    self.scheduleEmailCampaignVC = nil;
    self.loadingView = nil;
    self.emailCampaign = nil;
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.listsVC = nil;
    self.scheduleEmailCampaignVC = nil;
    self.loadingView = nil;
    self.emailCampaign = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.fromEmailAddressTextField.text = [CTCTGlobal shared].email;
    self.replyToEmailAddressTextField.text = [CTCTGlobal shared].email;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppear) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
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
            
            self.fromEmailAddressTextField.text = [CTCTGlobal shared].email;
            self.replyToEmailAddressTextField.text = [CTCTGlobal shared].email;
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

#pragma mark - Keyboard notifications

- (void)keyboardDidAppear
{
    CGRect scrollRect = self.view.frame;
    scrollRect.size.height -= 216;
    self.scrollView.frame = scrollRect;
}

- (void)keyboardWillDisappear
{
    self.scrollView.frame = self.view.frame;
}

#pragma mark - UItextView delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.currentFirstResponder = textField;
    
    if (textField == self.listTextField)
    {
        [self.view endEditing:YES];
        self.fromLists = YES;
        
        [self.navigationController pushViewController:self.listsVC animated:YES];
        
        return NO;
    }
    
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    
    if (pt.y < 0)
        pt.y = 0;
    
    [self.scrollView setContentOffset:pt animated:YES];
    
    return YES;
}

#pragma mark - UITextView delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark - campaign

- (BOOL)validate
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    
    if (self.nameTextField.text.length == 0)
    {
        alert.message = @"Please fill Name field";
        [alert show];
        return NO;
    }
    
    if (self.subjectTextField.text.length == 0)
    {
        alert.message = @"Please fill Subject field";
        [alert show];
        return NO;
    }
    
    if (self.fromNameTextField.text.length == 0)
    {
        alert.message = @"Please fill From Name field";
        [alert show];
        return NO;
    }
    
    if (self.listTextField.text.length == 0)
    {
        alert.message = @"You have not selected any Contact lists. Please select a list to continue.";
        [alert show];
        return NO;
    }
    
    if (self.textContentTextField.text.length == 0)
    {
        alert.message = @"Please fill Text Content field";
        [alert show];
        return NO;
    }
    
    return YES;
}

- (IBAction)createEmailCampaign:(id)sender
{
    [self.currentFirstResponder resignFirstResponder];
    
    if (![self validate])
        return;
    
    self.emailCampaign.fromEmail = [CTCTGlobal shared].email;
    self.emailCampaign.replyToEmail = [CTCTGlobal shared].email;
    self.emailCampaign.emailContentFormat = @"HTML";
    self.emailCampaign.greetingName = @"FIRST_AND_LAST_NAME";
    self.emailCampaign.fromName = self.fromNameTextField.text;
    self.emailCampaign.subject = self.subjectTextField.text;
    self.emailCampaign.status = @"RUNNING";
    self.emailCampaign.greetingString = @"Dear";
    self.emailCampaign.emailContent = [NSString stringWithFormat:@"<HTML><BODY>%@</BODY></HTML>", self.emailContentTextField.text];
    self.emailCampaign.textContent = self.textContentTextField.text;
    self.emailCampaign.name = self.nameTextField.text;
    
    
    MessageFooter *messageFooter = [[MessageFooter alloc] init];
    messageFooter.city = self.cityTextField.text;
    messageFooter.organizationMame = self.organizationNameTextField.text;
    messageFooter.addressLine1 = self.address1TextField.text;
    messageFooter.addressLine2 = self.address2TextField.text;
    messageFooter.addressLine3 = self.address3TextField.text;
    messageFooter.state = self.stateTextField.text;
    messageFooter.postalCode = self.postalCodeTextField.text;
    messageFooter.country = self.countryTextField.text;
    
    self.emailCampaign.messageFooter = messageFooter;
    
    [self showLoading];
    
    __block NSString *msg = @"";
    __block int tag = 0;
    
    dispatch_queue_t callService = dispatch_queue_create("callService", nil);
    dispatch_async(callService, ^{
        
        HttpResponse* response = [EmailCampaignService addCampaignWithToken:[CTCTGlobal shared].token  andCampaign:self.emailCampaign];
        

        if(response.statusCode != 201 )
        {
            if (response.errors.count > 0)
            {
                msg = ((HttpError*)[response.errors objectAtIndex:0]).message;
                tag = 10;
            }
        }
        else
        {
            EmailCampaign *campaign = response.data;
            self.scheduleEmailCampaignVC.campaignId = campaign.campaignId;
            
            tag = 20;
            msg = [NSString stringWithFormat:@"Campaign %@ added",campaign.name];
            
        }
                
        dispatch_async(dispatch_get_main_queue(), ^{
                        
            [self hideLoading];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            alert.tag = tag;
            [alert show];
            
        });
    });
    
}

- (void)clearAllFields
{
    for (UIView *v in self.scrollView.subviews)
    {
        if ([v isKindOfClass:[UITextField class]])
            ((UITextField*)v).text = @"";
    }
}

#pragma mark - UINavigationController delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self)
    {
        if (self.fromLists)
        {
            self.emailCampaign.sentToContactLists = [self.listsVC.selectedLists mutableCopy];
            
            NSMutableString *listsIds = [NSMutableString stringWithString:@""];
            if (self.emailCampaign.sentToContactLists.count > 0)
            {
                for (ContactList *list in self.emailCampaign.sentToContactLists)
                {
                    [listsIds appendFormat:@"%@, ", list.listId];
                }
                
                [listsIds deleteCharactersInRange:NSMakeRange(listsIds.length - 2, 2)];
            }
            self.listTextField.text = listsIds;
            
            self.fromLists = NO;
        }
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 20)
    {
        [self performSelectorInBackground:@selector(clearAllFields) withObject:nil];
        [self.navigationController pushViewController:self.scheduleEmailCampaignVC animated:YES];
    }
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


@end
