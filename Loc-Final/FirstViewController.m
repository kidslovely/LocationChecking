//
//  FirstViewController.m
//  Loc-Final
//
//  Created by Jin.Z  on 6/12/18.
//  Copyright © 2018 Jin.Z. All rights reserved.
//

#import "FirstViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "databaseObject.h"

@interface FirstViewController () <CLLocationManagerDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];

    _dbObj = [[databaseObject alloc] init];
    
    [[self locationManager] setDelegate:self];
   
    if([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [[self locationManager] requestWhenInUseAuthorization];
    }

    if(![[NSFileManager defaultManager] fileExistsAtPath:[_dbObj getDbFilePath]])
    {
        [_dbObj createTable];
    }

    [[self mapView] setShowsUserLocation:YES];    

    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    static NSDate *previous;
    static int run = 0;
    
    CLLocation *location = locations.lastObject;
    
    if (run == 0 || [location.timestamp timeIntervalSinceDate:previous] > 60)
    {
        [_dbObj insert: location.coordinate.latitude : location.coordinate.longitude : [NSDate date] : location.timestamp];
        
        previous = location.timestamp;
        
        run++;
    }
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2*1609.34, 2*1609.34);
    
    [[self mapView] setRegion:viewRegion animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
