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

- (void) water
{
    isWatered = true;
    lastWatered = [NSDate date];
}

- (void) killPlant
{
    isPlanted = FALSE;
    growTime = 0;
    plantTime = 0;
    plantType = EMPTY;
    plantStage = 0;
    sellPrice = 0;
    buyPrice = 0;
    totalGrowTime = 0;
}

- (NSMutableArray*) getAllPlants
{
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
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_6"];
            
        case TULIP:
            return [UIImage imageNamed:@"Tulip_Stage_5.png"];
    }
}

- (NSString*) getPlantTypeString
{
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

- (void) plantCrop: (plantTypes) type
{
    isPlanted = true;
    plantTime = [NSDate date];
    plantType = type;
    plantStage = 1;
    
    switch(type)
    {
        default: EMPTY:
            sellPrice = 0;
            buyPrice = 0;
            growTime = 0;
            totalGrowTime = 0;
            
        case CAULIFLOWER:
            sellPrice = 175;
            buyPrice = 0;
            growTime += 1*60;
            totalGrowTime = 12*60;
            
        case MELON:
            sellPrice = 250;
            buyPrice = 0;
            growTime += 1*60;
            totalGrowTime = 12*60;
            
        case POTATO:
            sellPrice = 80;
            buyPrice = 0;
            growTime += 1*60;
            totalGrowTime = 6*60;
            
        case PUMPKIN:
            sellPrice = 320;
            buyPrice = 0;
            growTime += 1*60;
            totalGrowTime = 13*60;
            
        case RADISH:
            sellPrice = 90;
            buyPrice = 0;
            growTime += 2*60;
            totalGrowTime = 6*60;
            
        case SUNFLOWER:
            sellPrice = 80;
            buyPrice = 0;
            growTime += 1*60;
            totalGrowTime = 8*60;
            
        case SWEETGEMBERRY:
            sellPrice = 3000;
            buyPrice = 0;
            growTime += 1*60;
            totalGrowTime = 24*60;
            
        case TULIP:
            sellPrice = 30;
            buyPrice = 0;
            growTime += 1*60;
            totalGrowTime = 6*60;
    }
}

- (double) remainingGrowTime
{
    return totalGrowTime - growTime;
}

- (void) harvest
{
    plantTime = nil;
    growTime = 0;
    isPlanted = false;
    plantType = EMPTY;
    plantStage = 0;
    sellPrice = 0;
    buyPrice = 0;
    totalGrowTime = 0;
}

- (UIImage*) upgrade
{
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
    
    [[NSUserDefaults standardUserDefaults] setObject:plantTime
                                              forKey:[NSString stringWithFormat:@"plantTime%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setObject:lastWatered
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

    plantTime = [[NSUserDefaults standardUserDefaults] objectForKey:
                 [NSString stringWithFormat:@"plantTime%ld", (long)location]];
    
    lastWatered = [[NSUserDefaults standardUserDefaults] objectForKey:
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

- (UIImage*) upgradeCauliflower
{
    switch (plantStage)
    {
        case 2:
            growTime += 2*60;
            return [UIImage imageNamed:@"Cauliflower_Stage_2.png"];
            
        case 3:
            growTime += 4*60;
            return [UIImage imageNamed:@"Cauliflower_Stage_3.png"];
            
        case 4:
            growTime += 4*60;
            return [UIImage imageNamed:@"Cauliflower_Stage_4.png"];
            
        case 5:
            growTime += 1*60;
            return [UIImage imageNamed:@"Cauliflower_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Cauliflower_Stage_6.png"];
    }
}
- (UIImage*) upgradeMelon
{
    switch (plantStage)
    {
        case 2:
            growTime += 2*60;
            return [UIImage imageNamed:@"Melon_Stage_2.png"];
            
        case 3:
            growTime += 3*60;
            return [UIImage imageNamed:@"Melon_Stage_3.png"];
            
        case 4:
            growTime += 3*60;
            return [UIImage imageNamed:@"Melon_Stage_4.png"];
            
        case 5:
            growTime += 3*60;
            return [UIImage imageNamed:@"Melon_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Melon_Stage_6.png"];
    }
}
- (UIImage*) upgradePotato
{
    switch (plantStage)
    {
        case 2:
            growTime += 1*60;
            return [UIImage imageNamed:@"Potato_Stage_2.png"];
            
        case 3:
            growTime += 1*60;
            return [UIImage imageNamed:@"Potato_Stage_3.png"];
            
        case 4:
            growTime += 2*60;
            return [UIImage imageNamed:@"Potato_Stage_4.png"];
            
        case 5:
            growTime += 1*60;
            return [UIImage imageNamed:@"Potato_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Potato_Stage_6.png"];
    }
}
- (UIImage*) upgradePumpkin
{
    switch (plantStage)
    {
        case 2:
            growTime += 2*60;
            return [UIImage imageNamed:@"Pumpkin_Stage_2.png"];
            
        case 3:
            growTime += 3*60;
            return [UIImage imageNamed:@"Pumpkin_Stage_3.png"];
            
        case 4:
            growTime += 4*60;
            return [UIImage imageNamed:@"Pumpkin_Stage_4.png"];
            
        case 5:
            growTime += 10*60;
            return [UIImage imageNamed:@"Pumpkin_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Pumpkin_Stage_6.png"];
    }
}
- (UIImage*) upgradeRadish
{
    switch (plantStage)
    {
        case 2:
            growTime += 1*60;
            return [UIImage imageNamed:@"Radish_Stage_2.png"];
            
        case 3:
            growTime += 2*60;
            return [UIImage imageNamed:@"Radish_Stage_3.png"];
            
        case 4:
            growTime += 1*60;
            return [UIImage imageNamed:@"Radish_Stage_4.png"];
            
        default:
            return [UIImage imageNamed:@"Radish_Stage_5.png"];
    }
}
- (UIImage*) upgradeSunflower
{
    switch (plantStage)
    {
        case 2:
            growTime += 2*60;
            return [UIImage imageNamed:@"Sunflower_Stage_2.png"];
            
        case 3:
            growTime += 3*60;
            return [UIImage imageNamed:@"Sunflower_Stage_3.png"];
            
        case 4:
            growTime += 2*60;
            return [UIImage imageNamed:@"Sunflower_Stage_4.png"];
            
        default:
            return [UIImage imageNamed:@"Sunflower_Stage_5.png"];
    }
}
- (UIImage*) upgradeSweetGemBerry
{
    switch (plantStage)
    {
        case 2:
            growTime += 4*60;
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_2.png"];
            
        case 3:
            growTime += 6*60;
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_3.png"];
            
        case 4:
            growTime += 6*60;
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_4.png"];
            
        case 5:
            growTime += 6*60;
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_5.png"];
            
        default:
            return [UIImage imageNamed:@"Sweet_Gem_Berry_Stage_6.png"];
    }
}
- (UIImage*) upgradeTulip
{
    switch (plantStage)
    {
        case 2:
            growTime += 2*60;
            return [UIImage imageNamed:@"Tulip_Stage_2.png"];
            
        case 3:
            growTime += 2*60;
            return [UIImage imageNamed:@"Tulip_Stage_3.png"];
            
        case 4:
            growTime += 2*60;
            return [UIImage imageNamed:@"Tulip_Stage_4.png"];
            
        default:
            return [UIImage imageNamed:@"Tulip_Stage_5.png"];
    }
}
@end
