//
//  PMValidator.m
//  Utility
//
//  Created by B.P.SINGH on 30/07/14.
//  Copyright (c) 2014 ParallelMinds Technology Solution Pvt. Ltd. All rights reserved.
//

#import "PMValidator.h"
#define allTrim(object) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]

#define MAX_AMOUNT 100000000000000
#define ONE_YEAR   31574126
#define SECONDS 3600
#define MINUTES 60
#define INVALID_DATE @"Invalid Date"
@implementation PMValidator



+ (BOOL) validateBlankTexfield :(NSString *)textFieldText {
    
    if ([textFieldText length] == 0 || [textFieldText isEqualToString:@""] ) {
        /**
         *  UITextField is blank.
         */
        return NO;
    }
    /**
     *  UITextField is not blank.
     */
    return YES;
}

+ (BOOL) validateEmailTextField :(NSString *)textFieldText {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    return [emailTest evaluateWithObject:textFieldText];
}

+ (BOOL) validatePhoneNumber :(NSString *)textFieldText {
    
    if (![self validateBlankTexfield:textFieldText]) {
        return [self validateBlankTexfield:textFieldText];
    }
    
    NSPredicate * Pred = [NSPredicate predicateWithFormat:@"SELF MATCHES '(([+]{1}|[0]{2}){0,1}+[1]{1}){0,1}+[ ]{0,1}+(?:[-( ]{0,1}[0-9]{3}[-) ]{0,1}){0,1}+[ ]{0,1}+[0-9]{2,3}+[0-9- ]{4,8}'"];
    return [Pred evaluateWithObject:textFieldText];
    
}

+ (BOOL) validateName: (NSString *)textFieldText {
    
    NSString *emailRegex = @"[a-zA-z]+([ '-][a-zA-Z]+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:textFieldText];
    return isValid;
}

+ (BOOL) validateZipCode :(NSString *)textFieldText {
    
    NSString *zipRegex = @"^(\\d{5}(-\\d{4})?|[a-z]\\d[a-z][- ]*\\d[a-z]\\d)$";
    NSPredicate *zipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", zipRegex];
    return [zipTest evaluateWithObject:textFieldText];
}



+ (BOOL) numberValidation:(NSString *)textFieldText {
    
    if (![self validateBlankTexfield:textFieldText]) {
        return [self validateBlankTexfield:textFieldText];
    }
    const char *s = textFieldText.UTF8String;
    char *end;
    strtod(s, &end);
    return !end[0];
}

+ (BOOL) yearValidation :(NSString *)textFieldText
{
    if (![self numberValidation:textFieldText]) {
        return [self numberValidation:textFieldText];
    }
    
    BOOL isof4Digit = NO;
    
    if ([textFieldText length] == 4) {
        isof4Digit = YES;
    }
    return isof4Digit;
}

+ (BOOL) alphanumericValidation :(NSString *)textFieldText {
    
    if (![self validateBlankTexfield:textFieldText]) {
        return [self validateBlankTexfield:textFieldText];
    }
    NSCharacterSet *alphaNums = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:textFieldText];
    return [alphaNums isSupersetOfSet:inStringSet];
}

+ (BOOL) lowerCaseValidation :(NSString *)textFieldText {
    
    if (![self validateBlankTexfield:textFieldText]) {
        return [self validateBlankTexfield:textFieldText];
    }
    NSCharacterSet *lowerCase = [NSCharacterSet lowercaseLetterCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:textFieldText];
    return [lowerCase isSupersetOfSet:inStringSet];
}

+ (BOOL) upperCaseValidation :(NSString *)textFieldText {
    
    if (![self validateBlankTexfield:textFieldText]) {
        return [self validateBlankTexfield:textFieldText];
    }
    NSCharacterSet *upperCase = [NSCharacterSet uppercaseLetterCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:textFieldText];
    return [upperCase isSupersetOfSet:inStringSet];
}



+ (BOOL) lengthValidation :(NSString *)textFieldText minTextLength:(NSInteger)minLength maxTextLength:(NSInteger) maxLength {
    
    if (![self validateBlankTexfield:textFieldText]) {
        return [self validateBlankTexfield:textFieldText];
    }
    
    NSInteger textLength = [allTrim(textFieldText) length];
    if ((minLength <= textLength) && (textLength <= maxLength)) {
        /**
         *  String length is appropiate.
         */
        return YES;
    }
    /**
     *  String Length is not appropiate.
     */
    return NO;
}

+ (BOOL) dateComparison:(NSString *)textFieldText compairingDateString:(NSString *)textFieldText1 twoYearCheck:(BOOL) isTwoYear {
    
    BOOL resultOfComparison;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate * dateFromString = [dateFormatter dateFromString:textFieldText];
    
    if (isTwoYear) {
        NSDate * dateFromString1 = [dateFormatter dateFromString:textFieldText1];
        NSComparisonResult result = [dateFromString compare:dateFromString1];
        switch (result)
        {
            case NSOrderedDescending:
                /**
                 *  Compairing Date is previous
                 */
                resultOfComparison =  NO;
                break;
            case -1: resultOfComparison =  YES;
                break;
            case NSOrderedSame: resultOfComparison =  YES;
                break;
            default:
                resultOfComparison =  NO;
                break;
        }
    }
    else{
        
        resultOfComparison = NO;
    }
    return resultOfComparison;
}

+ (BOOL) stringContainingSetOfCharacters :(NSString *)textFieldText stringSetArray :(NSArray *) stringArray {
    
    if (![self validateBlankTexfield:textFieldText]) {
        return [self validateBlankTexfield:textFieldText];
    }
    
    if (stringArray == nil) {
        return NO;
    }
    
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[textFieldText length]];
    for (int i=0; i < [textFieldText length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [textFieldText characterAtIndex:i]];
        [characters addObject:ichar];
    }
    
    NSMutableSet *intersection = [NSMutableSet setWithArray:[NSArray arrayWithArray:characters]];
    
    [intersection intersectSet:[NSSet setWithArray:stringArray]];
    
    NSInteger intersectionCount = [[intersection allObjects] count];
    if (intersectionCount > 0) {
        return YES;
    }
    return NO;
}




// Time zone
/**
 *  Get system time zone
 *
 *  @return string with system time zone
 */
+(NSString *)getSystemtimeZone
{
    //*******************************************
    // SM CSI:286 Null exception for systemtimezone
    NSString *timeZoneKey= @"";
    @try
    {
        NSString* systemTimeZone = [[NSTimeZone systemTimeZone] name];
        NSDictionary *timeZonesListDictionary = [NSTimeZone abbreviationDictionary];
        //To fix for IST timezone issue (Asia/Calcutta  and Asia/Kolkata
        if([systemTimeZone isEqualToString:@"Asia/Kolkata"])
            systemTimeZone = @"Asia/Calcutta";
        timeZoneKey = [[timeZonesListDictionary allKeysForObject:systemTimeZone] lastObject];
        //NSLog(@"abbrev = %@",timeZoneKey);
        
    }
    @catch (NSException *exception) {
        timeZoneKey = @"";
        //NSLog(@"Value Not Present in Dictionary");
    }
    @finally {
        
    }
    return timeZoneKey;
}

/**
 *  Convert Time from any time zone to system time zone
 *
 *  @param toBeconvertedTimeZone time zone of present time
 *  @param saleTime              time to be converted
 *
 *  @return converted time in HHmm format
 */
+(NSString *)convertTimeFromParticularTimeZoneToSystemTimeZone:(NSString *)timeZone andTime:(NSString *)saleTime
{
    // Change SM : For change request for Change in Webservice response
    //Convert Time to 0030 format
    
    NSString *extractedString = @"";
    NSRange r = NSMakeRange(0, 7);
    extractedString = [saleTime substringWithRange: r];
    //find timezone name
    // Fix for proper timezone
    
    NSDictionary *timeZonesListDictionary = [NSTimeZone abbreviationDictionary];
    //To fix for IST timezone issue (Asia/Calcutta  and Asia/Kolkata
    if([timeZone isEqualToString:@"Asia/Kolkata"])
        timeZone = @"Asia/Calcutta";
    NSString *timeZoneKey = [timeZonesListDictionary objectForKey:timeZone];
    //NSLog(@"abbrev = %@",timeZoneKey);
    // 12 hour format
    NSDateFormatter* convertTo12Hour = [[NSDateFormatter alloc]init];
    [convertTo12Hour setTimeZone:[NSTimeZone timeZoneWithName:timeZoneKey]];
    [convertTo12Hour setDateFormat:@"hh:mma"];
    
    //24 hour format
    NSDate* convertTo12HourDate = [convertTo12Hour dateFromString:extractedString];
    [convertTo12Hour setDateFormat:@"HHmm"];
    NSString *convertedTime = [convertTo12Hour stringFromDate:convertTo12HourDate];
    
    
    NSDateFormatter* systemTime = [[NSDateFormatter alloc] init];
    [systemTime setTimeZone:[NSTimeZone systemTimeZone]];
    [systemTime setDateFormat:@"HHmm"];
    
    // timeto be converted in timezone
    NSDateFormatter* timeZoneToBeconverted = [[NSDateFormatter alloc] init];
    [timeZoneToBeconverted setTimeZone:[NSTimeZone timeZoneWithName:timeZoneKey]];
    [timeZoneToBeconverted setDateFormat:@"HHmm"];
    
    
    NSDate* timeToBeConverted = [timeZoneToBeconverted dateFromString:convertedTime];
    //NSLog(@"%@",timeToBeConverted);
    //final time conversion
    
    NSString *calculatedTime = [systemTime stringFromDate:timeToBeConverted];
    return calculatedTime;
    
}

/**
 *  Display Time in 12 hour format - 12:00 pm
 *
 *  @param inputTime time from web service response
 *
 *  @return Time in 12 hour format
 */
+(NSString *)displayTimeInAmPM:(NSString *)inputTime
{
    if(![inputTime isKindOfClass:[NSNull class]])
    {
        NSDateFormatter *responseTimeFormatter = [[NSDateFormatter alloc] init];
        if(inputTime.length == 4)
            [responseTimeFormatter setDateFormat:@"HHmm"];
        else
            [responseTimeFormatter setDateFormat:@"HHmmss"];
        NSDate * responseTime = [responseTimeFormatter dateFromString:inputTime];
        NSDateFormatter* systemTimeFormatter = [[NSDateFormatter alloc] init];
        [systemTimeFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [systemTimeFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [systemTimeFormatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
        NSDate* newDate = [systemTimeFormatter dateFromString:[systemTimeFormatter stringFromDate:responseTime]];
        [systemTimeFormatter setDateFormat:@"hh:mm a"];
        NSString *displayTime = [systemTimeFormatter stringFromDate:newDate];
        return displayTime;
        
    }
    else
        return @"";
}

/**
 *  Display Date in Month DD,YYYY format
 *
 *  @param inputDate date to be displayed
 *
 *  @return date in above format
 */

+(NSString *)displayDateInParticularFormat:(NSString *)inputDate
{
    NSDateFormatter *responseDateFormatter = [[NSDateFormatter alloc] init];
    [responseDateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate * dateFromString = [responseDateFormatter dateFromString:inputDate];
    
    NSString *displayDate = @"";
    NSDateFormatter *displayDateFormatter = [[NSDateFormatter alloc]init];
    [displayDateFormatter setDateStyle:NSDateFormatterLongStyle]; // day, Full month and year
    [displayDateFormatter setDateFormat:@"MMMM dd, YYYY"];
    displayDate = [displayDateFormatter stringFromDate:dateFromString];
    return displayDate;
}

// display date in mm/dd/yyyy
+(NSString *)displayDateInMMDDYYYYFormat:(NSString *)inputDate
{
    NSDateFormatter *responseDateFormatter = [[NSDateFormatter alloc] init];
    [responseDateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate * dateFromString = [responseDateFormatter dateFromString:inputDate];
    
    NSString *displayDate = @"";
    NSDateFormatter *displayDateFormatter = [[NSDateFormatter alloc]init];
    [displayDateFormatter setDateStyle:NSDateFormatterLongStyle]; // day, Full month and year
    [displayDateFormatter setDateFormat:@"mm/dd/yyyy"];
    displayDate = [displayDateFormatter stringFromDate:dateFromString];
    return displayDate;
}


+(NSString*)calculateDays:(NSString *)inputDate
{
    // extract today's date from current date string
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSDate *startDate = [NSDate date];
    NSString *dateStr = [dateFormat stringFromDate:startDate];
    NSDate *systemDate = [dateFormat dateFromString:dateStr];
    NSLog(@"%@",systemDate);
    NSDate *endDate = [dateFormat dateFromString:inputDate];
    NSLog(@"%@",endDate);
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:systemDate
                                                          toDate:endDate
                                                         options:0];
    
    
    NSString *days;
    
    if (components.day >=1 && components.day <=9) {
        
        days = [NSString stringWithFormat:@"0%dd",components.day];
    }else if (components.day < 0)
    {
        
        days = [NSString stringWithFormat:@"0d"];
        
    }
    else
    {
        days = [NSString stringWithFormat:@"%dd",components.day];
        
        
    }
    
    
    return days;
}
@end
