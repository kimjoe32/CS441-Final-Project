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
    _amountLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    
    _itemImageView.image = [item getImageForType];
    _amountLabel.text = [NSString stringWithFormat:@"%ld", _amount];
    
    //make label to represent amount of seeds
    CGRect frame = _amountLabel.frame;
    frame.origin.y += 40;
    _amountLabel.frame = frame;
    
    _plantInfo = item;
    _itemImageView.backgroundColor = [UIColor whiteColor];
    UIFont *font = _amountLabel.font;
    _amountLabel.font = [font fontWithSize:24];
    _amountLabel.textColor = [UIColor redColor];
    
    
    //give cells shadows and border
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
    
    [self.contentView addSubview:_itemImageView];
    [self.contentView addSubview:_amountLabel];
}

- (void) updateAmount
{
    //update label that displays amount of available seeds
    _amountLabel.text = [NSString stringWithFormat:@"%ld", _amount];
}
@end
