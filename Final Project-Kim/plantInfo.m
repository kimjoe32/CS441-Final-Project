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
@synthesize price;

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
    price = 0;
}

- (void) plantCrop: (plantTypes) type
{
    isPlanted = true;
    plantTime = [NSDate date];
    plantType = type;
    plantStage = 1;
    
    switch(type)
    {
        case EMPTY:
            price = 0;
            growTime = 0;
            
        case CAULIFLOWER:
            price = 175;
            growTime += 1*60;
            
        case MELON:
            price = 250;
            growTime += 1*60;
            
        case POTATO:
            price = 80;
            growTime += 1*60;
            
        case PUMPKIN:
            price = 320;
            growTime += 1*60;
            
        case RADISH:
            price = 90;
            growTime += 2*60;
            
        case SUNFLOWER:
            price = 80;
            growTime += 1*60;
            
        case SWEETGEMBERRY:
            price = 3000;
            growTime += 1*60;
            
        case TULIP:
            price = 30;
            growTime += 1*60;
    }
}

- (void) harvest
{
    plantTime = nil;
    growTime = 0;
    isPlanted = false;
    plantType = EMPTY;
    plantStage = 0;
    price = 0;
}

- (UIImage*) upgrade
{
    plantStage++;
    switch(plantType)
    {
        case EMPTY:
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
        case EMPTY:
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
    
    [[NSUserDefaults standardUserDefaults] setObject:plantTime
                                              forKey:[NSString stringWithFormat:@"plantTime%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setObject:lastWatered
                                              forKey:[NSString stringWithFormat:@"lastWatered%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:plantType
                                               forKey:[NSString stringWithFormat:@"plantType%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:plantStage
                                               forKey:[NSString stringWithFormat:@"plantStage%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:price
                                               forKey:[NSString stringWithFormat:@"price%ld", (long)location]];
}

- (void) loadData
{
    isWatered = [[NSUserDefaults standardUserDefaults] boolForKey:
                 [NSString stringWithFormat:@"isWatered%ld", (long)location]];
    
    isPlanted = [[NSUserDefaults standardUserDefaults] boolForKey:
                 [NSString stringWithFormat:@"isPlanted%ld", (long)location]];
    
    growTime = [[NSUserDefaults standardUserDefaults] doubleForKey:
                [NSString stringWithFormat:@"growTime%ld", (long)location]];

    plantTime = [[NSUserDefaults standardUserDefaults] objectForKey:
                 [NSString stringWithFormat:@"plantTime%ld", (long)location]];
    
    lastWatered = [[NSUserDefaults standardUserDefaults] objectForKey:
                   [NSString stringWithFormat:@"lastWatered%ld", (long)location]];
    
    plantType = (int) [[NSUserDefaults standardUserDefaults] integerForKey:
                       [NSString stringWithFormat:@"plantType%ld", (long)location]];
    
    plantStage = (int) [[NSUserDefaults standardUserDefaults] integerForKey:
                       [NSString stringWithFormat:@"plantStage%ld", (long)location]];
    
    price = (int) [[NSUserDefaults standardUserDefaults] integerForKey:
                       [NSString stringWithFormat:@"price%ld", (long)location]];
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
