{\rtf1\ansi\ansicpg1252\cocoartf1138\cocoasubrtf470
{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww18060\viewh9440\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs22 \cf0 \
Constant Contact IOS SDK\
=========================\
\
## Installation\
\
In order to use the Constant Contact SDK you have to follow these steps:\
\
1) Open the project in Xcode\
\
2) Drag The Constant Contact Folder into the Project Navigation Panel.\
\
3) On the popup make shire you have selected:\
  Folders :            "Create groups for ant added folders" \
	Add to targets: "<yourProjectName>"\
	Destination:     "Copy items into destination group's folder(if needed)"\
\
## Usage\
\
1) In the file you wish to use the SDK include the following code in your header file:\
\
`#import "CTCTOAuth2.h"`               -for the authentication process\
<br>\
`#import  "Config.h"`                  -for api key and other configuration elements\
<br>\
`#import  "ContactsCollection.h"`      -for contact collection manipulation\
<br>\
`#import  "ListsCollection.h"`         -for list collection manipulation\
<br>\
`#import  "ActivityService.h"`         -for activity manipulation\
<br>\
`#import  "EmailCampaignService.h"`    -for email campaign manipulation\
<br>\
`#import  "CampaignScheduleService.h"` -for campaign schedule manipulation\
<br>\
`#import  "CampaignTrackingService.h"` -for campaign tracking manipulation\
<br>\
`#import  "ContactTrackingService.h"`  -for contact tracking manipulation\
<br>\
`#import  "VerriffiedEmailAddress.h"`  -to obtain the valid email addresses used in some calls\
\
\
2) Create a authentication object with your user credentials:\
\
###### Instantiate your credentials \
\
In the Config directory open the Congif.plist file.\
\
Select the config drop down section fill in your `consumer_secret`, `api_key`, and `redirect_uri` keys.\
 \
\
######Store the values in a "CTCTOAuth2" object \
```\
CTCTOAuth2 *ctctOauth2 = [[CTCTOAuth2 alloc] initWithClientID:[Config valueForType:@"config" key:@"api_key"]\
									    redirectURI:[Config valueForType:@"config" key:@"redirect_uri"]\
									    userName:YourUserName \
									    password:YourPassword];\
```\
\
Note: 'your redirect url' is the URL of the action you just created.\
\
3) Make the call for the user token using the initiated "CTCTOAuth2" object, and save the token in a object of your choosing.\
\
```\
NSString *myToken = [ctctOauth2 accessToken];\
```\
\
 Note: Requesting the access token implicitly implies that you are giving the all the permissions needed by the SDK, no further permissions are required.\
\
4) Start using the SDK.\
\
######Example for getting a array of contacts\
```\
NSDictionary *result = [ContactsCollection contactsWithAccessToken: myToken];\
NSArray *contactArray = [result objectForKey:@"data"];\
```\
}