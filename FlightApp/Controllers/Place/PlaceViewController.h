//
//  PlaceViewController.h
//  FlightApp
//
//  Created by Артем Чурсин on 10.03.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

typedef  enum PlaceType
{
    PlaceTypeArrival,
    PlaceTypeDeparture
} PlaceType;

@protocol  PlaceViewControllerDelegate < NSObject >
- (void) selectPlace:(id) place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;
@end

@interface PlaceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) id<PlaceViewControllerDelegate> delegate;
-(instancetype) initWithType:(PlaceType)type;

@end
