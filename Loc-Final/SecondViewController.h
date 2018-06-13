//
//  SecondViewController.h
//  Loc-Final
//
//  Created by Jin.Z  on 6/13/18.
//  Copyright © 2018 Jin.Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "databaseObject.h"

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *locationTable;

@property (weak, nonatomic) IBOutlet UIDatePicker *searchdate;
@property (strong, nonatomic) NSMutableArray *locationsArray;

@property (strong, nonatomic) databaseObject *dbObj1;

@property (strong, nonatomic) NSMutableDictionary *locationToPush;

@end

