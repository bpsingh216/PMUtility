//
//  PMFileManager.h
//  Utility
//  PMFileManager
//  Responsible for dealing with NSFileManager for simple and quick implementation of files
//  Intentially designed for persisting data with plist ,userdefault
//  Created by B.P.SINGH on 27/06/14.
//  Copyright (c) 2014 ParallelMinds Technology Solution Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMFileManager : NSObject
/**
 *  Adopting singleton machanism
 *
 *  @return returns singleton object for this class.
 */
+ (id)sharedFileManager;

/**
 *  Determining If A File Exists
 *
 *  @param fileName file name to be searched
 *
 *  @return return true if file exists ,false otherwise.
 */
+ (BOOL) isFileExists:(NSString*)fileName;
/**
 *  Getting all files in app budle with specified path Extension
 *
 *  @param pathExtension  predicate String created as @"pathExtension == 'png'"
 *   e.g. NSString *pathExtension =@"pathExtension == 'png'";
 */
+ (NSMutableArray*)getAllFilesFromAppBundleWithPathExtension:(NSString *)pathExtension;
/**
 *  Creating directory
 *
 *  @param name directory name
 */
+ (void)createDirectoryWithName:(NSString *)name;
/**
 *  Deleting a File
 *
 *  @param fileNameWithExtension file name with extentension to be deleted
 */
+ (void)deleteFileWithName:(NSString *)fileNameWithExtension;
/**
 *  Determining the Creation Date of a File
 *
 *  @param fileName file name with extension for which creationg Date to be identified.
 *
 *  @return NSDate representation
 */
+ (NSDate *)getCreationDateOfFile:(NSString *)fileName;
/**
 *  Saving data to NSUserDefaults
 *
 *  @param object any object
 *  @param key    key name for the object to be saved.
 */
+ (void)saveObjectToUserDefault:(id)object forKey:(NSString *)key;
/**
 *  Retrieving data from NSUserDefaults
 *
 *  @param key keyname for which object to be returned.
 *
 *  @return object any object
 */
+ (id)retrievingObjectFromUserDefaultForKey:(NSString *)key;

/**
 *  Reading a data from Plist (Main Bundle)
 *
 *  @param filename name of Plist to which data is returned after receiving the resposne
 *
 *  @return resultant dictionary read from plist
 */

-(NSMutableDictionary *)readDataFromPlist:(NSString *)filename;

/**
 *  Reading a data from Plist (Document Direcory)
 *
 *  @param filePath document Directory file path
 *
 *  @return resultant dictionary read from plist
 */

- (NSMutableDictionary *)readDataFromPlsitinDocDirectoryWithpath:(NSString *)filePath;

/**
 *  Saving data to PList
 *
 *  @param filename name of Plist to which data is saved after receiving the resposne
 *  @param urlName  name of URL from which data is retrieved
 *  @param responseString json response from server is stored in string
 */

-(void)writeDataToPlist:(NSString *)fileName forKeyName:(NSString *)keyName andResponseString:(NSString *)responseString;

/**
 *  Get file path which is in document directory
 *
 *  @param filename name of Plist
 */
- (NSString *)filePathInDocDirectory:(NSString *)fileName;

/**
 *  Remove specified Plist file from document directory
 *
 *  @param filename name of Plist
 */
- (void)removePlistFileFromDocDirectory:(NSString *)fileName;
@end
