/*!
 *	PmTSLUtility.h
 *	Utility
 *	
 *	Created by B.P.SINGH on 26/06/14.
 *	Copyright 2014 ParallelMinds Technology Solution Pvt.Ltd. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface PMTSLUtility : NSObject
{
@public
	int			_publicInt;
@protected
	int			_protectedInt;
@private
	int			_privateInt;
}

@property (nonatomic) int propertyIntA;

- (void) methodA;

- (void) methodAWith:(int)anInt;

@end
