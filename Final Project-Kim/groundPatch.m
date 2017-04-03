//
//  groundPatch.m
//  Final Project-Kim
//
//  Created by ETS Admin on 4/2/17.
//  Copyright © 2017 Joe. All rights reserved.
//
#import "groundPatch.h"
@implementation groundPatch
@synthesize isWatered;
@synthesize isPlanted;
@synthesize growTime;
@synthesize plantTime;
@synthesize lastWatered;
@synthesize location;


- (void) water
{
    isWatered = true;
    lastWatered = [NSDate date];
}

- (void) killPlant
{
    growTime = 0;
    plantTime = 0;
}

- (void) plantObject
{
    isPlanted = true;
    plantTime = [NSDate date];
}

- (void) harvest
{
    plantTime = nil;
    growTime = 0;
    isPlanted = false;
}

- (BOOL) canHarvest
{
    return ([plantTime timeIntervalSinceNow] >= growTime);
}

- (void) saveData
{
    [[NSUserDefaults standardUserDefaults] setBool:isWatered
                                            forKey:[NSString stringWithFormat:@"isWatered%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setBool:isPlanted
                                            forKey:[NSString stringWithFormat:@"isPlanted%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setObject:lastWatered
                                              forKey:[NSString stringWithFormat:@"lastWatered%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setObject:plantTime
                                              forKey:[NSString stringWithFormat:@"plantTime%ld", (long)location]];
    
    [[NSUserDefaults standardUserDefaults] setDouble:growTime
                                              forKey:[NSString stringWithFormat:@"growTime%ld", (long)location]];
}

- (void) loadData
{
    isWatered = [[NSUserDefaults standardUserDefaults] boolForKey:
                    [NSString stringWithFormat:@"isWatered%ld", (long)location]];
    
    isPlanted = [[NSUserDefaults standardUserDefaults] boolForKey:
                    [NSString stringWithFormat:@"isPlanted%ld", (long)location]];
    
    lastWatered = [[NSUserDefaults standardUserDefaults] objectForKey:
                      [NSString stringWithFormat:@"lastWatered%ld", (long)location]];
    
    plantTime = [[NSUserDefaults standardUserDefaults] objectForKey:
                    [NSString stringWithFormat:@"plantTime%ld", (long)location]];
    
    growTime = [[NSUserDefaults standardUserDefaults] doubleForKey:
                 [NSString stringWithFormat:@"growTime%ld", (long)location]];
}

@end
