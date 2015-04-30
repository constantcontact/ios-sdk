
Constant Contact IOS SDK
=========================

## Installation

In order to use the Constant Contact SDK you have to follow these steps:

1) Open the project in Xcode

2) Drag The Constant Contact Folder into the Project Navigation Panel.

3) Be sure to make the following selections in the popup:
  Folders :            "Create groups for ant added folders" 
	Add to targets: "<yourProjectName>"
	Destination:     "Copy items into destination group's folder(if needed)"

## Documentation

The source documentation is hosted at http://constantcontact.github.io/ios-sdk

API Documentation is located at http://developer.constantcontact.com/docs/developer-guides/api-documentation-index.html

## Usage

1) Include the following code in the file you wish to use the SDK:


`#import  "Config.h"`                  -for api key and other configuration elements
<br>
`#import  "ContactsCollection.h"`      -for contact collection manipulation
<br>
`#import  "ListsCollection.h"`         -for list collection manipulation
<br>
`#import  "ActivityService.h"`         -for activity manipulation
<br>
`#import  "EmailCampaignService.h"`    -for email campaign manipulation
<br>
`#import  "CampaignScheduleService.h"` -for campaign schedule manipulation
<br>
`#import  "CampaignTrackingService.h"` -for campaign tracking manipulation
<br>
`#import  "ContactTrackingService.h"`  -for contact tracking manipulation
<br>
`#import  "VerifiedEmailAddress.h"`  -to obtain the valid email addresses used in some calls


2) Create an authentication object using your user credentials:

###Instantiate your credentials 

In the Config directory open the Congif.plist file.

Select the config drop down section and fill in your `consumer_secret`, `api_key`, and `redirect_uri` keys.

###Authentication 

3) Show authentication view


        CTCTLoginViewController *loginViewController = [[CTCTLoginViewController alloc] init];
            loginViewController.delegate = self;
   
        [self presentModalViewController:loginViewController animated:YES];

4) Get the access token

Respond to the following delegate method:

        - (void)loginViewController:(CTCTLoginViewController *)loginViewController didLoginWithAccessToken:(NSString *)accessToken;

 Note: Requesting the access token implicitly means that you are giving the all the permissions needed by the SDK, no further permissions are required.

3) Start using the SDK.

##Example for getting a array of contacts
```
HttpResponse *result = [ContactsCollection contactsWithAccessToken: myToken withLimitOf:10];
NSArray *contactArray = result.data;
```
