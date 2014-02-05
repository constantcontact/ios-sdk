//
//  EventTypeEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventTypeEnum.h"

@implementation EventTypeEnum

- (id)init
{
    if (self = [super init])
    {
        _auction = @"AUCTION";
        _birthday = @"BIRTHDAY";
        _businessFinanceSales = @"BUSINESS_FINANCE_SALES";
        _classesWorkshops = @"CLASSES_WORKSHOPS";
        _competitionSports = @"COMPETITION_SPORTS";
        _conferencesSeminarsForum = @"CONFERENCES_SEMINARS_FORUM";
        _conventionsTradeshowsExpos = @"CONVENTIONS_TRADESHOWS_EXPOS";
        _festivalsFairs = @"FESTIVALS_FAIRS";
        _foodWine = @"FOOD_WINE";
        _fundraisersCharities = @"FUNDRAISERS_CHARITIES";
        _holiday = @"HOLIDAY";
        _incentiveRewardRecognition = @"INCENTIVE_REWARD_RECOGNITION";
        _moviesFilm = @"MOVIES_FILM";
        _musicConcerts = @"MUSIC_CONCERTS";
        _networkingClubs = @"NETWORKING_CLUBS";
        _performingArts = @"PERFORMING_ARTS";
        _outdoorsRecreation = @"OUTDOORS_RECREATION";
        _religionSpirituality = @"RELIGION_SPIRITUALITY";
        _schoolsReunionsAlumni = @"SCHOOLS_REUNIONS_ALUMNI";
        _partiesSocialEventsMixers = @"PARTIES_SOCIAL_EVENTS_MIXERS";
        _travel = @"TRAVEL";
        _webinarTeleseminarTeleclass = @"WEBINAR_TELESEMINAR_TELECLASS";
        _weddings = @"WEDDINGS";
        _other = @"OTHER";
    }
    return self;
}

@end
