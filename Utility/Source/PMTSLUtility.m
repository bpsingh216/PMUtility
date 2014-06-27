/*!
 *	PMTSLUtility.h.m
 *	Utility
 *	
 *	Created by B.P.SINGH on 26/06/14.
 *	Copyright 2014 ParallelMinds Technology Solution Pvt.Ltd. All rights reserved.
 */

#import "PMTSLUtility.h"

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

@interface PMTSLUtility()

- (void) privateMethodA;

@end

#pragma mark -
#pragma mark Public Interface
#pragma mark -
//**************************************************
//	Public Interface
//**************************************************

@implementation PMTSLUtility

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

- (void) privateMethodA
{
	NSLog(@"Calling privateMethodA, not visible to the developer");
}

#pragma mark -
#pragma mark Self Public Methods
//**********************************************************************************************************
//
//  Self Public Methods
//
//**********************************************************************************************************

- (void) methodA
{
	NSLog(@"Calling methodA at FIClassA");
}

- (void) methodAWith:(int)anInt
{
	NSLog(@"Calling methodAWith:%i at FIClassA",anInt);
}


@end
