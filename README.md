Constant Contact IOS SDK
=========================

## Installation

In order to use the Constant Contact SDK you have to follow these steps:

1) Open the project in Xcode

2) Drag The Constant Contact Folder into the Project Navigation Panel.

3) On the popup make shire you have selected:
	Folders :            "Create groups for ant added folders" 
	Add to targets: "<yourProjectName>"
	Destination:     "Copy items into destination group's folder(if needed)"

## Usage

1) In the file you wish to use the SDK include the following code in your header file:

`#import "CTCTOAuth2.h"`            -for the authentication process
<br>
`#import  "ContactsCollection.h"` -for contact collection manipulation
<br>
`#import  "ListsCollection.h"`         -for list collection manipulation

2) Create a authentication object with your user credentials:

###### Put your SDK access credentials in Config.plist file under Config
```api_key```<br>
```consumer_secret```<br>
```redirect_uri```<br>

######Store the values in a "CTCTOAuth2" object 
```
CTCTOAuth2 *ctctOauth2 = [[CTCTOAuth2 alloc] initWithClientID:clId 
											 redirectURI:uri
										     userName:name 
											 password:pass];
```

Note: 'your redirect url' is the URL of the action you just created.

3) Make the call for the user token using the initiated "CTCTOAuth2" object, and save the token in a object of your choosing.

```
NSString *myToken = [ctctOauth2 accessToken];
```

 Note: Requesting the access token implicitly implies that you are giving the all the permissions needed by the SDK, no further permissions are required.

4) Start using the SDK.

######Example for getting a array of contacts
```
NSArray *contactArray = [ContactsCollection contactsWithAccessToken: myToken];
```
