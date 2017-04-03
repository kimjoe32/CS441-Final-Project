//
//  groundPatch.h
//  Final Project-Kim
//
//  Created by ETS Admin on 4/2/17.
//  Copyright © 2017 Joe. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface groundPatch : NSObject  {
    
}

@property (nonatomic) BOOL isWatered;
@property (nonatomic) BOOL isPlanted;
@property (nonatomic) NSDate* plantTime;
@property (nonatomic) NSDate* lastWatered;
@property (nonatomic) NSTimeInterval growTime;
@property (nonatomic) NSInteger location;

- (void) water;
- (void) plantObject;
- (void) harvest;
- (BOOL) canHarvest;
- (void) saveData;
- (void) loadData;
- (void) killPlant
@end
