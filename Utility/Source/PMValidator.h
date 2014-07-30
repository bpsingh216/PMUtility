//
//  PMValidator.h
//  Utility
//  This class is written for validation purpose
//  Created by B.P.SINGH on 30/07/14.
//  Copyright (c) 2014 ParallelMinds Technology Solution Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMValidator : NSObject


/**
 *  Validates UITextField
 *
 *  @param textFieldText UITextField object to be validated for empty field
 *
 *  @return Boolean value
 */
+ (BOOL) validateBlankTexfield :(NSString *)textFieldText;
/**
 *  Validate UITextField text
 *
 *  @param textFieldText text string to be validated for correct email id
 *
 *  @return Boolean value
 */
+ (BOOL) validateEmailTextField :(NSString *)textFieldText;
/**
 *  Validates UITextField
 *
 *  @param textFieldText text string to be validated for correct phone number
 *
 *  @return Boolean value
 */
+ (BOOL) validatePhoneNumber :(NSString *)textFieldText;
/**
 *  Validates UITextField
 *
 *  @param textFieldText text string to be validated for correct name
 *
 *  @return Boolean value
 */
+ (BOOL) validateName: (NSString *)textFieldText;
/**
 *  Validates UITextField
 *
 *  @param textFieldText text string to be validated for correct zip code
 *
 *  @return Boolean value
 */
+ (BOOL) validateZipCode :(NSString *)textFieldText;
/**
 *  Validates UITextField
 *
 *  @param textFieldText text string to be validated for correct number
 *
 *  @return Boolean value
 */
+ (BOOL) numberValidation:(NSString *)textFieldText;
/**
 *  Validates UITextField
 *
 *  @param textFieldText text string to be validated for year
 *
 *  @return Boolean value
 */
+ (BOOL) yearValidation :(NSString *)textFieldText;
/**
 *  Validates UITextField
 *
 *  @param textFieldText text string to be validated for correct alphanumeric format
 *
 *  @return Boolean value
 */
+ (BOOL) alphanumericValidation :(NSString *)textFieldText;
/**
 *  Validates UITextField
 *
 *  @param textFieldText text string to be validated for lowercase format
 *
 *  @return Boolean value
 */
+ (BOOL) lowerCaseValidation :(NSString *)textFieldText;
/**
 *  Validates UITextField
 *
 *  @param textFieldText text string to be validated for uppercase format
 *
 *  @return Boolean value
 */
+ (BOOL) upperCaseValidation :(NSString *)textFieldText;
/**
 *  Validate Length
 *
 *  @param textFieldText text to calculate length
 *  @param minLength     minimum length criteria
 *  @param maxLength     maximum length criteria
 *
 *  @return Boolean value
 */
+ (BOOL)lengthValidation :(NSString *)textFieldText minTextLength:(NSInteger)minLength maxTextLength:(NSInteger) maxLength;
/**
 *  Validate whether string contains specified characters or not
 *
 *  @param textFieldText string
 *  @param stringArray   character array
 *
 *  @return Boolean value
 */
+ (BOOL) stringContainingSetOfCharacters :(NSString *)textFieldText stringSetArray :(NSArray *) stringArray;
/**
 *  Get system time zone
 *
 *  @return string with system time zone
 */
+(NSString *)getSystemtimeZone;

/**
 *  Convert Time from any time zone to system time zone
 *
 *  @param toBeconvertedTimeZone time zone of present time
 *  @param saleTime              time to be converted
 *
 *  @return converted time in HHmm format
 */
+ (NSString *)convertTimeFromParticularTimeZoneToSystemTimeZone:(NSString *)timeZone andTime:(NSString *)saleTime;

/**
 *  Display Time in 12 hour format - 12:00 pm
 *
 *  @param inputTime time from web service response
 *
 *  @return Time in 12 hour format
 */
+ (NSString *)displayTimeInAmPM:(NSString *)inputTime;

/**
 *  Display Date in Month DD,YYYY format
 *
 *  @param inputDate date to be displayed
 *
 *  @return date in above format
 */

+ (NSString *)displayDateInParticularFormat:(NSString *)inputDate;
/**
 *  Display date in mm/dd/yyyy
 *
 *  @param inputDate inputDate date to be displayed
 *
 *  @return date in above format
 */
+ (NSString *)displayDateInMMDDYYYYFormat:(NSString *)inputDate;
/**
 *  Calculate total days from specified data
 *
 *  @param inputDate date
 *
 *  @return returns days string
 */
+ (NSString*)calculateDays:(NSString *)inputDate;

@end
