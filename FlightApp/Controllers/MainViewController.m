//
//  ViewController.m
//  FlightApp
//
//  Created by Артем Чурсин on 10.03.2018.
//  Copyright © 2018 Артем Чурсин. All rights reserved.
//

#import "MainViewController.h"
#import "DataManager.h"
#import "SearchRequest.h"
#import "PlaceViewController.h"
#import "APIManager.h"

@interface MainViewController () <PlaceViewControllerDelegate>

@property(nonatomic, strong) UIView  *placeContainerView;
@property(nonatomic, strong) UIButton *departureButton;
@property(nonatomic, strong) UIButton *arrivalButton;
@property(nonatomic) SearchRequest searchRequest;
@property(nonatomic ,strong) UIButton *searchButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[DataManager sharedInstance] loadData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title =  @"Поиск";
    
    _placeContainerView = [[UIView alloc] initWithFrame : CGRectMake (20.0, 140.0, [UIScreen mainScreen].bounds.size.width - 40.0, 170.0)];
    _placeContainerView.backgroundColor = [UIColor whiteColor];
    _placeContainerView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent : 0.1]CGColor];
    _placeContainerView.layer.shadowOffset = CGSizeZero;
    _placeContainerView.layer.shadowRadius = 20.0 ;
    _placeContainerView.layer.shadowOpacity =  1.0 ;
    _placeContainerView.layer.cornerRadius = 6.0 ;
    
    _departureButton = [ UIButton buttonWithType:UIButtonTypeSystem];
    [_departureButton setTitle: @"Откуда" forState: UIControlStateNormal];
    _departureButton.tintColor = [UIColor blackColor];
    _departureButton.frame =  CGRectMake(10.0, 20.0, _placeContainerView.frame.size.width -20.0, 60.0);
    _departureButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent: 0.1];
    [_departureButton addTarget: self action: @selector(placeButtonDidTap:) forControlEvents: UIControlEventTouchUpInside];
//    [self.view addSubview:_departureButton];
    [self.placeContainerView addSubview: _departureButton ];
    
    _arrivalButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [_arrivalButton setTitle: @"Куда" forState: UIControlStateNormal];
    _arrivalButton.tintColor = [UIColor blackColor];
    _arrivalButton.frame = CGRectMake(10.0, CGRectGetMaxY(_departureButton.frame) +  10.0, _placeContainerView.frame.size.width - 20.0, 60.0 );
    _arrivalButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent: 0.1];
    [_arrivalButton addTarget: self action: @selector( placeButtonDidTap:)forControlEvents: UIControlEventTouchUpInside];

    //    [self.view addSubview:_arrivalButton];
    [self.placeContainerView addSubview: _arrivalButton ];
    
    [ self.view addSubview :_placeContainerView ];
    
    
    _searchButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [_searchButton setTitle : @"Найти" forState : UIControlStateNormal ];
    _searchButton.tintColor = [UIColor whiteColor];
    _searchButton.frame = CGRectMake(30.0, CGRectGetMaxY(_placeContainerView.frame) + 30, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    _searchButton.backgroundColor = [UIColor blackColor];
    _searchButton.layer.cornerRadius = 8.0 ;
    _searchButton.titleLabel.font = [UIFont systemFontOfSize: 20.0 weight: UIFontWeightBold];
    [self.view addSubview: _searchButton ];
    
    [[NSNotificationCenter defaultCenter] addObserver: self  selector: @selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete  object: nil] ;

//    CGRect frame  =  CGRectMake( [ UIScreen  mainScreen].bounds.size.width/ 2 -   100.0,  [  UIScreen mainScreen].bounds.size.height/ 2 -   25.0,  200.0,   50.0) ; UIButton * button  = [  UIButton  buttonWithType:  UIButtonTypeSystem] ;
//    [button setTitle :  @"Go" forState :UIControlStateNormal];
//
//    button.frame  = frame;
//    [button  addTarget: self  action: @selector(toSecond:)forControlEvents: UIControlEventTouchUpInside] ;
//    [self. view  addSubview:button];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self  name:kDataManagerLoadDataDidComplete object: nil];
}
- (void)dataLoadedSuccessfully
{
    [[APIManager sharedInstance] cityForCurrentIP :^( City  *city)
    {
        [self setPlace:city withDataType: DataSourceTypeCity andPlaceType: PlaceTypeDeparture forButton: _departureButton ];
    }];
}

- (void)placeButtonDidTap:(UIButton*)sender
{
    PlaceViewController *placeViewController;
    if([sender isEqual:_departureButton])
    {
        placeViewController = [[PlaceViewController alloc] initWithType: PlaceTypeDeparture];
    }
    else
    {
        placeViewController = [[PlaceViewController alloc] initWithType: PlaceTypeArrival];
    }
    placeViewController.delegate = self;
    [self.navigationController pushViewController: placeViewController animated: YES] ;
}

- (void) setPlace:(id) place withDataType:(DataSourceType)dataType andPlaceType:(PlaceType)placeType forButton:( UIButton *)button
{
    NSString *title;
    NSString *iata;
    if (dataType == DataSourceTypeCity)
    {
        City *city = (City *)place; title = city.name;
        iata = city.code;
    }
    else if (dataType == DataSourceTypeAirport)
    {
        Airport *airport = (Airport *)place; title = airport.name;
        iata = airport.cityCode;
    }
    if (placeType == PlaceTypeDeparture)
    {
        _searchRequest.origin = iata;
    }
    else
    {
        _searchRequest.destination = iata;
    }
    [button setTitle: title forState:  UIControlStateNormal];
}

- ( void)selectPlace:(id) place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType
{
    [self setPlace:place withDataType:dataType andPlaceType:placeType forButton: (placeType == PlaceTypeDeparture) ? _departureButton : _arrivalButton ];
}




//
//- (void) loadDataComplete
//{
//    self.view.backgroundColor = [UIColor yellowColor];
//}

//-(void)toSecond:(UIButton *)sender
//{
//    NSLog(@"FUUCK");
//    TableViewController *seco = [[TableViewController alloc] init];
//    [self.navigationController pushViewController: seco animated:YES];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
