//
//  DataManager.h
//  FlightApp
//
//  Created by Артем Чурсин on 10.03.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"
#import "City.h"
#import "Airport.h"

#define kDataManagerLoadDataDidComplete  @"DataManagerLoadDataDidComplete"
typedef enum DataSourceType
{
    DataSourceTypeCountry,
    DataSourceTypeCity,
    DataSourceTypeAirport
}  DataSourceType;

@interface DataManager : NSObject

+ (instancetype) sharedInstance;
- (void) loadData;
@property (nonatomic, strong, readonly) NSArray *countries;
@property (nonatomic, strong, readonly) NSArray *cities;
@property (nonatomic, strong, readonly) NSArray *airports;

- (City*)cityForIATA:( NSString  *)iata;

@end
