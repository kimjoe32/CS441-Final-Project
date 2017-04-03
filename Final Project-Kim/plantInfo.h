//
//  plantInfo
//  Final Project-Kim
//
//  Created by ETS Admin on 4/2/17.
//  Copyright © 2017 Joe. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface plantInfo : NSObject  {
    
}

typedef enum
{
    EMPTY, CAULIFLOWER, MELON, POTATO, PUMPKIN, RADISH, SUNFLOWER, SWEETGEMBERRY, TULIP
} plantTypes;

@property (nonatomic) BOOL isWatered;
@property (nonatomic) BOOL isPlanted;
@property (nonatomic) NSDate* plantTime;
@property (nonatomic) NSDate* lastWatered;
@property (nonatomic) NSTimeInterval growTime;
@property (nonatomic) NSInteger location;
@property (nonatomic) plantTypes plantType;
@property (nonatomic) NSInteger plantStage;

- (void) water;
- (void) plantCrop: (plantTypes) type;
- (void) harvest;
- (BOOL) canHarvest;
- (void) saveData;
- (void) loadData;
- (void) killPlant;
- (UIImage*) upgrade;
- (UIImage*) upgradeCauliflower;
- (UIImage*) upgradeMelon;
- (UIImage*) upgradePotato;
- (UIImage*) upgradePumpkin;
- (UIImage*) upgradeRadish;
- (UIImage*) upgradeSunflower;
- (UIImage*) upgradeSweetGemBerry;
- (UIImage*) upgradeTulip;
@end
