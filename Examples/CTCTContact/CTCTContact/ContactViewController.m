//
//  ContactViewController.m
//  ConstantContact
//
//  Created by Sergiu Grigoriev on 1/7/13.
//  Copyright (c) 2013 Sergiu Grigoriev. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactsCollection.h"
#import "CTCTGlobal.h"
#import "LoadingView.h"
#import "MainViewController.h"

@interface ContactViewController ()<UIScrollViewDelegate,UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, readwrite) BOOL fromLists;
@property (nonatomic, readwrite) BOOL fromCustomFiels;
@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) UIResponder *currentResponder;

@end

@implementation ContactViewController

@synthesize mainViewController;
@synthesize idField;
@synthesize statusField;
@synthesize firstNameField;
@synthesize lastNameField;
@synthesize lastUpdateField;
@synthesize sourceDetailsField;
@synthesize workPhoneField;
@synthesize cellPhoneField;
@synthesize homePhoneField;
@synthesize faxField;
@synthesize prefixField;
@synthesize jobTitleField;
@synthesize companyNameField;


@synthesize listTextField;
@synthesize customFieldsField;
@synthesize email1TextField;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.frame.size;
    
    self.listsVC = [[ListsTableViewController alloc] initWithNibName:@"ListsTableViewController" bundle:nil];
    self.customFieldsVC = [[ContactCustomFieldsViewController alloc] initWithNibName:@"ContactCustomFieldsViewController" bundle:nil];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];

    self.navigationController.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.idField.text.length == 0)
        self.contactToEdit = self.contactToEdit;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppear) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [self setIdField:nil];
    [self setStatusField:nil];
    [self setFirstNameField:nil];
    [self setLastNameField:nil];
    [self setLastUpdateField:nil];
    [self setSourceDetailsField:nil];
    [self setWorkPhoneField:nil];
    [self setCellPhoneField:nil];
    [self setHomePhoneField:nil];
    [self setFaxField:nil];
    [self setPrefixField:nil];
    [self setJobTitleField:nil];
    [self setCompanyNameField:nil];
    [self setScrollView:nil];
    [self setAddContact_Button:nil];
    [self setUpdateContactInfo:nil];
    [self setListTextField:nil];
    [self setCustomFieldsField:nil];
    [self setEmail1TextField:nil];
    [self setEmail2TextField:nil];
    [self setNoteTextView:nil];
    
    self.loadingView = nil;
    self.listsVC = nil;
    self.customFieldsVC = nil;
}

- (void)viewDidUnload
{
    [self setIdField:nil];
    [self setStatusField:nil];
    [self setFirstNameField:nil];
    [self setLastNameField:nil];
    [self setLastUpdateField:nil];
    [self setSourceDetailsField:nil];
    [self setWorkPhoneField:nil];
    [self setCellPhoneField:nil];
    [self setHomePhoneField:nil];
    [self setFaxField:nil];
    [self setPrefixField:nil];
    [self setJobTitleField:nil];
    [self setCompanyNameField:nil];
    [self setScrollView:nil];
    [self setAddContact_Button:nil];
    [self setUpdateContactInfo:nil];
    [self setListTextField:nil];
    [self setCustomFieldsField:nil];
    [self setEmail1TextField:nil];
    [self setEmail2TextField:nil];
    [self setNoteTextView:nil];
    
    [self setAddressLine1Field:nil];
    [self setAddressLine2Field:nil];
    [self setAddressLine3Field:nil];
    [self setCityField:nil];
    [self setStateUSField:nil];
    [self setStateOtherField:nil];
    [self setZipField:nil];
    [self setSubZipField:nil];
    [self setCountryField:nil];
    [self setMiddleNameField:nil];
    
    self.loadingView = nil;
    self.listsVC = nil;
    self.customFieldsVC = nil;
    
    [self setContentView:nil];
    [super viewDidUnload];
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

#pragma mark - IB

- (IBAction)updateButton:(id)sender
{
    [self.currentResponder resignFirstResponder];
    
    self.contactToEdit.homePhone = self.homePhoneField.text;
    self.contactToEdit.workPhone = self.cellPhoneField.text;
    self.contactToEdit.cellPhone = self.cellPhoneField.text;
    self.contactToEdit.status =  self.statusField.text;
    self.contactToEdit.firstName =  self.firstNameField.text;
    self.contactToEdit.middleName = self.middleNameField.text;
    self.contactToEdit.lastName =  self.lastNameField.text;
    self.contactToEdit.fax = self.faxField.text ;
    self.contactToEdit.prefixName =self.prefixField.text;
    self.contactToEdit.companyName = self.companyNameField.text;
    self.contactToEdit.jobTitle = self.jobTitleField.text;
    self.contactToEdit.sourceDetails = self.sourceDetailsField.text;

    Address *address = [[Address alloc] init];
    
    address.addressType = @"PERSONAL";
    address.line1 = self.addressLine1Field.text;
    address.line2 = self.addressLine2Field.text;
    address.line3 = self.addressLine3Field.text;
    address.city = self.cityField.text;
    address.stateProvince = self.stateUSField.text;
    address.stateCode = self.stateOtherField.text;
    address.postalCode = self.zipField.text;
    address.subPostalCode = self.subZipField.text;
    address.countryCode = self.countryField.text;
    
    [self.contactToEdit.addresses setObject:address atIndexedSubscript:0];
    
    Note *note;
    
    if (self.contactToEdit.notes.count > 0)
    {
        note = [self.contactToEdit.notes objectAtIndex:0];
        note.note = self.noteTextView.text;
    }
    else
    {
        note = [[Note alloc] init];
        note.note = self.noteTextView.text;
        [self.contactToEdit.notes addObject:note];
    }

    NSDictionary *emailAdressDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                                     self.email1TextField.text,@"email_address",
                                     @"CONFIRMED",@"confirm_status",
                                     @"ACTIVE",@"status",
                                     @"ACTION_BY_VISITOR",@"opt_in_source",
                                     @"11 12 2012",@"opt_in_date",
                                     @"11 12 2012",@"opt_out_date"
                                     , nil];
    
    EmailAddress *emailAdress2 = [[EmailAddress alloc] initWithDictionary:emailAdressDict];
    
    self.contactToEdit.emailAddresses = [NSMutableArray arrayWithObject:emailAdress2];
    
    __block NSString *msg = @"";
    
    [self showLoading];
    
    dispatch_queue_t callService = dispatch_queue_create("callService", nil);
    dispatch_async(callService, ^{
                
        HttpResponse *response = [ContactsCollection updateContact:self.contactToEdit  withAccessToken:[CTCTGlobal shared].token actionByVisitor:NO];
        
        if(response.statusCode != 200)
        {
            msg = ((HttpError*)[response.errors objectAtIndex:0]).message;
        }
        else
        {
            Contact *cont = response.data;
            msg = [NSString stringWithFormat:@"Contact %@ %@ was updated", cont.firstName, cont.lastName];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideLoading];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            self.scrollView.contentOffset = CGPointMake(0, 0);
        });
    });

}

- (IBAction)addContactButton:(id)sender
{
    if (![self validate])
        return;
    
    [self.currentResponder resignFirstResponder];
    
    self.contactToEdit.homePhone = self.homePhoneField.text;
    self.contactToEdit.workPhone = self.cellPhoneField.text;
    self.contactToEdit.cellPhone = self.cellPhoneField.text;
    self.contactToEdit.status =  self.statusField.text;
    self.contactToEdit.firstName =  self.firstNameField.text;
    self.contactToEdit.middleName = self.middleNameField.text;
    self.contactToEdit.lastName =  self.lastNameField.text;
    self.contactToEdit.fax = self.faxField.text ;
    self.contactToEdit.prefixName =self.prefixField.text;
    self.contactToEdit.companyName = self.companyNameField.text;
    self.contactToEdit.jobTitle = self.jobTitleField.text;
    self.contactToEdit.sourceDetails = self.sourceDetailsField.text;
    
    Address *address = [[Address alloc] init];
    
    address.addressType = @"PERSONAL";
    address.line1 = self.addressLine1Field.text;
    address.line2 = self.addressLine2Field.text;
    address.line3 = self.addressLine3Field.text;
    address.city = self.cityField.text;
    address.stateProvince = self.stateUSField.text;
    address.stateCode = self.stateOtherField.text;
    address.postalCode = self.zipField.text;
    address.subPostalCode = self.subZipField.text;
    address.countryCode = self.countryField.text;
    
    [self.contactToEdit.addresses setObject:address atIndexedSubscript:0];
    
    Note *note;
    
    if (self.contactToEdit.notes.count > 0)
    {
        note = [self.contactToEdit.notes objectAtIndex:0];
        note.note = self.noteTextView.text;
    }
    else
    {
        note = [[Note alloc] init];
        note.note = self.noteTextView.text;
        [self.contactToEdit.notes addObject:note];
    }
    
    NSDictionary *emailAdressDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                                     self.email1TextField.text,@"email_address",
                                     @"CONFIRMED",@"confirm_status",
                                     @"ACTIVE",@"status",
                                     @"ACTION_BY_OWNER",@"opt_in_source",
                                     @"11 12 2012",@"opt_in_date",
                                     @"11 12 2012",@"opt_out_date"
                                     , nil];
    
    EmailAddress *emailAdress2 = [[EmailAddress alloc] initWithDictionary:emailAdressDict];
    
    self.contactToEdit.emailAddresses = [NSMutableArray arrayWithObject:emailAdress2];
    
    __block NSString *msg = @"";
    __block int tag = 0;
    
    [self showLoading];
    
    dispatch_queue_t callService = dispatch_queue_create("callService", nil);
    dispatch_async(callService, ^{
        
        
        HttpResponse *response = [ContactsCollection addContact:self.contactToEdit withAccessToken:[CTCTGlobal shared].token  actionByVisitor:NO];
        
        if(response.statusCode != 201)
        {
            msg = ((HttpError*)[response.errors objectAtIndex:0]).message;
        }
        else
        {
            Contact *cont = response.data;
            msg = [NSString stringWithFormat:@"Contact %@ %@ was added", cont.firstName, cont.lastName];
            tag = 1;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideLoading];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            alert.tag = tag;
            [alert show];
            
            self.scrollView.contentOffset = CGPointMake(0, 0);
        });
    });
    
}

- (void)saveContact
{
    self.contactToEdit.homePhone = self.homePhoneField.text;
    self.contactToEdit.workPhone = self.cellPhoneField.text;
    self.contactToEdit.cellPhone = self.cellPhoneField.text;
    self.contactToEdit.status =  self.statusField.text;
    self.contactToEdit.firstName =  self.firstNameField.text;
    self.contactToEdit.middleName = self.middleNameField.text;
    self.contactToEdit.lastName =  self.lastNameField.text;
    self.contactToEdit.fax = self.faxField.text ;
    self.contactToEdit.prefixName =self.prefixField.text;
    self.contactToEdit.companyName = self.companyNameField.text;
    self.contactToEdit.jobTitle = self.jobTitleField.text;
    self.contactToEdit.sourceDetails = self.sourceDetailsField.text;
    
    Address *address = [[Address alloc] init];
    
    address.addressType = @"PERSONAL";
    address.line1 = self.addressLine1Field.text;
    address.line2 = self.addressLine2Field.text;
    address.line3 = self.addressLine3Field.text;
    address.city = self.cityField.text;
    address.stateProvince = self.stateUSField.text;
    address.stateCode = self.stateOtherField.text;
    address.postalCode = self.zipField.text;
    address.subPostalCode = self.subZipField.text;
    address.countryCode = self.countryField.text;
    
    [self.contactToEdit.addresses setObject:address atIndexedSubscript:0];
    
    Note *note;
    
    if (self.contactToEdit.notes.count > 0)
    {
        note = [self.contactToEdit.notes objectAtIndex:0];
        note.note = self.noteTextView.text;
    }
    else
    {
        if (!self.contactToEdit.notes)
            self.contactToEdit.notes = [[NSMutableArray alloc] init];
        note = [[Note alloc] init];
        note.note = self.noteTextView.text;
        [self.contactToEdit.notes addObject:note];
    }
    
}

#pragma mark - Setters

- (void)setContactToEdit:(Contact *)contactToEdit
{
    _contactToEdit = contactToEdit;
    
    self.title = [NSString stringWithFormat:@"%@ %@", self.contactToEdit.firstName, self.contactToEdit.lastName];
    
    self.idField.text = self.contactToEdit.contactId;
    
    self.homePhoneField.text = self.contactToEdit.homePhone;
    self.workPhoneField.text = self.contactToEdit.workPhone;
    self.cellPhoneField.text = self.contactToEdit.cellPhone;
    self.statusField.text = self.contactToEdit.status;
    self.firstNameField.text = self.contactToEdit.firstName;
    self.middleNameField.text = self.contactToEdit.middleName;
    self.lastNameField.text = self.contactToEdit.lastName;
    self.faxField.text = self.contactToEdit.fax;
    self.prefixField.text = self.contactToEdit.prefixName;
    self.companyNameField.text = self.contactToEdit.companyName;
    self.jobTitleField.text = self.contactToEdit.jobTitle;
    self.sourceDetailsField.text = self.contactToEdit.sourceDetails;
    self.lastUpdateField.text = self.contactToEdit.modifiedDate;

    Address *address;
    
    if (self.contactToEdit.addresses.count > 0)
        address = [self.contactToEdit.addresses objectAtIndex:0];
    else
        address = [[Address alloc] init];
        
    self.addressLine1Field.text = address.line1;
    self.addressLine2Field.text = address.line2;
    self.addressLine3Field.text = address.line3;
    self.cityField.text = address.city;
    self.stateUSField.text = address.stateProvince;
    self.stateOtherField.text = address.stateCode;
    self.zipField.text = address.postalCode;
    self.subZipField.text = address.subPostalCode;
    self.countryField.text = address.countryCode;
    
    
    if (self.contactToEdit.emailAddresses.count > 0)
        self.email1TextField.text = ((EmailAddress*)[self.contactToEdit.emailAddresses objectAtIndex:0]).emailAddress;
    if (self.contactToEdit.emailAddresses.count > 1)
        self.email2TextField.text = ((EmailAddress*)[self.contactToEdit.emailAddresses objectAtIndex:1]).emailAddress;
    if (self.contactToEdit.notes.count > 0)
        self.noteTextView.text = ((Note*)[self.contactToEdit.notes objectAtIndex:0]).note;
    else
        self.noteTextView.text = @"";
    
    NSMutableString *listsIds = [NSMutableString stringWithString:@""];
    if (self.contactToEdit.lists.count > 0)
    {
        for (ContactList *list in self.contactToEdit.lists)
        {
            [listsIds appendFormat:@"%@, ", list.listId];
        }
        
        [listsIds deleteCharactersInRange:NSMakeRange(listsIds.length - 2, 2)];
    }
    
    NSMutableString *customFieldsValues = [NSMutableString stringWithString:@""];
    if (self.contactToEdit.customFields.count > 0)
    {
        for (CustomField *customField in self.contactToEdit.customFields)
            if (customField.value.length > 0)
                [customFieldsValues appendFormat:@"%@, ", customField.value];
        if (customFieldsValues.length > 1)
            [customFieldsValues deleteCharactersInRange:NSMakeRange(customFieldsValues.length - 2, 2)];
    }
    
    self.customFieldsField.text = customFieldsValues;
    self.listTextField.text = listsIds;

    if (!self.fromLists)
        self.listsVC.selectedLists = [self.contactToEdit.lists mutableCopy];
    if (!self.fromCustomFiels)
        self.customFieldsVC.customFieldsArray = [self.contactToEdit.customFields mutableCopy];
    
    if (self.idField.text.length == 0)
    {
        self.addContact_Button.hidden = NO;
        self.UpdateContactInfo.hidden = YES;
    }
    else
    {
        self.addContact_Button.hidden = YES;
        self.UpdateContactInfo.hidden = NO;
    }
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.listTextField)
    {
        [self.view endEditing:YES];
        self.fromLists = YES;
        [self saveContact];
        
        [self.navigationController pushViewController:self.listsVC animated:YES];
        
        return NO;
    }
    else if (textField == self.customFieldsField)
    {
        self.fromCustomFiels = YES;
        [self saveContact];
        [self.view endEditing:YES];
        
        [self.navigationController pushViewController:self.customFieldsVC animated:YES];
    
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentResponder = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.firstNameField || textField == self.lastNameField)
        self.title = [NSString stringWithFormat:@"%@ %@", self.firstNameField.text, self.lastNameField.text];
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

#pragma mark - UINavigationController delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self)
    {
        if (self.fromLists)
        {
            self.contactToEdit.lists = [self.listsVC.selectedLists mutableCopy];
            
            NSMutableString *listsIds = [NSMutableString stringWithString:@""];
            if (self.contactToEdit.lists.count > 0)
            {
                for (ContactList *list in self.contactToEdit.lists)
                {
                    [listsIds appendFormat:@"%@, ", list.listId];
                }
                
                [listsIds deleteCharactersInRange:NSMakeRange(listsIds.length - 2, 2)];
            }
            self.listTextField.text = listsIds;
            
            self.fromLists = NO;
        }
        
        if (self.fromCustomFiels)
        {
            self.contactToEdit.customFields = [self.customFieldsVC.customFieldsArray mutableCopy];
            
            NSMutableString *customFieldsValues = [NSMutableString stringWithString:@""];
            if (self.contactToEdit.customFields.count > 0)
            {
                for (CustomField *customField in self.contactToEdit.customFields)
                    if (customField.value.length > 0)
                        [customFieldsValues appendFormat:@"%@, ", customField.value];
                if (customFieldsValues.length > 1)
                    [customFieldsValues deleteCharactersInRange:NSMakeRange(customFieldsValues.length - 2, 2)];
            }
            
            self.customFieldsField.text = customFieldsValues;
            
            self.fromCustomFiels = NO;
        }
    }
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        self.mainViewController.wasAdded = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
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

#pragma mark - Utilities

- (BOOL)validate
{
    if (self.listTextField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please add lists" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    return YES;
}


@end
