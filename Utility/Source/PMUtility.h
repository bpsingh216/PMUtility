/*!
 *	PmTSLUtility.h
 *	Utility
 *	
 *	Created by B.P.SINGH on 26/06/14.
 *	Copyright 2014 ParallelMinds Technology Solution Pvt.Ltd. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface PMUtility : NSObject
{
@public
	int			_publicInt;
@protected
	int			_protectedInt;
@private
	int			_privateInt;
}

@property (nonatomic) int propertyIntA;
/**
 *  Creates circular image view
 *
 *  @param imageView UIImageView object to be modified as circle view
 *
 *  @return UIImageView with circular property
 */
- (UIImageView*)createCircularImage:(UIImageView*)imageView;
/**
 *  Creates round corner image view
 *
 *  @param imageView  UIImageView object to be modified as round corner view
 *
 *  @return UIImageView with round cor property
 */
- (UIImageView*)createRoundedCornerImage:(UIImageView*)imageView;
/**
 *  Creates circular image with specified border color
 *
 *  @param imageView UIImageView object to be modified as circular view with border color
 *  @param color     specific border color
 *
 *  @return UIImageView with circular and with border color specified.
 */
- (UIImageView*)createCircularImage:(UIImageView*)imageView borderColor:(CGColorRef )color;
/**
 *  Creates round corner image view
 *
 *  @param imageView UIImageView object to be modified as round corner with background
 *  @param color     specific border color
 *
 *  @return UIImageView with rounded and border color specified.
 */
- (UIImageView*)createRoundedCornerImage:(UIImageView*)imageView borderColor:(CGColorRef )color;
@end
