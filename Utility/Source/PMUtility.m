/*!
 *	PMTSLUtility.h.m
 *	Utility
 *	
 *	Created by B.P.SINGH on 26/06/14.
 *	Copyright 2014 ParallelMinds Technology Solution Pvt.Ltd. All rights reserved.
 */

#import "PMUtility.h"

#pragma mark -
#pragma mark Constants
#pragma mark -
//**************************************************
//  Constants
//**************************************************


#pragma mark -
#pragma mark Private Interface
#pragma mark -
//**************************************************
//	Private Interface
//**************************************************

@interface PMUtility()

- (void) privateMethodA;

@end

#pragma mark -
#pragma mark Public Interface
#pragma mark -
//**************************************************
//	Public Interface
//**************************************************

@implementation PMUtility

#pragma mark -
#pragma mark Properties
//**************************************************
//  Properties
//**************************************************

@synthesize propertyIntA;

#pragma mark -
#pragma mark Constructors
//**************************************************
//  Constructors
//**************************************************

- (id)init
{
	if ((self = [super init]))
	{
		// Initialization code here.
	}
	
	return self;
}

#pragma mark -
#pragma mark Private Methods
//**********************************************************************************************************
//
//  Private Methods
//
//**********************************************************************************************************



#pragma mark -
#pragma mark Self Public Methods
//**********************************************************************************************************
//
//  Self Public Methods
//
//**********************************************************************************************************

-(UIImageView*)createCircularImage:(UIImageView*)imageView{
    
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.clipsToBounds = YES;
    return imageView;
}
-(UIImageView*)createRoundedCornerImage:(UIImageView*)imageView{
    
    imageView.layer.cornerRadius = 10.0f;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.clipsToBounds = YES;
    
    
    return imageView;
}
-(UIImageView*)createCircularImage:(UIImageView*)imageView borderColor:(CGColorRef )color{
    
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = color;//[UIColor whiteColor].CGColor;
    imageView.clipsToBounds = YES;
    return imageView;
}
-(UIImageView*)createRoundedCornerImage:(UIImageView*)imageView borderColor:(CGColorRef )color{
    
    imageView.layer.cornerRadius = 10.0f;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = color;
    imageView.clipsToBounds = YES;
    return imageView;
}


@end
