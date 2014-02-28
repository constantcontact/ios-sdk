//
//  EventSpotService.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventRegistrantExtended.h"
#import "EventItemAttribute.h"
#import "EventRegistrant.h"
#import "EventPromocode.h"
#import "EventExtended.h"
#import "HttpRequest.h"
#import "EventPatch.h"
#import "EventItem.h"
#import "ResultSet.h"
#import "EventFee.h"
#import "Config.h"
#import "Event.h"

@interface EventSpotService : NSObject

#pragma mark - event collection

/**
 * Retrieve a list of all events in the user's account.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param int limit - (optional) the number of elements to be returned, default 50;
 *
 * @return HttpResponse * - response containing data and errors (if there are some), Result set containing array of Event items
 */
+ (HttpResponse *)getEventCollectionWithAccessToken:(NSString*)accessToken withALimitOf:(int)limit;

/**
 * A new EventSpot event using a event extended object
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param EventExtended *event - the event that needs to be added
 *
 * @return HttpResponse * - response containing either errors or data with the specific EventSpot created, data contains Event type item
 */
+ (HttpResponse*)addEventWithToken:(NSString *)accessToken andEvent:(EventExtended *)event;

#pragma mark - individual event

/**
 * Retrieve an event specified by the eventId path parameter
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to retrieve
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Extended type item
 */
+ (HttpResponse *)getEventWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId;


/**
 * Update an existing event by using the eventId path parameter.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to update
 * @param EventExtended *event - the event that needs to be updated
 *
 * @return HttpResponse * - response containing either errors or data with the updated EventSpot, data contains Event type item
 */
+ (HttpResponse*)updateEventWithAccesToken:(NSString *)accessToken withEventId:(NSString *)eventId andEvent:(EventExtended *)event;

/**
 * The API uses the PATCH method to publish or cancel an event by only changing the value of the event's status property:
 * - Publishing an event changes status from DRAFT to ACTIVE
 * - Cancelling an event changes status from ACTIVE to CANCELLED
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to patch
 *
 * @return HttpResponse * - response containing either errors or data with the updated EventSpot, data contains Event Extended type item
 */
+ (HttpResponse*)patchEventWithAccesToken:(NSString *)accessToken withEventId:(NSString *)eventId action:(EventPatch *)patch;

#pragma mark - event fees collection

/**
 * Retrieve all fees for the event fee specified by the eventId path parameter
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event fee to retrieve
 *
 * @return HttpResponse * - response containing data and errors (if there are some),data contains array of Event Fee items
 */
+ (HttpResponse *)getEventFeesCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId;

/**
 * Create a new fee for the event specified using the eventId path parameter, and a event fee object.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event fee to which we will add the fee
 * @param EventFee *eventFee - the event fee that needs to be added
 *
 * @return HttpResponse * - response containing either errors or data with the specific EventSpot fee created,
 */
+ (HttpResponse*)addEventFeeWithToken:(NSString *)accessToken withEventId:(NSString *)eventId andEventFee:(EventFee *)eventFee;

#pragma mark - individual event fee

/**
 * Retrieve a specific fee for an event, specified using the eventId and feeId path parameters.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to retrieve
 * @param NSString *feeId - Unique ID of the event fee to retrieve
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Fee item
 */
+ (HttpResponse *)getEventFeeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andFeeId:(NSString *)feeId;

/**
 * Update an existing fee (specify using feeId) for an event specified by eventId.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to retrieve
 * @param NSString *feeId - Unique ID of the event fee to update
 * @param EventFee *eventFee - the event fee that needs to be updated
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Fee item that was updated
 */
+ (HttpResponse *)updateEventFeeWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId feeId:(NSString *)feeId andEventFee:(EventFee *)eventFee;

/**
 * Delete an existing fee (specified by feeId) for an event (specified by eventId). An event is required to have a minimum of 1 fee. You cannot delete a fee if it is the only fee for the event specified.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to retrieve
 * @param NSString *feeId - Unique ID of the event fee to delete
 *
 * @return BOOL - returns if the delete opperation was succesfull or not
 */
+ (BOOL)deleteEventFeeWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId andFeeId:(NSString *)feeId errors:(NSArray *__autoreleasing *)errors;

#pragma mark - promocode collection

/**
 * Retrieve all promocodes for an event specified by the eventId path parameter.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event which will have it's promocodes returned
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Promocode item array
 */
+ (HttpResponse *)getPromocodeCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId;

/**
 * Create a promotional code for an existing event (specified using eventId). Promotional codes can be:
 * -a percentage discount off a fee or set of fees
 * -a fixed discount amount off a fee
 * -a special promotional fee available by entering the promo code
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to post the promocode to
 * @param EventPromocode *promocode - the promocode that will get added
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Promocode item created
 */
+ (HttpResponse *)addPromocodeWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId  andPromocode:(EventPromocode *)promocode;

#pragma mark - individual promocode

/**
 * Retrieve a specific promotional code for an event; use the promocodeId and eventId path parameters to specify the code and event.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to which the promocode belongs to
 * @param NSString *promocodeId - Unique ID of the promocode to retrieve
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Promocode item
 */
+ (HttpResponse *)getPromocodeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andPromocodeId:(NSString *)promocodeId;

/**
 * Update an existing promocode for an event; specify the code and event using the eventId and promocodeId path parameters.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to which the promocode belongs to
 * @param NSString *promocodeId - Unique ID of the promocode to update
 * @param EventPromocode *promocode - the promocode that will be updated
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Promocode item updated
 */
+ (HttpResponse *)updatePromocodeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andPromocodeId:(NSString *)promocodeId andPromocode:(EventPromocode *)promocode;

/**
 * Delete an existing promocode specified using the promocodeId path parameter.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to which the promocode belongs to
 * @param NSString *promocodeId - Unique ID of the promocode to delete
 *
 * @return BOOL - returns if the delete opperation was succesfull or not
 */
+ (BOOL)deletePromocodeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andPromocodeId:(NSString *)promocodeId errors:(NSArray *__autoreleasing *)errors;

#pragma mark - event registrant collection

/**
 * Retrieve a list of all registrants for the event specified using the event_id path parameter.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event from which all registrants are returned
 * @param int limit - (optional) the number of elements to be returned, default 50;
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains EventRegistrant item array
 */
+ (HttpResponse *)getEventRegistrantCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId withALimitOf:(int)limit;

#pragma mark - individual event registrant

/**
 * Retrieve detailed information about a specific registrant (specified by registrantId) for an event (specified by eventId).
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event from which all registrants are returned
 * @param NSString *registrantId - Unique ID of the registrant to retrieve
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains EventRegistrantExtended item
 */
+ (HttpResponse *)getEventRegistrantWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andRegistrantId:(NSString *)registrantId;

#pragma mark - event Item collection

/**
 * Retrieve a list of all items for an event specified using the eventId path parameter.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event which will have it's items returned
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Item array
 */
+ (HttpResponse *)getEventItemCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId;

/**
 * Create a new item for an event specified using the eventId path parameter.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event to post the item to
 * @param EventItem *item - the item that will get added
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Item added
 */
+ (HttpResponse *)addEventItemWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId  andItem:(EventItem *)item;

#pragma mark - individual event Item

/**
 * Retrieve an event item by using the eventId and itemId path parameters to specify the event and item.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event that contains the desired item
 * @param NSString *itemId - Unique ID of the item to retrieve
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Item object
 */
+ (HttpResponse *)getEventItemWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andItemId:(NSString *)itemId;

/**
 * Update an existing event item; specify the event and the item using the eventId and itemId path parameters.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event that contains the desired item
 * @param NSString *itemId - Unique ID of the item to retrieve
 * @param EventItem *item - the item that will get updated
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Item that was updated
 */
+ (HttpResponse *)updateEventItemWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId andItem:(EventItem *)item;

/**
 * Delete an event item by using the eventId and itemId path parameters to specify the event and item.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event that contains the desired item
 * @param NSString *itemId - Unique ID of the item to delete
 *
 * @return BOOL - returns weather the delete option was succesfull or not
 */
+ (BOOL)deleteEventItemWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andItemId:(NSString *)itemId errors:(NSArray *__autoreleasing *)errors;

#pragma mark - event Item attribute collection

/**
 * Retrieve all attributes for an event item. Specify the event and item using the eventId and itemId path parameters.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event that containes the desired item
 * @param NSString *itemId - Unique ID of the item whos parameters you want to retrieve
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Item Attribute array of objects
 */
+ (HttpResponse *)getEventItemAttributeCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andItemId:(NSString *)itemId;

/**
 * Create a new attribute for an event item; specify the event and item using the eventId and itemId path parameters.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event that containes the items you want
 * @param NSString *itemId - Unique ID of the item whos parameters you want to update
 * @param EventItemAttribute *itemAttribute - the event item attribute object that you want to add
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Item Attribute object
 */
+ (HttpResponse *)addEventItemAttributeWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId andItemAttribute:(EventItemAttribute *)itemAttribute;

#pragma mark - individual event Item attribute

/**
 * Retrieve a specific event item attribute usimg the eventId, itemId, and attributeId path parameters to specify the attribute.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event that containes the desired item
 * @param NSString *itemId - Unique ID of the item whos parameters you want to retrieve
 * @param NSString *attributeId - The specific attribute object you want to retrieve
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Item Attribute object
 */
+ (HttpResponse *)getEventItemAttributeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId andAttributeId:(NSString *)attributeId;

/**
 * Update an existing item attribute by specifying the eventId, itemId, and attributeId path parameters.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event that containes the desired item
 * @param NSString *itemId - Unique ID of the item whos parameters you want to retrieve
 * @param NSString *attributeId - The specific attribute object you want to retrieve
 * @param EventItemAttribute *itemAttribute - the event item attribute object that you want to update to
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Event Item Attribute that was updated
 */
+ (HttpResponse *)updateEventItemAttributeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId attributeId:(NSString *)attributeId andAttribute:(EventItemAttribute *)itemAttribute;

/**
 * Delete an existing event item attribute. Use the eventId, itemId, and attributeId path parameters to specify the attribute to delete.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *eventId - Unique ID of the event that containes the desired item
 * @param NSString *itemId - Unique ID of the item whos parameters you want to retrieve
 * @param NSString *attributeId - The specific attribute object you want to delete
 *
 * @return BOOL - returns weather the delete option was succesfull or not
 */
+ (BOOL)deleteEventItemAttributeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId andAttributeId:(NSString *)attributeId errors:(NSArray *__autoreleasing *)errors;

@end
