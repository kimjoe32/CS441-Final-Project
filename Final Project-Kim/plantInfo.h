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
    EMPTY, CAULIFLOWER, MELON, POTATO, PUMPKIN, RADISH, SUNFLOWER, SWEETGEMBERRY, TULIP, plantTypeCount
} plantTypes;

@property (nonatomic) BOOL isWatered;
@property (nonatomic) BOOL isPlanted;
@property (nonatomic) NSInteger plantTime;
@property (nonatomic) NSInteger lastWatered;
@property (nonatomic) NSInteger growTime;
@property (nonatomic) NSInteger totalGrowTime;
@property (nonatomic) NSInteger location;
@property (nonatomic) plantTypes plantType;
@property (nonatomic) NSInteger plantStage;
@property (nonatomic) NSInteger sellPrice;
@property (nonatomic) NSInteger buyPrice;

- (void) water;
- (UIImage*) plantCrop: (plantTypes) type;
- (void) harvest;
- (BOOL) canHarvest;
- (void) saveData;
- (void) loadData;
- (double) remainingGrowTime;

- (NSMutableArray*) getAllPlants;
- (UIImage*) getImageForType;
- (NSString*) getPlantTypeString;
- (UIImage*) upgrade;
- (UIImage*) upgradeCauliflower;
- (UIImage*) upgradeMelon;
- (UIImage*) upgradePotato;
- (UIImage*) upgradePumpkin;
- (UIImage*) upgradeRadish;
- (UIImage*) upgradeSunflower;
- (UIImage*) upgradeSweetGemBerry;
- (UIImage*) upgradeTulip;
- (void) checkWater;
@end
