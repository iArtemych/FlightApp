//
//  APIManager.h
//  FlightApp
//
//  Created by Артем Чурсин on 10.03.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

@interface APIManager : NSObject

+ (instancetype)sharedInstance;
- (void)cityForCurrentIP:(void(^)(City *city))completion;

@end
