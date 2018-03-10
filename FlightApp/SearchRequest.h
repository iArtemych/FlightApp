//
//  SearchRequest.h
//  FlightApp
//
//  Created by Артем Чурсин on 10.03.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct SearchRequest {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destination;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;
