//
//  bagItemTemplate.m
//  Final Project-Kim
//
//  Created by ETS Admin on 4/28/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bagItemTemplate.h"

@interface bagItemTemplate ()

@end

@implementation bagItemTemplate
@synthesize cropImage;
@synthesize coinImage;
@synthesize cropName;
@synthesize cropPrice;
@synthesize amount;

-(bagItemTemplate*) init
{
    bagItemTemplate * bit = [super init];
    
    return bit;
}
@end
