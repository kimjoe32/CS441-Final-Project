//
//  StoreViewController.h
//  Final Project-Kim
//
//  Created by ETS Admin on 4/21/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "plantInfo.h"
#import "AppDelegate.h"

@interface StoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *plantsListTableView;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@end
