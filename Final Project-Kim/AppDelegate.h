//
//  AppDelegate.h
//  Final Project-Kim
//
//  Created by ETS Admin on 4/2/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "plantInfo.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) NSInteger money;
@property (nonatomic) plantInfo* selectedPlant;
@property (nonatomic) NSInteger plantingCount;
@end

