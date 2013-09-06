//
//  ContactViewController.h
//  ConstantContact
//
//  Created by Sergiu Grigoriev on 1/7/13.
//  Copyright (c) 2013 Sergiu Grigoriev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsCollection.h"
#import "ListsTableViewController.h"
#import "ContactCustomFieldsViewController.h"

@class MainViewController;

@interface ContactViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, weak) MainViewController *mainViewController;

@property (nonatomic, strong) Contact *contactToEdit;
@property (nonatomic, strong) ListsTableViewController *listsVC;
@property (nonatomic, strong) ContactCustomFieldsViewController *customFieldsVC;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UITextField *idField;
@property (weak, nonatomic) IBOutlet UITextField *statusField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *middleNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastUpdateField;
@property (weak, nonatomic) IBOutlet UITextField *sourceDetailsField;
@property (weak, nonatomic) IBOutlet UITextField *workPhoneField;
@property (weak, nonatomic) IBOutlet UITextField *cellPhoneField;
@property (weak, nonatomic) IBOutlet UITextField *homePhoneField;
@property (weak, nonatomic) IBOutlet UITextField *faxField;
@property (weak, nonatomic) IBOutlet UITextField *prefixField;

@property (weak, nonatomic) IBOutlet UITextField *jobTitleField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameField;

@property (weak, nonatomic) IBOutlet UIButton *addContact_Button;
@property (weak, nonatomic) IBOutlet UIButton *UpdateContactInfo;

@property (weak, nonatomic) IBOutlet UITextField *listTextField;
@property (weak, nonatomic) IBOutlet UITextField *customFieldsField;
@property (weak, nonatomic) IBOutlet UITextField *email1TextField;
@property (weak, nonatomic) IBOutlet UITextField *email2TextField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UITextField *addressLine1Field;
@property (weak, nonatomic) IBOutlet UITextField *addressLine2Field;
@property (weak, nonatomic) IBOutlet UITextField *addressLine3Field;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *stateUSField;
@property (weak, nonatomic) IBOutlet UITextField *stateOtherField;
@property (weak, nonatomic) IBOutlet UITextField *zipField;
@property (weak, nonatomic) IBOutlet UITextField *subZipField;
@property (weak, nonatomic) IBOutlet UITextField *countryField;

@end
