//
//  plantInfo
//  Final Project-Kim
//
//  Created by ETS Admin on 4/2/17.
//  Copyright © 2017 Joe. All rights reserved.
//
#import "plantInfo.h"
@implementation plantInfo
@synthesize isWatered;
@synthesize isPlanted;
@synthesize growTime;
@synthesize plantTime;
@synthesize lastWatered;
@synthesize location;
@synthesize plantType;
@synthesize plantStage;
@synthesize sellPrice;
@synthesize buyPrice;
@synthesize totalGrowTime;
NSInteger timeInterval = 3;

- (void) water
{
    //water the plant
    isWatered = true;
}

- (void) checkWater
{
    if ( lastWatered > 12*timeInterval*timeInterval)
    {   //plant has dried out
        isWatered = FALSE;
        lastWatered = 0;
    }
    else if (isWatered)
    {
        //1 second has passed (when this function is called)
        lastWatered ++;
        
        //plant has been alive for 1 more second
        if (isPlanted)
            plantTime++;
    }
}

- (void) harvest
{
    //reset the object because it has been harvested
    plantTime = 0;
    growTime = 0;
    isPlanted = false;
    plantType = EMPTY;
    plantStage = 0;
    sellPrice = 0;
    buyPrice = 0;
    totalGrowTime = 0;
}

- (NSMutableArray*) getAllPlants
{
    //returns an array of all possible plants
    //array used for creating store tableview and bag cellview
    NSMutableArray * allPlantsArr = [[NSMutableArray alloc] init];
    
    for (int i =1; i < plantTypeCount; i++)
    {
        plantInfo * pi = [plantInfo alloc];
        [pi plantCrop:(plantTypes) i];
        [allPlantsArr addObject:pi];
    }
    return allPlantsArr;
}

- (UIImage*) getImageForType
{
    //returns UIImage of fully grown plant
    switch(plantType)
    {
        default:
            return nil;
            
        case CAULIFLOWER:
            return [UIImage imageNamed: @"Cauliflower_Stage_6.png"];
            
        case MELON:
            return [UIImage imageNamed:@"Melon_Stage_6.png"];
            
        case POTATO:
            return [UIImage imageNamed:@"Potato_Stage_6.png"];
            
        case PUMPKIN:
            return [UIImage imageNamed:@"Pumpkin_Stage_6.png"];
            
        case RADISH:
            return [UIImage imageNamed:@"Radish_Stage_5.png"];
            
        case SUNFLOWER:
            return [UIImage imageNamed:@"Sunflower_Stage_5.png"];
            
        case SWEETGEMBERRY:
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_6.png"];
            
        case TULIP:
            return [UIImage imageNamed:@"Tulip_Stage_5.png"];
    }
}

- (NSString*) getPlantTypeString
{
    //return string name of this plant
    switch(plantType)
    {
        default:
            return @"Empty";
            
        case CAULIFLOWER:
            return @"Cauliflower";
        
        case MELON:
            return @"Melon";
            
        case POTATO:
            return @"Potato";
            
        case PUMPKIN:
            return @"Pumpkin";
            
        case RADISH:
            return @"Radish";
            
        case SUNFLOWER:
            return @"Sunflower";
            
        case SWEETGEMBERRY:
            return @"Sweet Gem Berry";
            
        case TULIP:
            return @"Tulip";
    }
}

- (UIImage*) plantCrop: (plantTypes) type
{
    //plant a crop and update its relevant variables
    //return the first growth stage of this plant
    isPlanted = true;
    plantTime = 0;
    plantType = type;
    plantStage = 1;
    
    switch(type)
    {
        default: EMPTY:
            sellPrice = 0;
            buyPrice = 0;
            growTime = 0;
            totalGrowTime = 0;
            return nil;
            
        case CAULIFLOWER:
            sellPrice = 175;
            buyPrice = 80;
            growTime += 1*timeInterval;
            totalGrowTime = 12*timeInterval;
            return [UIImage imageNamed: @"Cauliflower_Stage_1.png"];
            
        case MELON:
            sellPrice = 250;
            buyPrice = 80;
            growTime += 1*timeInterval;
            totalGrowTime = 12*timeInterval;
            return [UIImage imageNamed:@"Melon_Stage_1.png"];
            
        case POTATO:
            sellPrice = 80;
            buyPrice = 50;
            growTime += 1*timeInterval;
            totalGrowTime = 6*timeInterval;
            return [UIImage imageNamed:@"Potato_Stage_1.png"];
            
        case PUMPKIN:
            sellPrice = 320;
            buyPrice = 100;
            growTime += 1*timeInterval;
            totalGrowTime = 13*timeInterval;
            return [UIImage imageNamed:@"Pumpkin_Stage_1.png"];
            
        case RADISH:
            sellPrice = 90;
            buyPrice = 40;
            growTime += 2*timeInterval;
            totalGrowTime = 6*timeInterval;
            return [UIImage imageNamed:@"Radish_Stage_1.png"];
            
        case SUNFLOWER:
            sellPrice = 80;
            buyPrice = 200;
            growTime += 1*timeInterval;
            totalGrowTime = 8*timeInterval;
            return [UIImage imageNamed:@"Sunflower_Stage_1.png"];
            
        case SWEETGEMBERRY:
            sellPrice = 3000;
            buyPrice = 1000;
            growTime += 1*timeInterval;
            totalGrowTime = 24*timeInterval;
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_1.png"];
            
        case TULIP:
            sellPrice = 30;
            buyPrice = 20;
            growTime += 1*timeInterval;
            totalGrowTime = 6*timeInterval;
            return [UIImage imageNamed:@"Tulip_Stage_1.png"];
    }
}

- (double) remainingGrowTime
{
    //return how much time until it plant is ripe, otherwise, there is no plant
    if (totalGrowTime >= plantTime)
        return totalGrowTime - plantTime;
    else
        return 0;
}

- (UIImage*) upgrade
{
    //upgrade the plant's growth stage and return image of the new plant
    
    if (plantTime < growTime) //not ready to upgrade because it hasn't reached time for next stage (growtime)
        return nil;
    else    //plant can be upgraded
        plantStage++;
    
    switch(plantType)
    {
        default:
            return nil;
            
        case CAULIFLOWER:
            return [self upgradeCauliflower];
            
        case MELON:
            return [self upgradeMelon];
            
        case POTATO:
            return [self upgradePotato];
            
        case PUMPKIN:
            return [self upgradePumpkin];
            
        case RADISH:
            return [self upgradeRadish];
            
        case SUNFLOWER:
            return [self upgradeSunflower];
            
        case SWEETGEMBERRY:
            return [self upgradeSweetGemBerry];
            
        case TULIP:
            return [self upgradeTulip];
    }
}

- (BOOL) canHarvest
{
    //plant can be harvested if it is at its maximum stage
    switch (plantType)
    {
        default:
            return FALSE;
            
        case CAULIFLOWER:
            return plantStage >= 6;
            
        case MELON:
            return plantStage >= 6;
            
        case POTATO:
            return plantStage >= 6;
            
        case PUMPKIN:
            return plantStage >= 6;
            
        case RADISH:
            return plantStage >= 5;
            
        case SUNFLOWER:
            return plantStage >= 5;
            
        case SWEETGEMBERRY:
            return plantStage >= 6;
            
        case TULIP:
            return plantStage >= 5;
    }
}


- (void) saveData
{
    [[NSUserDefaults standardUserDefaults] setBool:isWatered
                                            forKey:[NSString stringWithFormat:@"isWatered%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setBool:isPlanted
                                            forKey:[NSString stringWithFormat:@"isPlanted%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setDouble:growTime
                                              forKey:[NSString stringWithFormat:@"growTime%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setDouble:totalGrowTime
                                              forKey:[NSString stringWithFormat:@"totalGrowTime%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:plantTime
                                              forKey:[NSString stringWithFormat:@"plantTime%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:lastWatered
                                              forKey:[NSString stringWithFormat:@"lastWatered%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:plantType
                                               forKey:[NSString stringWithFormat:@"plantType%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:plantStage
                                               forKey:[NSString stringWithFormat:@"plantStage%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:sellPrice
                                               forKey:[NSString stringWithFormat:@"sellPrice%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:buyPrice
                                               forKey:[NSString stringWithFormat:@"buyPrice%ld", (long)location]];
}

- (void) loadData
{
    isWatered = [[NSUserDefaults standardUserDefaults] boolForKey:
                 [NSString stringWithFormat:@"isWatered%ld", (long)location]];
    
    isPlanted = [[NSUserDefaults standardUserDefaults] boolForKey:
                 [NSString stringWithFormat:@"isPlanted%ld", (long)location]];
    
    growTime = [[NSUserDefaults standardUserDefaults] doubleForKey:
                [NSString stringWithFormat:@"growTime%ld", (long)location]];
    
    totalGrowTime = [[NSUserDefaults standardUserDefaults] doubleForKey:
                [NSString stringWithFormat:@"totalGrowTime%ld", (long)location]];

    plantTime = [[NSUserDefaults standardUserDefaults] integerForKey:
                 [NSString stringWithFormat:@"plantTime%ld", (long)location]];
    
    lastWatered = [[NSUserDefaults standardUserDefaults] integerForKey:
                   [NSString stringWithFormat:@"lastWatered%ld", (long)location]];
    
    plantType = (int) [[NSUserDefaults standardUserDefaults] integerForKey:
                       [NSString stringWithFormat:@"plantType%ld", (long)location]];
    
    plantStage = (int) [[NSUserDefaults standardUserDefaults] integerForKey:
                       [NSString stringWithFormat:@"plantStage%ld", (long)location]];
    
    sellPrice = (int) [[NSUserDefaults standardUserDefaults] integerForKey:
                       [NSString stringWithFormat:@"sellPrice%ld", (long)location]];
    
    buyPrice = (int) [[NSUserDefaults standardUserDefaults] integerForKey:
                       [NSString stringWithFormat:@"buyPrice%ld", (long)location]];
}

//remaining functions upgrades the plant to the next stage and updates the amount of time to reach the next stage
- (UIImage*) upgradeCauliflower
{
    
    switch (plantStage)
    {
        case 1:
            return [UIImage imageNamed:@"Cauliflower_Stage_1.png"];
        case 2:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Cauliflower_Stage_2.png"];
            
        case 3:
            growTime += 4*timeInterval;
            return [UIImage imageNamed:@"Cauliflower_Stage_3.png"];
            
        case 4:
            growTime += 4*timeInterval;
            return [UIImage imageNamed:@"Cauliflower_Stage_4.png"];
            
        case 5:
            growTime += 1*timeInterval;
            return [UIImage imageNamed:@"Cauliflower_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Cauliflower_Stage_6.png"];
    }
}
- (UIImage*) upgradeMelon
{
    switch (plantStage)
    {
        case 1:
            return [UIImage imageNamed:@"Melon_Stage_1.png"];
        case 2:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Melon_Stage_2.png"];
            
        case 3:
            growTime += 3*timeInterval;
            return [UIImage imageNamed:@"Melon_Stage_3.png"];
            
        case 4:
            growTime += 3*timeInterval;
            return [UIImage imageNamed:@"Melon_Stage_4.png"];
            
        case 5:
            growTime += 3*timeInterval;
            return [UIImage imageNamed:@"Melon_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Melon_Stage_6.png"];
    }
}
- (UIImage*) upgradePotato
{
    switch (plantStage)
    {
        case 1:
            return [UIImage imageNamed:@"Potato_Stage_1.png"];
        case 2:
            growTime += 1*timeInterval;
            return [UIImage imageNamed:@"Potato_Stage_2.png"];
            
        case 3:
            growTime += 1*timeInterval;
            return [UIImage imageNamed:@"Potato_Stage_3.png"];
            
        case 4:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Potato_Stage_4.png"];
            
        case 5:
            growTime += 1*timeInterval;
            return [UIImage imageNamed:@"Potato_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Potato_Stage_6.png"];
    }
}
- (UIImage*) upgradePumpkin
{
    switch (plantStage)
    {
        case 1:
            return [UIImage imageNamed:@"Pumpkin_Stage_1.png"];
        case 2:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Pumpkin_Stage_2.png"];
            
        case 3:
            growTime += 3*timeInterval;
            return [UIImage imageNamed:@"Pumpkin_Stage_3.png"];
            
        case 4:
            growTime += 4*timeInterval;
            return [UIImage imageNamed:@"Pumpkin_Stage_4.png"];
            
        case 5:
            growTime += 10*timeInterval;
            return [UIImage imageNamed:@"Pumpkin_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Pumpkin_Stage_6.png"];
    }
}
- (UIImage*) upgradeRadish
{
    switch (plantStage)
    {
        case 1:
            return [UIImage imageNamed:@"Radish_Stage_1.png"];
        case 2:
            growTime += 1*timeInterval;
            return [UIImage imageNamed:@"Radish_Stage_2.png"];
            
        case 3:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Radish_Stage_3.png"];
            
        case 4:
            growTime += 1*timeInterval;
            return [UIImage imageNamed:@"Radish_Stage_4.png"];
            
        default:
            return [UIImage imageNamed:@"Radish_Stage_5.png"];
    }
}
- (UIImage*) upgradeSunflower
{
    switch (plantStage)
    {
        case 1:
            return [UIImage imageNamed:@"Sunflower_Stage_1.png"];
        case 2:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Sunflower_Stage_2.png"];
            
        case 3:
            growTime += 3*timeInterval;
            return [UIImage imageNamed:@"Sunflower_Stage_3.png"];
            
        case 4:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Sunflower_Stage_4.png"];
            
        default:
            return [UIImage imageNamed:@"Sunflower_Stage_5.png"];
    }
}
- (UIImage*) upgradeSweetGemBerry
{
    switch (plantStage)
    {
        case 1:
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_1.png"];
        case 2:
            growTime += 4*timeInterval;
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_2.png"];
            
        case 3:
            growTime += 6*timeInterval;
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_3.png"];
            
        case 4:
            growTime += 6*timeInterval;
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_4.png"];
            
        case 5:
            growTime += 6*timeInterval;
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_6.png"];
    }
}
- (UIImage*) upgradeTulip
{
    switch (plantStage)
    {
        case 1:
            return [UIImage imageNamed:@"Tulip_Stage_1.png"];
        case 2:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Tulip_Stage_2.png"];
            
        case 3:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Tulip_Stage_3.png"];
            
        case 4:
            growTime += 2*timeInterval;
            return [UIImage imageNamed:@"Tulip_Stage_4.png"];
            
        default:
            return [UIImage imageNamed:@"Tulip_Stage_5.png"];
    }
}
@end
