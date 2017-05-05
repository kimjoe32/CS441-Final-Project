//
//  bagController.m
//  Final Project-Kim
//
//  Created by ETS Admin on 5/4/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import "bagController.h"

@implementation bagItemCell

- (void)setBagItem:(plantInfo *)item
{
    _itemImageView.image = [item getImageForType];
    _plantInfo = item;
}

-(void) addItem: (plantInfo*) plant
         amount:(NSInteger*) amount
{
    
}
@end
