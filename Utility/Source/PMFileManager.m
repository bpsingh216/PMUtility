//
//  PMFileManager.m
//  Utility
//
//  Created by B.P.SINGH on 27/06/14.
//  Copyright (c) 2014 ParallelMinds Technology Solution Pvt. Ltd. All rights reserved.
//

#import "PMFileManager.h"

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

@interface PMFileManager()
@end


#pragma mark -
#pragma mark Public Interface
#pragma mark -
//**************************************************
//	Public Interface
//**************************************************

@implementation PMFileManager
#pragma mark -
#pragma mark Properties
//**************************************************
//  Properties
//**************************************************

#pragma mark -
#pragma mark Singleton Method

+ (id)sharedFileManager {
    static PMFileManager *sharedFileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFileManager = [[self alloc] init];
    });
    return sharedFileManager;
}

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


/**
 *  Determining If A File Exists
 *
 *  @param fileName file name to be searched
 *
 *  @return return true if file exists ,false otherwise.
 */
+ (BOOL) isFileExists:(NSString*)fileName
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists=NO;
    NSString *pathAndFileName = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if ([[NSFileManager defaultManager] fileExistsAtPath:pathAndFileName])
    {
        NSLog(@"File exists in Main BUNDLE");
        fileExists=YES;
    }
    else
    {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
        fileExists = [fileManager fileExistsAtPath:filePath];
        if (!fileExists) {
            fileExists=NO;
            NSLog(@"File not found");
        }else{
            NSLog(@"File exists in Document directory");
        }
        
    }
    return fileExists;
}
/**
 *  Getting all files in app budle with specified path Extension
 *
 *  @param pathExtension  predicate String created as @"pathExtension == 'png'"
 *   e.g. NSString *pathExtension =@"pathExtension == 'png'";
 */
+ (NSMutableArray*)getAllFilesFromAppBundleWithPathExtension:(NSString *)pathExtension{
    NSMutableArray *fileURLs=[[NSMutableArray alloc]init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
    NSArray *contents = [fileManager contentsOfDirectoryAtURL:bundleURL
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:nil];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:pathExtension];
    for (NSURL *fileURL in [contents filteredArrayUsingPredicate:predicate]) {
        // Enumerate each .* file in directory
        [fileURLs addObject:fileURL];
    }
    return fileURLs;
}
/**
 *  Creating directory
 *
 *  @param name directory name
 */
+ (void)createDirectoryWithName:(NSString *)name{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [documentsPath stringByAppendingPathComponent:name];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
}
/**
 *  Deleting a File
 *
 *  @param fileNameWithExtension file name with extentension to be deleted
 */
+ (void)deleteFileWithName:(NSString *)fileNameWithExtension{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileNameWithExtension];
    NSError *error = nil;
    
    if (![fileManager removeItemAtPath:filePath error:&error]) {
        NSLog(@"[Error] %@ (%@)", error, filePath);
    }
}
/**
 *  Determining the Creation Date of a File
 *
 *  @param fileName file name with extension for which creationg Date to be identified.
 *
 *  @return NSDate representation
 */
+ (NSDate *)getCreationDateOfFile:(NSString *)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    NSDate *creationDate = nil;
    if ([fileManager fileExistsAtPath:filePath]) {
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath error:nil];
        creationDate = attributes[NSFileCreationDate];
    }
    return creationDate;
}
#pragma mark -
#pragma mark UserDefault Methods
/**
 *  Saving data to NSUserDefaults
 *
 *  @param object any object
 *  @param key    key name for the object to be saved.
 */
+ (void)saveObjectToUserDefault:(id)object forKey:(NSString *)key{
    //For saving
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
 }
/**
 *  Retrieving data from NSUserDefaults
 *
 *  @param key keyname for which object to be returned.
 *
 *  @return object any object
 */
+ (id)retrievingObjectFromUserDefaultForKey:(NSString *)key{
    id result=nil;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    result= [defaults objectForKey:key];
    return result;
}
#pragma mark -
#pragma mark Plist  Methods
/**
 *  Reading a data from Plist
 *
 *  @param filename name of Plist to which data is returned after receiving the resposne
 *
 *  @return resultant dictionary read from plist
 */

-(NSMutableDictionary *)readDataFromPlist:(NSString *)filename
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    
    // *********************************************************************************************************
    
    NSMutableDictionary *rootDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    // //NSLog(@"rootDictionary = %@",rootDictionary);
    return rootDictionary;
}

/**
 *  Reading a data from Plist (Document Direcory)
 *
 *  @param filePath document Directory file path
 *
 *  @return resultant dictionary read from plist
 */

- (NSMutableDictionary *)readDataFromPlsitinDocDirectoryWithpath:(NSString *)filePath
{
    NSMutableDictionary *rootDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    return rootDictionary;
}
/**
 *  Saving data to PList
 *
 *  @param filename name of Plist to which data is saved after receiving the resposne
 *  @param urlName  name of URL from which data is retrieved
 *  @param responseString json response from server is stored in string
 */

-(void)writeDataToPlist:(NSString *)fileName forKeyName:(NSString *)keyName andResponseString:(NSString *)responseString
{
    if (responseString != nil)
    {
        
        NSString *savedPath = [self filePathInDocDirectory:[NSString stringWithFormat:@"%@.plist",fileName]];
        
        NSString *plistpath = @"";
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:savedPath])
            plistpath = savedPath;
        else
            plistpath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        
        NSMutableDictionary *rootDictionaryBase = [[NSMutableDictionary alloc] initWithContentsOfFile:plistpath];
        responseString = [responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"nil\""];
        
        NSData * jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        NSMutableDictionary *rootDictionary = [[NSMutableDictionary alloc]initWithDictionary:json];
        
        [rootDictionaryBase setObject:rootDictionary forKey:keyName];
        
        [rootDictionaryBase writeToFile:savedPath atomically:YES];
    }
    else
    {
        NSLog(@"PMFileManagerLog: FAILURE For key -> %@",keyName);
    }
}
/**
 *  Get file path which is in document directory
 *
 *  @param filename name of Plist
 */
- (NSString *)filePathInDocDirectory:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    return savedPath;
}
/**
 *  Remove specified Plist file from document directory
 *
 *  @param filename name of Plist
 */
- (void)removePlistFileFromDocDirectory:(NSString *)fileName
{
    @try {
        NSString *savedPath = [self filePathInDocDirectory:[NSString stringWithFormat:@"%@.plist",fileName]];
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        
        if([fileManager fileExistsAtPath:savedPath]) {
            [fileManager removeItemAtPath:savedPath error:&error];
            //NSLog(@"error = %@",[error description]);
        }
    }
    @catch (NSException *exception) {
        //NSLog(@"File removing Exception = %@",exception);
    }
    
}

@end
