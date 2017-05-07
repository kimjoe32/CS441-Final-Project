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
    _itemImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_itemImageView];
    _itemImageView.image = [item getImageForType];
    _plantInfo = item;
    _itemImageView.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [UIColor brownColor].CGColor;
    
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOpacity = 0.75f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.clipsToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    
    self.layer.shouldRasterize = YES;
}

-(void) addItem: (plantInfo*) plant
         amount:(NSInteger*) amount
{
    
}
@end
